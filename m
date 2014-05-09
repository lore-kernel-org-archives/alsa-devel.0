From: Chaitral Purkar <chaitral_purkar@persistent.co.in>
Subject: Re: Sound issue in omap-twl4030
Date: Fri, 9 May 2014 12:19:45 +0000
Message-ID: <4af00cccce8f467dba6e252cd8fffc10@HKNPR04MB036.apcprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from HJ-SMTP-OUT.persistent.co.in (hjoutgoing.persistent.co.in
 [103.6.33.101]) by alsa0.perex.cz (Postfix) with ESMTP id 8AFED2617AD
 for <alsa-devel@alsa-project.org>; Fri,  9 May 2014 14:19:53 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I wrongly configured McBSP channel. Now, I am getting an error at the end which is 'aplay: pcm_write:1710: write error: Input/output error'.
Can anybody provide some pointers in this regard.
I am copying the aplay output.
ubuntu@arm:~$ aplay -v test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Hardware PCM card 0 'Zoom2' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 27560
  period_size  : 5512
  period_time  : 124988
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 5512
  period_event : 0
  start_threshold  : 27560
  stop_threshold   : 27560
  silence_threshold: 0
  silence_size : 0
  boundary     : 1806172160
  appl_ptr     : 0
  hw_ptr       : 0
aplay: pcm_write:1710: write error: Input/output error


Regards,
Chaitral Purkar

DISCLAIMER
==========
This e-mail may contain privileged and confidential information which is the property of Persistent Systems Ltd. It is intended only for the use of the individual or entity to which it is addressed. If you are not the intended recipient, you are not authorized to read, retain, copy, print, distribute or use this message. If you have received this communication in error, please notify the sender and delete all copies of this message. Persistent Systems Ltd. does not accept any liability for virus infected mails.
