From: Fredrik Lingvall <fl@ifi.uio.no>
Subject: Re: hdspmixer
Date: Wed, 26 Jan 2011 14:55:13 +0100
Message-ID: <4D4027C1.106@ifi.uio.no>
References: <alpine.LNX.2.00.1101261044110.6272@eeebox2.perex-int.cz>
	<4D3FF1C4.8000704@ifi.uio.no>
	<alpine.LNX.2.00.1101261108320.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DCBE1103A31
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 14:55:18 +0100 (CET)
Received: by bwz10 with SMTP id 10so1404515bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 05:55:18 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101261108320.6272@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Florian Faber <faber@faberman.de>
List-Id: alsa-devel@alsa-project.org

On 01/26/11 11:13, Jaroslav Kysela wrote:
> On Wed, 26 Jan 2011, Fredrik Lingvall wrote:
>
>> I did two things to build the hdspmixer I got from Florian.
>>
>> 1) Moved the #endif (at line 121)
>>
>> #endif                /* __SOUND_HDSPM_H */
>>
>> downto the last line of the hdspm.h
>
> It's already in hdspm.h we have in the GIT kernel tree:
>
> http://git.alsa-project.org/?p=alsa-kernel.git;a=blob;f=include/sound/hdspm.h;h=81990b2bcc981bb4f31cae44616aa052c5f1066e;hb=HEAD
>
>

I have now build the hdspm driver from:
http://wiki.linuxproaudio.org/index.php/Driver:hdspm (2010-12-25)
and the hdspmixer (hdspmixer_64-1.9) from:
http://wiki.linuxproaudio.org/index.php/App:hdspmixer_64

I did this by copying the hdspm.c file to the (gentoo kernel)
/usr/src/linux-2.6.36-gentoo-r5/sound/pci/rme9652/hdspm.c
and the hdspm.h file to /usr/include/alsa/sound/hdspm.h and
/usr/include/sound/hdspm.h (had to change the include path for hdspm.h
in hdspm.c as well).

Both the driver and hdspmixer build fine.

There are some differences to the driver at:

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob;f=include/sound/hdspm.h;h=81990b2bcc981bb4f31cae44616aa052c5f1066e;hb=HEAD
http://git.alsa-project.org/?p=alsa-kernel.git;a=blob;f=sound/pci/rme9652/hdspm.c;h=f5eadfc0672ab0073db93f8fe2b484069b42c814;hb=HEAD

At a quick glance I could see that Florian's name was missing in the
MODULE_AUTHOR section for example.

There is also one problem that I have with the driver and and MADIFace
plus a RME M-32 ADC (on a Macbook Pro running x86_64 Gentoo) - the boot
sequence hugs if I have the coax MADI input connected and switched on.
By toggeling to MADI optical during boot is boots fine and I can
afterwards switch back to coax after boot and the card and driver works
fine.

/Fredrik
