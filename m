From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001990]: aplay/arecord cannot play/capture A_LAW
Date: Mon, 24 Apr 2006 16:50:10 +0200
Message-ID: <65df18fce2964d00204cb49420ae27c8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D68F0178
	for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2006 16:50:10 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1990> 
======================================================================
Reported By:                Raymond
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1990
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-01-2006 04:26 CEST
Last Modified:              04-24-2006 16:50 CEST
======================================================================
Summary:                    aplay/arecord cannot play/capture A_LAW
Description: 
aplay/arecord can play MU_LAW and the sound card support MU_LAW and A_LAW

arecord -D hw:0,0 -f MU_LAW -t au -c 1 -r 8000 test.au

aplay -D hw:0,0 test.au


Try to use -t raw but the quality of A_LAW is very bad when compare with
MU_LAW

arecord -D hw:0,0 -f A_LAW -t raw -c 1 -r 8000 test.raw

aplay -D hw:0,0 test.raw


======================================================================

----------------------------------------------------------------------
 Raymond - 04-24-06 16:43 
----------------------------------------------------------------------
Oops occur if user mis-use the plugin (OSS) with OSS enumeration.

ALSA API -> ALSA PLUGIN(OSS) -> OSS ENUMERATION -> ALSA DRIVER

aplay -v -Dossdriver test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Mono
ALSA <-> OSS PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 16384
  period_size  : 4096
  period_time  : 92879
  tick_time    : 0
  tstamp_mode  : NONE
  period_step  : 1
  sleep_min    : 0
  avail_min    : 4096
  xfer_align   : 4096
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824


ALSA ../alsa-kernel/core/pcm_lib.c:1839: BUG? ((max >= 0))
dc3fbe6c e1d05c5f e1d092e1 0000072f e1d092d3 e1d093dc dc3fbe9c e20a35b0
       00000000 000002aa ffffffea 00000000 ffffffff 00000000 d0da7014
00000000
       00000000 dc3fbf34 e20a3c00 daa32394 d0da7014 0000000d 000002aa
00000000
Call Trace:   [<e1d05c5f>] snd_pcm_hw_param_near [snd-pcm] 0x25f
(0xdc3fbe70)
[<e1d092e1>] .rodata.str1.1 [snd-pcm] 0x6f1 (0xdc3fbe74)
[<e1d092d3>] .rodata.str1.1 [snd-pcm] 0x6e3 (0xdc3fbe7c)
[<e1d093dc>] .rodata.str1.1 [snd-pcm] 0x7ec (0xdc3fbe80)
[<e20a35b0>] snd_pcm_oss_period_size [snd-pcm-oss] 0x280 (0xdc3fbe88)
[<e20a3c00>] snd_pcm_oss_change_params [snd-pcm-oss] 0x390 (0xdc3fbeb4)
[<e20a4280>] snd_pcm_oss_get_active_substream [snd-pcm-oss] 0x80
(0xdc3fbf38)
[<c0125d66>] update_wall_time [kernel] 0x16 (0xdc3fbf40)
[<c01262a0>] timer_bh [kernel] 0x370 (0xdc3fbf48)
[<e20a5208>] snd_pcm_oss_get_channels [snd-pcm-oss] 0x18 (0xdc3fbf5c)
[<e20a6b38>] snd_pcm_oss_ioctl [snd-pcm-oss] 0x668 (0xdc3fbf70)
[<c0153719>] sys_ioctl [kernel] 0xc9 (0xdc3fbf94)
[<c0109747>] system_call [kernel] 0x33 (0xdc3fbfc0)
 
ALSA pcm_oss.c:450: BUG? (err >= 0)
dc3fbeb0 e20a3ff2 e20ab25c 000001c2 e20ab24e e20ab2d5 00000000 dca6d838
       00000000 00000003 daad4594 dca6d814 c912d414 00000000 00000018
00000000
       00000000 00000000 00000000 00000000 00000000 00000000 00300006
00000000
Call Trace:   [<e20a3ff2>] snd_pcm_oss_change_params [snd-pcm-oss] 0x782
(0xdc3fbeb4)
[<e20ab25c>] .rodata.str1.1 [snd-pcm-oss] 0x24 (0xdc3fbeb8)
[<e20ab24e>] .rodata.str1.1 [snd-pcm-oss] 0x16 (0xdc3fbec0)
[<e20ab2d5>] .rodata.str1.1 [snd-pcm-oss] 0x9d (0xdc3fbec4)
[<e20a4280>] snd_pcm_oss_get_active_substream [snd-pcm-oss] 0x80
(0xdc3fbf38)
[<c0125d66>] update_wall_time [kernel] 0x16 (0xdc3fbf40)
[<c01262a0>] timer_bh [kernel] 0x370 (0xdc3fbf48)
[<e20a5208>] snd_pcm_oss_get_channels [snd-pcm-oss] 0x18 (0xdc3fbf5c)
[<e20a6b38>] snd_pcm_oss_ioctl [snd-pcm-oss] 0x668 (0xdc3fbf70)
[<c0153719>] sys_ioctl [kernel] 0xc9 (0xdc3fbf94)
[<c0109747>] system_call [kernel] 0x33 (0xdc3fbfc0)

----------------------------------------------------------------------
 tiwai - 04-24-06 16:50 
----------------------------------------------------------------------
It's no Oops but the stack trace output from snd_assert().  It's a bug, of
course, though.

Anyway, PLEASE open another bug.  This is out of the topic of this thread
-- "aplay/arecord cannot play/capture A_LAW".

And please show the ALSA version you're using.  I cannot see the relevant
assert line found in the message.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-01-06 04:26 Raymond        New Issue                                    
04-03-06 07:16 Raymond        Note Added: 0009085                          
04-03-06 07:36 Raymond        Note Added: 0009086                          
04-07-06 19:32 tiwai          Note Added: 0009152                          
04-08-06 07:47 Raymond        Note Added: 0009171                          
04-10-06 16:52 tiwai          Note Added: 0009199                          
04-11-06 07:46 Raymond        Note Added: 0009229                          
04-11-06 07:55 Raymond        Note Edited: 0009229                         
04-11-06 09:41 Raymond        Note Edited: 0009229                         
04-20-06 15:29 tiwai          Status                   new => resolved     
04-20-06 15:29 tiwai          Resolution               open => not an issue
04-20-06 15:29 tiwai          Assigned To               => tiwai           
04-20-06 15:29 tiwai          Note Added: 0009384                          
04-24-06 15:07 Raymond        Status                   resolved => feedback
04-24-06 15:07 Raymond        Resolution               not an issue => reopened
04-24-06 15:07 Raymond        Note Added: 0009451                          
04-24-06 15:48 tiwai          Status                   feedback => resolved
04-24-06 15:48 tiwai          Resolution               reopened => not an issue
04-24-06 15:48 tiwai          Note Added: 0009453                          
04-24-06 16:43 Raymond        Status                   resolved => feedback
04-24-06 16:43 Raymond        Resolution               not an issue => reopened
04-24-06 16:43 Raymond        Note Added: 0009468                          
04-24-06 16:50 tiwai          Status                   feedback => resolved
04-24-06 16:50 tiwai          Resolution               reopened => not an issue
04-24-06 16:50 tiwai          Note Added: 0009472                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
