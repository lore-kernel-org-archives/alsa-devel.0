From: Giuliano Pochini <pochini@shiny.it>
Subject: Kernel crash
Date: Sun, 5 Sep 2004 20:51:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040905205122.79b74eb3.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__5_Sep_2004_20_51_22_+0200_xK3TByN=PQtvJ_hg"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart=_Sun__5_Sep_2004_20_51_22_+0200_xK3TByN=PQtvJ_hg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit



10 days passed since the last time I wrote about this problem... but the
problems is still here. Perhaps I didn't explain clearly enough. The program
I attached was buggy, but I meant it makes the kernel crash, not the program
itself. It's attached again to this message. No need to be root. IMHO it's a
quite serious issue the should be fixed ASAP.

It successfully crashes my system after a few attempts:

Linux Jay 2.6.8.1 #2 SMP Wed Aug 18 15:14:51 CEST 2004 ppc unknown
booted with maxcpus=1 and without preempt.
alsa-driver-1.0.6a and CVS-2004-09-05
alsa-lib-1.0.4
gcc 3.4.1

with both the powermac (Snapper) driver and my Echoaudio driver.

I also tested it on a PC with an intel8x1 chip, but I don't know the version
of alsa. Probably 1.0.2. It's the one include with linux 2.6.7-13-mandrake
edition. On this system the kernel doesn't crash nor it oopses, but often
the sound doesn't stop after my proggy segfaults.


--
Giuliano.


--Multipart=_Sun__5_Sep_2004_20_51_22_+0200_xK3TByN=PQtvJ_hg
Content-Type: text/plain;
 name="playrec.c"
Content-Disposition: attachment;
 filename="playrec.c"
Content-Transfer-Encoding: 7bit


#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <sys/poll.h>

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API
#include <alsa/asoundlib.h>



int samplerate = 44100, periods = 2, periodframes = 4096;
typedef struct {
    int16_t frame[2];
  } sample_t;

#define NCH 2

#define TEST(err) do { if (err<0) { printf("Error: %s at line %d\n", snd_strerror(err), __LINE__); return 0; } } while(0)

snd_pcm_t *init_channel(const char *pcm_name, snd_pcm_stream_t stream) {
  int n, err;
  snd_pcm_hw_params_t *hwparams;
  snd_pcm_sw_params_t *swparams;
  snd_pcm_t *pcm_handle;

  snd_pcm_hw_params_alloca(&hwparams);
  snd_pcm_sw_params_alloca(&swparams);

  err = snd_pcm_open(&pcm_handle, pcm_name, stream, SND_PCM_NONBLOCK);
  TEST(err);

  /* Init hwparams with full configuration space */
  err = snd_pcm_hw_params_any(pcm_handle, hwparams);
  TEST(err);

//  printf("snd_pcm_hw_params_can_sync_start: %d\n", snd_pcm_hw_params_can_sync_start(hwparams));
//  return(0);

  err = snd_pcm_hw_params_set_access(pcm_handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED);
  TEST(err);

  /* Set sample format */
  err = snd_pcm_hw_params_set_format(pcm_handle, hwparams, SND_PCM_FORMAT_S16_BE);
  TEST(err);

  /* Set sample rate. If the exact rate is not supported */
  /* by the hardware, use nearest possible rate.         */
  n = samplerate;
  snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, &samplerate, 0);
  if (n != samplerate) {
    fprintf(stderr, "The rate %d Hz is not supported by your hardware.\nUsing %d Hz instead.\n", n, samplerate);
  }

  /* Set number of channels */
  err = snd_pcm_hw_params_set_channels(pcm_handle, hwparams, 2);
  TEST(err);

  /* Set number of periods. Periods used to be called fragments. */
  err = snd_pcm_hw_params_set_periods(pcm_handle, hwparams, periods, 0);
  TEST(err);

  err = snd_pcm_hw_params_set_buffer_size(pcm_handle, hwparams, periodframes * periods);
  TEST(err);

  err = snd_pcm_hw_params(pcm_handle, hwparams);
  TEST(err);


  if (stream == SND_PCM_STREAM_PLAYBACK) {
    err = snd_pcm_sw_params_current(pcm_handle, swparams);
    TEST(err);
    err = snd_pcm_sw_params_set_start_threshold(pcm_handle, swparams, 0x7fffffff);
    TEST(err);
  }

//  snd_pcm_hw_params_free(hwparams);
  return (pcm_handle);
}














void Riempibuf(sample_t * buf, float frq, int n) {
  int s;
  static double fase = 0;

  //printf("fase i=%f   ", fase);
  for (s = 0; s < n; s++) {
    buf[s].frame[0] = buf[s].frame[1] = ceil(31000.0 * sin(fase * 2 * M_PI));
//    buf[s].frame[0] = buf[s].frame[1] = ceil(15000.0 * sin(fase * 2 * M_PI) + 15000.0 * sin(fase*2 * 2 * M_PI));
    //buf[s].frame[0] = buf[s].frame[1] = ceil(-32765 + 65530 * fmod(fase, 1));
    //buf[s].frame[0] = buf[s].frame[1] = fmod(fase, 1)>=0.5 ? 15000.0 : -15000.0;
    fase += frq / samplerate;
  }
  //printf("f=%f\n", fase);
  while (fase > 10)  fase -= 10;
}


/*
void Riempibuf(sample_t * buf, float frq, int n) {
  int s;
  static double fase1 = 0, fase2 = 0;

  //printf("fase i=%f   ", fase);
  for (s = 0; s < n; s++) {
    buf[s].frame[0] = buf[s].frame[1] = ceil(15000.0 * sin(fase1 * 2 * M_PI) + 15000.0 * sin(fase2 * 2 * M_PI));
    fase1 += 10000.0 / samplerate;
    fase2 += 11000.0 / samplerate;
  }
}
*/


