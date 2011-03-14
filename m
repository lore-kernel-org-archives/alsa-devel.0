From: Magnus Olsson <magnus.olsson@axis.com>
Subject: Re: Dsnoop-plugin buffer sizes
Date: Mon, 14 Mar 2011 11:16:43 +0100
Message-ID: <A612847CFE53224C91B23E3A5B48BAC749EE00F816@xmail3.se.axis.com>
References: <A612847CFE53224C91B23E3A5B48BAC749EE00F801@xmail3.se.axis.com>
	<alpine.LNX.2.00.1103141107030.4805@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
	by alsa0.perex.cz (Postfix) with ESMTP id C01E11037EC
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 11:16:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 7F13C11E99
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 11:16:47 +0100 (CET)
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id r6LWlVFPT57o for <alsa-devel@alsa-project.org>;
	Mon, 14 Mar 2011 11:16:46 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by ra.se.axis.com (Postfix) with ESMTP id 6BDBC11E89
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 11:16:45 +0100 (CET)
Received: from xmail3.se.axis.com (xmail3.se.axis.com [10.0.5.75])
	by seth.se.axis.com (Postfix) with ESMTP id 5245F3E0DD
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 11:16:45 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1103141107030.4805@eeebox2.perex-int.cz>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This output is captured when running periods_min=4.

[root@axis /mnt/flash/root]1335# arecord -v -r 16000 -c1 -Daudiosource0 -fS16_LE /tmp/in.wav
Recording WAVE '/tmp/in.wav' : Signed 16 bit Little Endian, Rate 16000 Hz, Mono
Direct Snoop PCM
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 8000
  period_size  : 2000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 2000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 8000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Hardware PCM card 0 'X4 AIC3104 Dual' device 0 subdevice 0
Its setup is:
  stream       : CAPTURE
  access       : MMAP_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 16000
  exact rate   : 16000 (16000/1)
  msbits       : 16
  buffer_size  : 8192
  period_size  : 2000
  period_time  : 125000
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 2000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 0


-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Jaroslav Kysela
Sent: den 14 mars 2011 11:08
To: Magnus Olsson
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Dsnoop-plugin buffer sizes

On Mon, 14 Mar 2011, Magnus Olsson wrote:

> Hi,
>
> I'm having issues with garbage data in my audio stream, which I believe 
> is caused by incorrect buffer sizes somewhere in the audio pipeline. The 
> garbage occurs periodically and is always constant in length. This 
> problem only triggers when I use the dsnoo-plugin. If running directly 
> towards the device, the audio stream is fine (no garbage). I've not 
> tested if this occurs with any other plugin.
>
> I'm using Dsnoop to capture a mono stream from a stereo device using 
> arecord, arecord -v -r 16000 -c1 -Daudiosource0 -fS16_LE /tmp/in.wav 
> (where audiosource0 is my dsnoop-device, bound to channel 0)
>
> The verbose info from arecord shows me that ALSA has correctly created 
> the Dsnoop device, with a "buffer_size" of 8000. It also shows that it 
> has opened my Hardware device in MMAP-mode, with a "buffer_size" of 
> 8192.

Show us this output from 'arecord -v'.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
