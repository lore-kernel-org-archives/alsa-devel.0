From: Steve Smith <ssmith@vislab.usyd.edu.au>
Subject: [BUG] Intel8x0 always returns frames available
Date: 06 Aug 2003 14:27:39 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060144059.773.13.camel@piccinini.vislab.usyd.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-WTrVKv79PF/fac9tIfWm"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-WTrVKv79PF/fac9tIfWm
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I have a reproducible problem with the Intel8x0 driver.  The code to
reproduce it is attached.  Basically when the capture is set to a single
channel snd_pcm_status_get_avail() always returns a positive value.  As
there is usually no data waiting this results in a block or EAGAIN when
attempting to read the data, both undesirable.

Some info from /proc/asound while this is running:

ssmith@p0:~$ cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 at 0xd8000c00, irq 17
ssmith@p0:~$
ssmith@p0:~$ cat /proc/asound/I82801DBICH4/pcm0c/sub0/info
card: 0
device: 0
subdevice: 0
stream: CAPTURE
id: Intel ICH
name: Intel 82801DB-ICH4
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
ssmith@p0:~$
ssmith@p0:~$ cat /proc/asound/I82801DBICH4/pcm0c/sub0/hw_params
access: MMAP_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 16000 (16000/1)
period_size: 2666
buffer_size: 5332
tick_time: 10000
ssmith@p0:~$
ssmith@p0:~$ cat /proc/asound/I82801DBICH4/pcm0c/sub0/status
state: RUNNING
trigger_time: 1060143844.854766000
tstamp      : 1060144000.171701000
delay       : 2
avail       : 2
avail_max   : 2
-----
hw_ptr      : 2485656
appl_ptr    : 2485654
ssmith@p0:~$
ssmith@p0:~$ cat /proc/asound/I82801DBICH4/pcm0c/sub0/sw_params
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4
xfer_align: 1
start_threshold: 5332
stop_threshold: 5332
silence_threshold: 0
silence_size: 0
boundary: 1397751808
ssmith@p0:~$

Cheers,
Steve
-- 
Steve Smith			| "I still say using Monopoly tokens
Vislab, University of Sydney	|  in a game of Risk violates the
				|  Geneva convention." - Roadkill

--=-WTrVKv79PF/fac9tIfWm
Content-Disposition: attachment; filename=constantcapture.c
Content-Type: text/x-c; name=constantcapture.c; charset=
Content-Transfer-Encoding: 7bit


#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>
#include <stdio.h>
#include <stdarg.h>


/*
 * Current open audio device
 */

#define TRUE 1
#define FALSE 0

typedef struct _pcm_stream_t {
    snd_pcm_t *handle;
    snd_pcm_uframes_t buffer_size;
    snd_pcm_uframes_t period_size;
    int channels;
} pcm_stream_t;

static struct current_t {
    unsigned bytes_per_block;
    pcm_stream_t rx;
} current;

static void clear_current()
{
    current.rx.handle = NULL;
}


#define CHECKERR(msg) \
{ \
  if (err < 0) \
  { \
    fprintf(stderr, msg ": %s\n", snd_strerror(err)); \
    exit(-1); \
  } \
}


static void  __attribute__((unused)) dump_alsa_current(snd_pcm_t *handle)
{
    int err;
    snd_output_t *out;

    err = snd_output_stdio_attach(&out, stderr, 0);
    snd_output_printf(out, "--- MY IO\n");

    err = snd_pcm_dump_setup(handle, out);

    snd_output_printf(out, "--- SW\n");
    err = snd_pcm_dump_sw_setup(handle, out);

    snd_output_printf(out, "--- HW\n");
    err = snd_pcm_dump_hw_setup(handle, out);

    snd_output_printf(out, "--- DONE\n");
    snd_output_close(out);
}


/* *** Alsa driver implementation. *** */

