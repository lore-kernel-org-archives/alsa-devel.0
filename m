From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: commit bd5389278c96f585afcac4058420e4f3ac201d2a
 introduce big problem
Date: Mon, 14 Nov 2011 17:53:10 +0800
Message-ID: <CAHG8p1AHr6Z7VY+6zVhGk6AkbZxdS+firK4eFVrg81NWJnEVNA@mail.gmail.com>
References: <CAHG8p1DmEcTs7Mzmy8F0Aon3SGog9q+CpOX7SS+vFFkmeVWGcw@mail.gmail.com>
	<s5hbosngd04.wl%tiwai@suse.de>
	<CAHG8p1BZ5gV3xAb5QRgc1eEMQ9gB44y+8aoMPcP3R-Th5PESJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 211972464C
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 10:53:11 +0100 (CET)
Received: by vwl15 with SMTP id 15so5443811vwl.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2011 01:53:10 -0800 (PST)
In-Reply-To: <CAHG8p1BZ5gV3xAb5QRgc1eEMQ9gB44y+8aoMPcP3R-Th5PESJw@mail.gmail.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

>
> When I use ad1836 and ad1938 with alsa lib 1.0.24, there is an error:
>
> root:/> arecord -t wav -c 2 -d 3 -r 48000 -f S32_LE 1.wav
> Recording WAVE '1.wav' : Signed 32 bit Little Endian, Rate 48000 Hz, Stereo
> arecord: pcm_read:1773: read error: Input/output error
>
> If format isn't S32_LE, snd_pcm_plugin_readi will be called and
> everything works fine.
>
Hi Takashi,
Any feedback for this bug?
I appreciate your help.

Regards,
Scott
