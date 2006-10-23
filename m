From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Driver design question
Date: Mon, 23 Oct 2006 13:46:13 -0400
Message-ID: <1161625574.2835.19.camel@mindpipe>
References: <45095921020000C80000961F@emea1-mh.id2.novell.com>
	<1158331680.7948.156.camel@mindpipe> <s5h64fjj3aj.wl%tiwai@suse.de>
	<1159214063.2899.127.camel@mindpipe> <s5hhcytp6sy.wl%tiwai@suse.de>
	<1159581790.7086.141.camel@mindpipe>
	<1159889722.20801.59.camel@mindpipe>
	<s5hodssl9t4.wl%tiwai@suse.de> <1161295951.15860.255.camel@mindpipe>
	<s5hlknb2lk9.wl%tiwai@suse.de> <1161375168.15860.359.camel@mindpipe>
	<s5hejsz18n9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hejsz18n9.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-10-23 at 15:09 +0200, Takashi Iwai wrote:
> At Fri, 20 Oct 2006 16:12:48 -0400,
> Lee Revell wrote:
> > ~ # aplay /usr/share/sounds/test/phone.wav 
> > Playing WAVE '/usr/share/sounds/test/phone.wav': Signed 16 bit Little
> > Endian, Rate 44100 Hz, Stereo
> > hw_params: stereo yes, format 16bit, rate 44100
> > dream_pcm_open: channel 0x0 eight_bit 0x0 stereo 0x1 rate 0xac44
> > dream_playback_ack
> > dream_playback_copy: not running!
> > dream_pcm_start: channel is 0
> > dream_work_transfer: polling status byte returned 0
> > calling snd_pcm_indirect_playback_transfer
> > in dream_playback_copy: 0x4000 bytes DMA area 0xcdfb0000 sw_data 0x0
> > dream_playback_ack
> > dream_playback_ack
> > dream_work_transfer: polling status byte returned 0
> > calling snd_pcm_indirect_playback_transfer
> > dream_playback_ack
> > playback size is 0x1005
> > dream_playback_ack
> > playback size is 0x100a
> > dream_playback_ack
> > playback size is 0x100f
> > dream_playback_ack
> > playback size is 0x1015
> > dream_playback_ack
> > dream_playback_ack
> 
> The problem looks like the calculation of dream->playback_hw_ptr
> passed to snd_pcm_indirect_playback_pointer().  This must be a _byte_
> offset in the "hardware" ring buffer.  That is, it's between 0 and
> (rec->hw_buffer_size - 1).  You set hw_buffer_size = 0x4000, but
> calculate playback_hw_ptr as [0, runtime->buffer_size] and in frames.
> 

With your patches I still get a similar result:
snd_pcm_indirect_playback_transfer is only called once or twice and the
first chunk of sound repeats endlessly.

~ # aplay /usr/share/sounds/test/phone.wav 
Playing WAVE '/uhw_params: stereo yes, format 16bit, rate 44100
sr/share/sounds/dream_pcm_open: channel 0x0 eight_bit 0x0 stereo 0x1
rate 0xac44
test/phone.wav' dream_playback_ack
dream_playback_copy: not running!
dream_pcm_start: channel is 0
: Signed 16 bit calling snd_pcm_indirect_playback_transfer
in dream_playback_copy: 0x4000 bytes DMA area 0xcdfb0000 sw_data 0x0
Little Endian, Rdream_playback_copy: polling status byte returned 0
ate 44100 Hz, Stereo
dream_playback_copy done
dream_playback_ack
dream_playback_ack
dream_playback_ack
calling snd_pcm_indirect_playback_transfer
in dream_playback_copy: 0x4000 bytes DMA area 0xcdfb0000 sw_data 0x16384
dream_playback_ack
dream_playback_pointer: 0x134

At this point playback hangs.

I just can't understand why the version with the copy callback worked
perfectly, but this PCM indirect stuff has been nothing but trouble.

Did I mention I am using ALSA 1.0.9b?  Does that version have a buggy
PCM indirect implementation?

Is it really necessary to make up a fake pointer like this?  Can't I
just advance the pointer by 0x2000 words after writing each chunk?

Here is my userspace PCM playback implementation that works *perfectly*.
I just need a way to make ALSA do the same thing when a .wav file is
played.


  dream_pcm_open(chip, port, channel, audio8bits, stereo, sample_rate);
  dream_pcm_set_vol_fl(chip, port, channel, 0xFFFF); 
  dream_pcm_set_vol_fr(chip, port, channel, 0xFFFF); 
  dream_pcm_start(chip, port, channel);

  bptr  = & buffer[DREAM_MS_WAV_HEADER_SIZE/2];
  rest  =   bufsize-DREAM_MS_WAV_HEADER_SIZE/2;

  if(audio8bits) /* Endianness doesn't make sence for 8bits WAV files */
    endianness = DREAM_BIG_ENDIAN;

  for (i = 0; rest > 0; i++, bptr+=size) 
   {
        retval = dream_get_mpu_data_poll_status_byte(chip, port, MPU401_IT_MASK, 
                                                                 MPU401_IT_VALUE,
                                                                 100, & tout);
        if(retval < 0)
        pRes += sprintf(pRes, "%d:%d[%u];", i, retval, tout/1000);

        size = AKA_DIAG_MIN(rest, samples);
        /* Send more half buffer of dummy samples pausing after each */
        for (sample = 0; sample < size; sample++)
                dream_mpu_oper16(MPU_WRITE_DATA16, port, endianness, 
                                               &bptr[sample], 0);

          dream_pcm_end_xfer(chip, port, channel);

          rest -= size;
           
          if(rest == 0)
            {
              if(size == samples) /* last half buffer was full */
                {
                  rest  = 2; /* send 2 additional words */
                  bptr -= 2;
                }
            }
  }
  rsp = dream_pcm_close(chip, port, channel);


Lee


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
