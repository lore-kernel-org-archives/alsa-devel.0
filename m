From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsa-util.c: snd_pcm_avail() returned a value that
 is exceptionally large: 675220 bytes (3827 ms).
Date: Tue, 25 Jan 2011 21:26:29 +0800
Message-ID: <AANLkTimnWDXRGsX_-uvemsDaOCfogW44R09jA=7hiYpG@mail.gmail.com>
References: <4D393FA6.8050805@san.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 4ACDD103929
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 14:26:57 +0100 (CET)
Received: by ewy19 with SMTP id 19so2440449ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2011 05:26:53 -0800 (PST)
In-Reply-To: <4D393FA6.8050805@san.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/21 support <support@san.ru>

>
>
> alsa-util.c: snd_pcm_avail() returned a value that is exceptionally large:
> 675220 bytes (3827 ms).
> alsa-util.c: Most likely this is a bug in the ALSA driver 'snd_emu10k1'.
> Please report this issue to the ALSA developers.
>
>
>
> http://www.alsa-project.org/db/?f=641d9cb90af2e47e527c2912bee4e34bff41b87b
>
> # rpm -qa | grep alsa
> alsa-lib-devel-1.0.23-2.fc14.i686
> alsa-plugins-pulseaudio-1.0.22-1.fc13.i686
> alsa-utils-1.0.23-3.fc14.i686
> alsa-lib-1.0.23-2.fc14.i686
>
> # uname -a
> Linux wp.san.ru 2.6.35.10-74.fc14.i686 #1 SMP Thu Dec 23 16:17:40 UTC 2010
> i686 i686 i386 GNU/Linux
>
>
>
This is underrun occur in PA server  since hw_ptr is ahead of appl_ptr and
( 978317001 978195372) > buffer size  16384

Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c: Slave: Hardware PCM
card 0 'SB Live! [Unknown]' device
0 subdevice 0
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c: Its setup is:
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   stream       : PLAYBACK


Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   buffer_size  : 16384
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   period_size  : 16384

Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   appl_ptr     : 978195372
Jan 21 10:55:20 wp pulseaudio[2393]: alsa-util.c:   hw_ptr       : 978317001
