From: Andy Wingo <wingo@pobox.com>
Subject: alsa mmap-mode does not block on poll?
Date: Tue, 21 May 2002 12:26:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020521162616.GB17561@jesus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi folks. I have a probably silly issue that will most likely have a
really quick answer. For some reason, polling on a playback fd is not
blocking, even though I set avail_min to be one period's worth (for
example, 1024). Instead it returns immediately, avail_update gives me
something on the order of 16 frames, and I end up busy-waiting until I
have one period's worth of data. Would someone mind taking a look at
this loop? It worked a long time ago, but I can't figure out what the
problem is now. This is with rc1.

The loop is very similar to the one in audioengine and kinda similar to
jack.

Here's the main loop, the pcm state follows:

/* shamelessly stolen from pbd's audioengine and jack alsa_driver.
thanks, paul! */
static void
gst_alsa_loop (GstElement *element)
{
    struct pollfd pfd;
    guint32 i;
    GstAlsa *this = GST_ALSA(element);
    
    g_return_if_fail(this != NULL);
    
    snd_pcm_poll_descriptors (this->handle, &pfd, 1);
    
    if (this->stream == SND_PCM_STREAM_PLAYBACK) {
        pfd.events = POLLOUT | POLLERR;
    } else {
        pfd.events = POLLIN | POLLERR;
    }
    
    do {
        if (poll (&pfd, 1, 1000) < 0) {
            if (errno == EINTR) {
                /* this happens mostly when run
                 * under gdb, or when exiting due to a signal */
                g_print ("EINTR\n");
                continue;
            }
            
            g_warning("poll call failed (%s)", strerror(errno));
            return;
        }
        
        if (pfd.revents & POLLERR) {
            g_warning("alsa: poll reports error.");
            return;
        }
        
        if (pfd.revents == 0) {
            g_print ("poll on alsa %s device \"%s\" timed out\n",
                     this->stream==SND_PCM_STREAM_CAPTURE ? "capture" :
                     "playback",
                     this->device);
            /* timed out, such as when the device is paused */
            continue;
        }
        
        this->avail = snd_pcm_avail_update (this->handle);
        g_print ("snd_pcm_avail_update() = %d\n", (int)this->avail);
        
        if (this->avail < 0) {
            if (this->avail == -EPIPE) {
                gst_alsa_xrun_recovery (this);
                this->avail = 0;
            } else {
                g_warning("unknown ALSA avail_update return value (%d)",
                          (int)this->avail);
                return;
            }
        }
        
        /* round down to nearest period_frames avail */
        this->avail -= this->avail % this->period_frames;

        g_print ("snd_pcm_avail_update(), rounded down = %d\n",
        (int)this->avail);

        /* we need to loop here because the available bytes might not be
         * contiguous */
        while (this->avail) {
            /* changes this->avail, as a side effect */
            if (!gst_alsa_get_channel_addresses (this) < 0) {
                g_error("could not get channels");
                return;
            }
            
            if (this->mute && this->stream == SND_PCM_STREAM_PLAYBACK) {
                for (i = 0; i < this->channels; i++) {
                    if (this->mute & (1<<i)) {
                        gst_alsa_sink_silence_on_channel (this, i,
                        this->buffer_frames);
                    }
                }
            }
            
            if (!this->process(this, this->avail)) {
                g_warning("alsa: something happened while processing
                audio");
                return;
            }
            
            /* we could have released the mmap regions on a state change
            */
            if (this->mmap_open)
                gst_alsa_release_channel_addresses(this);
        }
        gst_element_yield (element);
    } while (TRUE);
}

==============================

Here's a dump of the pcm state for my S16/44100/stereo test stream:

Plug PCM: Hardware PCM card 0 'Ensoniq AudioPCI' device 0 subdevice -1

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (1411200/32)
msbits       : 16
buffer_size  : 16384
period_size  : 8192
period_time  : 185759
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 8192
xfer_align   : 8192
start_threshold  : -1
stop_threshold   : 16384
silence_threshold: 0
silence_size : 16384
boundary     : 1073741824

Any help would be appreciated. Thanks very much!

wingo.

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