int writebuf(snd_pcm_t * handle, sample_t * buf, size_t frames) {
  int r, tot;

  tot = 0;
  while (frames > 0) {
    r = snd_pcm_writei(handle, buf + tot, frames);
    if (r == -EAGAIN) {
//      return(0);
      continue;
    } else if (r > 0) {
      frames -= r;
      tot += r;
    } else {
      printf("wr err\n");
      return (r);
    }
  }
//  printf("Scritti %d\n", tot);
  return (0);
}



int main(int argc, char **argv) {
  sample_t *buffer_in, *buffer_out;
  double frq;
  int i, c, r, bufsize, scritti, ricevuti, f;
  int min[NCH], max[NCH];
  snd_pcm_t *pcm_handle_in, *pcm_handle_out;


  pcm_handle_out = init_channel("plughw:0,0,0", SND_PCM_STREAM_PLAYBACK);
  if (!pcm_handle_out)
    return (-1);
  pcm_handle_in = init_channel("plughw:0,0,0", SND_PCM_STREAM_CAPTURE);
  if (!pcm_handle_in)
    return (-1);

  if ((r = snd_pcm_prepare(pcm_handle_out)) < 0) {
    printf("Prepare error: %s\n", snd_strerror(r));
    exit(0);
  }
  if ((r = snd_pcm_prepare(pcm_handle_in)) < 0) {
    printf("Prepare error: %s\n", snd_strerror(r));
    exit(0);
  }

  if ((r = snd_pcm_link(pcm_handle_out, pcm_handle_in)) < 0) {
    printf("Streams link error: %s\n", snd_strerror(r));
    exit(0);
  }
/*
  if (writebuf(pcm_handle_out, buffer_out, BUFR) < 0) {
    fprintf(stderr, "write error\n");
    exit(0);
  }
*/
/*
  if ((r = snd_pcm_start(pcm_handle_in)) < 0) {
    printf("Go error: %s\n", snd_strerror(r));
    exit(0);
  }
*/


  bufsize=samplerate;
  buffer_in=malloc(bufsize * sizeof(sample_t));
  buffer_out=malloc(bufsize * sizeof(sample_t));

  f = open("Merd.raw", O_TRUNC | O_WRONLY | O_CREAT, 0664);
//  for (frq = (float)samplerate / 8192.0; frq <= (float)samplerate / 2; frq *= 1.189207115) {      //frq*=1.414213562) {
  for (frq = 1000; frq <= 10000; frq += 100) {
//  for (frq = 5.0; frq <= (float)samplerate / 2; frq *= sqrt(sqrt(2.0))) {
//int yyy=3;


    // Prepara 1 sec. di roba da suonare
    Riempibuf(buffer_out, frq, bufsize);
    scritti=ricevuti=0;

    while (ricevuti<bufsize) {

      poll(0, 0, 5);
      if (0)
        snd_pcm_wait(pcm_handle_in, 1000);

      if (scritti == bufsize) {
        //snd_pcm_drain(pcm_handle_out);
        printf("spedito\n");
        //write(f, buffer_out + scritti, rimanenti * sizeof(sample_t));
      } else {
        r = snd_pcm_writei(pcm_handle_out, buffer_out+scritti, bufsize-scritti);
        if (r < 0 && r != -EAGAIN) {
          fprintf(stderr, "write error: %s\n", snd_strerror(r));
          exit(r);
        } else if (r > 0) {
          //printf("scr %d   %d\n",r,scritti);
          //write(f, buffer_out + scritti, r * sizeof(sample_t));
          scritti += r;
        }
      }

      do {
        r = snd_pcm_readi(pcm_handle_in, buffer_in+ricevuti, bufsize-ricevuti);
        if (r > 0) {
          write(f, buffer_in, r * sizeof(sample_t));
          ricevuti+=r;
          printf("rice %d (%d)\n", r, ricevuti);
        } else if (r < 0 && r != -EAGAIN) {
          printf("rice err: %s\n", snd_strerror(r));
          exit(r);
        }
      } while (r > 0);

    }

  /* BOOM ! */
  snd_pcm_drain(pcm_handle_out);
  snd_pcm_drop(pcm_handle_in);

/*
  if ((r = snd_pcm_prepare(pcm_handle_out)) < 0) {
    printf("Prepare error: %s\n", snd_strerror(r));
    exit(0);
  }
  if ((r = snd_pcm_prepare(pcm_handle_in)) < 0) {
    printf("Prepare error: %s\n", snd_strerror(r));
    exit(0);
  }
*/

    min[c] = max[c] = 0;

    printf("%f   %f  %f\n", frq, 20 * log10((double)(max[0] - min[0]) / 60000), 20 * log10((double)(max[1] - min[1]) / 60000));
//    printf("Frq=%7.1f   dB: Sin=%6.3f  Des=%6.3f\n", frq, 20 * log10((double)(max[0] - min[0]) / 60000), 20 * log10((double)(max[1] - min[1]) / 60000));
//    printf("Frq=%7.1f  min=%6d    max=%6d     dB: Sin=%6.3f  Des=%6.3f\n", frq, min, max, 20 * log10((double)(max[0] - min[0]) / 60000), 20 * log10((double)(max[1] - min[1]) / 60000));
  }

  close(f);


/*  snd_pcm_drop(pcm_handle_out);
  snd_pcm_drop(pcm_handle_in);*/
  snd_pcm_close(pcm_handle_out);
  snd_pcm_close(pcm_handle_in);
  return (0);
}



--Multipart=_Sun__5_Sep_2004_20_51_22_+0200_xK3TByN=PQtvJ_hg--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
