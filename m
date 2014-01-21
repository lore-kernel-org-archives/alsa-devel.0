From: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Subject: Re: [ISSUE] crackles and clicks
Date: Tue, 21 Jan 2014 23:59:36 +0000
Message-ID: <89F8E4011FD7234ABFE48744E300CBC206BCBFDC@041-DB3MPN1-092.041d.mgd.msft.net>
References: <CA+T9nP9VBdW6T8o3=5hFJpMXpHGz59VOGva2+8g8xoPw6Xa8+g@mail.gmail.com>
 <s5hy52kt71z.wl%tiwai@suse.de>
 <89F8E4011FD7234ABFE48744E300CBC206BC3EF2@041-DB3MPN1-093.041d.mgd.msft.net>
 <20140114144224.GC23764@tamtam.fritz.box>
 <89F8E4011FD7234ABFE48744E300CBC206BC449B@041-DB3MPN1-093.041d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from as-smtp4.itc.alstom.com (as-smtp4.itc.alstom.com
 [159.245.16.39])
 by alsa0.perex.cz (Postfix) with ESMTP id 3FA22261A92
 for <alsa-devel@alsa-project.org>; Wed, 22 Jan 2014 00:59:41 +0100 (CET)
In-Reply-To: <89F8E4011FD7234ABFE48744E300CBC206BC449B@041-DB3MPN1-093.041d.mgd.msft.net>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi, I have redone the small aplay experiment but this time by using the master git version which gives some more info about my underruns.

I have also modded it so it prints now with:

@@ -1507,9 +1507,10 @@ static void xrun(void)
                        clock_gettime(CLOCK_MONOTONIC, &now);
                        snd_pcm_status_get_trigger_htstamp(status, &tstamp);
                        timermsub(&now, &tstamp, &diff);
-                       fprintf(stderr, _("%s!!! (at least %.3f ms long)\n"),
+                       fprintf(stderr, _("%s!!! (at least %.3f ms long) now  %ld.%09ld\n"),
                                stream == SND_PCM_STREAM_PLAYBACK ? _("underrun") : _("overrun"),
-                               diff.tv_sec * 1000 + diff.tv_nsec / 1000000.0);
+                               diff.tv_sec * 1000 + diff.tv_nsec / 1000000.0,
+                               now.tv_sec, now.tv_nsec);
 #else
                        fprintf(stderr, "%s !!!\n", _("underrun"));
 #endif

./aplay -v ~/Music/sine.wav

on kernel v3.12.7 with

Codec: IDT 92HD81B1X5
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x111d7605
Subsystem Id: 0x103c1585
Revision Id: 0x100402

which gives

underrun!!! (at least 1248687948.256 ms long) now  27046.672739254
Status:
  state       : XRUN
  trigger_time: 1390347762.628483000
  tstamp      : 1390347766.184350000
  delay       : -635
  avail       : 15687
  avail_max   : 15675
underrun!!! (at least 1248690502.759 ms long) now  27052.789215213
Status:
  state       : XRUN
  trigger_time: 1390347766.190456000
  tstamp      : 1390347772.300830000
  delay       : -1333
  avail       : 16385
  avail_max   : 16373

is there someone that could give me some investigation advices on this one?
Would enabling xrun_debug be helpful?

thank you,


>
> I experience the audible clicks with VLC but I have reproduced it with aplay as
> well. The clicks that I hear corresponds to underruns. For the records, this is
> not happening with a USB device. I have a Intel HDA sound card. I did chime
> in the discussion to point out that the problem could come from something
> else than ALSA or the sound card driver. Here is the output of my aplay
> session. This makes me doubt my hypothesis. I'll check the cpu usage while
> the Wifi is on but not connected or see if running aplay in real-time prio
> makes things any better.
>
> Note that the underrun duration printed in the output sound fishy...
>
> underrun!!! (at least 1856093977.967 ms long)
>
> lano1106@hpmini ~/Music $ aplay -v -c1 sine.wav Playing WAVE 'sine.wav' :
> Signed 16 bit Little Endian, Rate 44100 Hz, Stereo Plug PCM: Rate conversion
> PCM (48000, sformat=S32_LE)
> Converter: linear-interpolation
> Protocol version: 10002
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 44100
>   exact rate   : 44100 (44100/1)
>   msbits       : 16
>   buffer_size  : 15052
>   period_size  : 940
>   period_time  : 21333
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 940
>   period_event : 0
>   start_threshold  : 15052
>   stop_threshold   : 15052
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 986447872
> Slave: Soft volume PCM
> Control: PCM Playback Volume
> min_dB: -51
> max_dB: 0
> resolution: 256
> Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : S32_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 32
>   buffer_size  : 16384
>   period_size  : 1024
>   period_time  : 21333
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 1024
>   period_event : 0
>   start_threshold  : 16384
>   stop_threshold   : 16384
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1073741824
> Slave: Direct Stream Mixing PCM
> Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : S32_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 32
>   buffer_size  : 16384
>   period_size  : 1024
>   period_time  : 21333
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 1024
>   period_event : 0
>   start_threshold  : 16384
>   stop_threshold   : 16384
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 1073741824
> Hardware PCM card 0 'HDA Intel' device 0 subdevice 0 Its setup is:
>   stream       : PLAYBACK
>   access       : MMAP_INTERLEAVED
>   format       : S32_LE
>   subformat    : STD
>   channels     : 2
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 32
>   buffer_size  : 16384
>   period_size  : 1024
>   period_time  : 21333
>   tstamp_mode  : ENABLE
>   period_step  : 1
>   avail_min    : 1024
>   period_event : 0
>   start_threshold  : 1
>   stop_threshold   : 1073741824
>   silence_threshold: 0
>   silence_size : 1073741824
>   boundary     : 1073741824
>   appl_ptr     : 0
>   hw_ptr       : 40810501
> underrun!!! (at least 1856093977.967 ms long)
>
>
> ________________________________
> CONFIDENTIALITY : This e-mail and any attachments are confidential and may
> be privileged. If you are not a named recipient, please notify the sender
> immediately and do not disclose the contents to another person, use it for
> any purpose or store or copy the information in any medium.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
