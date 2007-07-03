From: GT Bradley <gt.bradley@gmail.com>
Subject: Re: PS3 - Surround sound on SPDIF set-up
Date: Tue, 03 Jul 2007 11:50:34 -0700
Message-ID: <468A9A7A.7020802@gmail.com>
References: <4689B1BF.2050709@gmail.com> <s5hps39a4hv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 6050F103812
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jul 2007 20:46:39 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2764869wag
	for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2007 11:46:38 -0700 (PDT)
In-Reply-To: <s5hps39a4hv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

yes,
  I am aware that AC3 is required,  I'm trying to get the AC3 
pass-through configured. From your response, I understand now that 
speaker-test is performing as expected, however I have tired other 
things also:
 I have some AC3 encoded test files,  and I have also tried installing 
ffmpeg, and liba52.  and the ac3dec utility which I understand should 
pass through the AC3/DTS encoded files, but I recieve:

[root@ps3 Surround-SDL-testfiles]# ac3dec -C dolby-canyon.ogg
Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
ALSA lib conf.c:3939:(snd_config_expand) Unknown parameters {AES0 0x2 
AES1 0x82 AES2 0x0 AES3 0x2}
ALSA lib pcm.c:2145:(snd_pcm_open_noupdate) Unknown PCM iec958:{AES0 0x2 
AES1 0x82 AES2 0x0 AES3 0x2}
snd_pcm_open: Invalid argument
Output open failed

However if I am planning to write ac3 to the linux driver, are you 
saying that I would be better to write directly to the driver rather 
than through the ALSA layer?

thanks
GT



Takashi Iwai wrote:

>At Mon, 02 Jul 2007 19:17:35 -0700,
>gt bradley wrote:
>  
>
>>Hi,
>>I've been beating my had against this for several weeks now.  (started
>>with fedora 6, tried adding in the plugings etc (version 1.0.12) -- also
>>tried upgrading to the current 1.0.14 version, without success (couldn't
>>produce surround-sound on teh spdif output).  I have now switched to
>>fedorea 7 and was able to have rythmbox play surround sound via spdif,
>>but have since lost that ability.  (but I'm convinced the hardware and
>>low-level drivers support it).  In order to limit the number of moving
>>parts, I have reduced to just trying to get speaker-test to play on all
>>6 speakers.
>>    
>>
>
>SPDIF is basically only for a two-channel PCM stream.  For 5.1
>outputs, you'll have to encode the raw multi-channel PCM to some
>compressed format such as AC3 or DTS and embed in SPDIF frames.
>And, that's not the driver job, so far -- at least the current driver
>doesn't do any conversion.  Thus a software has to do it.
>
>You can try a52 plugin for the on-the-fly encoding, found in
>alsa-plugins package.  The plugin seems working for some apps but for
>some not yet well, unfortunately...
>
>
>Takashi
>
>  
>