static int open_stream(pcm_stream_t *stream, snd_pcm_stream_t type)
{
    int err;
    size_t bsize;
    snd_pcm_uframes_t frames;
    unsigned int rrate;
    snd_pcm_hw_params_t *hw_params;
    snd_pcm_sw_params_t *sw_params;

    err = snd_pcm_open(&stream->handle, "plughw:0,0",
                       type, SND_PCM_NONBLOCK);
    CHECKERR("Card open failed");

    snd_pcm_hw_params_alloca (&hw_params);

    err = snd_pcm_hw_params_any (stream->handle, hw_params);
    CHECKERR("Failed to initialise HW parameters");

    err = snd_pcm_hw_params_set_access(stream->handle, hw_params,
                                       SND_PCM_ACCESS_RW_INTERLEAVED);
    CHECKERR("Failed to set interleaved access");

    err = snd_pcm_hw_params_set_format (stream->handle, hw_params,
                                        SND_PCM_FORMAT_S16);
    CHECKERR("Failed to set encoding");

    err = snd_pcm_hw_params_set_channels (stream->handle, hw_params, 1);
    CHECKERR("Failed to set channels");

    rrate = 16000;
    err = snd_pcm_hw_params_set_rate_near (stream->handle, hw_params,
                                           &rrate, 0);
    CHECKERR("Failed to set sample rate");
    if (rrate != 16000) {
        fprintf(stderr, "ALSA rate set to %d when we wanted %d\n",
                rrate, 16000);
        return FALSE;
    }

    // Setup the buffer size. This stuff's all in frames, BTW.  We can't
    // convert with the helper functions at this point as they require
    // a working handle, and ours isn't setup yet. We don't actually do
    // anything with these values anyway.
    bsize = snd_pcm_format_size (SND_PCM_FORMAT_S16, 16000 / 6);
    frames = bsize;
    err = snd_pcm_hw_params_set_buffer_size_near(stream->handle, hw_params,
                                                 &frames);
    CHECKERR("Failed to set buffer size");

    stream->buffer_size = frames;
    printf("Buffer == %d\n", stream->buffer_size);

    frames = bsize / 2;
    err = snd_pcm_hw_params_set_period_size_near(stream->handle, hw_params,
                                                 &frames, 0);
    CHECKERR("Failed to set period size");

    stream->period_size = frames;
    printf("Period == %d\n", stream->period_size);

    err = snd_pcm_hw_params (stream->handle, hw_params);
    CHECKERR("Failed to install HW parameters");


    // ALSA software settings
    snd_pcm_sw_params_alloca(&sw_params);
    err = snd_pcm_sw_params_current(stream->handle, sw_params);
    CHECKERR("Failed to initialise SW params");

    err = snd_pcm_sw_params_set_start_threshold(stream->handle, sw_params,
                                                stream->buffer_size);
    CHECKERR("Failed to set threshold value");

    err = snd_pcm_sw_params_set_avail_min(stream->handle, sw_params, 4);
    CHECKERR("Failed to set min available value");

    err = snd_pcm_sw_params_set_xfer_align(stream->handle, sw_params, 1);
    CHECKERR("Failed to set xfer align value");

    err = snd_pcm_sw_params(stream->handle, sw_params);
    CHECKERR("Failed to set SW params");

    return TRUE;
}


int alsa_audio_open()
{
    int err;

    current.bytes_per_block = 320;

    if (!open_stream(&current.rx, SND_PCM_STREAM_CAPTURE)) {
        fprintf(stderr, "Failed to open device for capture\n");
        return FALSE;
    }

    err = snd_pcm_start(current.rx.handle);
    CHECKERR("Failed to start PCM capture");

    return TRUE;
}

/*
 * Shutdown.
 */
void alsa_audio_close()
{
    int err;

    printf("Closing device\n");

    err = snd_pcm_close(current.rx.handle);
    CHECKERR("Error closing capture PCM");

    clear_current();
}


/*
 * Set options on audio device to be non-blocking.
 */
void alsa_audio_non_block()
{
    int err;
    printf("Set nonblocking\n");

    err = snd_pcm_nonblock(current.rx.handle, TRUE);
    CHECKERR("Error setting RX non-blocking");
}


int alsa_audio_is_ready()
{
    snd_pcm_status_t *status;
    snd_pcm_uframes_t avail;
    int err, bytes;

    snd_pcm_status_alloca(&status);
    err = snd_pcm_status(current.rx.handle, status);
    CHECKERR("Can't get status of rx");

    avail = snd_pcm_status_get_avail(status);
    bytes = snd_pcm_frames_to_bytes(current.rx.handle, avail);
    printf("Audio ready == %d (%d bytes)\n", avail, bytes);

    return (bytes);
}

int alsa_audio_read(unsigned char *buf, int bytes)
{
    snd_pcm_sframes_t frames = snd_pcm_bytes_to_frames(current.rx.handle, bytes);
    snd_pcm_sframes_t fread;
    int err;

    fread = snd_pcm_readi(current.rx.handle, buf, frames);

    if (fread >= 0) {
        // Normal case
        fread = snd_pcm_frames_to_bytes(current.rx.handle, fread);
        printf("Read %d bytes\n", fread);
        return fread;
    }

    // Something happened
    switch (fread)
    {
      case -EAGAIN:
        // Normal when non-blocking
        return 0;

      case -EPIPE:
        printf("Got capture XRUN\n");
        err = snd_pcm_prepare(current.rx.handle);
        CHECKERR("Can't recover from capture overrun");
        return FALSE;

      case -ESTRPIPE:
        printf("Got capture ESTRPIPE\n");
        while ((err = snd_pcm_resume(current.rx.handle)) == -EAGAIN)
            sleep(1);       /* wait until the suspend flag is released */
        if (err < 0) {
            err = snd_pcm_prepare(current.rx.handle);
            CHECKERR("Can't recovery from capture suspend");
        }
        return FALSE;

      default:
        printf("Write failed status=%d: %s\n", snd_strerror(fread));
        return 0;
    }
}


void alsa_audio_wait_for(int delay_ms)
{
    printf("Audio wait %d\n", delay_ms);
    snd_pcm_wait(current.rx.handle, delay_ms);
}



int main()
{
    unsigned char buf[1024];

    clear_current();

    alsa_audio_open();
    alsa_audio_non_block();

    while (1) {
        int avail = alsa_audio_is_ready();
        if (avail) {
            alsa_audio_read(buf, (avail > 1024) ? 1024 : avail);
        } else {
            alsa_audio_wait_for(50);
        }
    }

    return 0;
}

--=-WTrVKv79PF/fac9tIfWm--



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
