From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: A plea for help on mixer support for Fast Track
 Ultra (8R)
Date: Wed, 18 May 2011 20:46:20 +0200
Message-ID: <4DD413FC.2090808@showlabor.de>
References: <4DD3E39D.30100@showlabor.de>
	<BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203]) by alsa0.perex.cz (Postfix) with ESMTP id 5E640243B7
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 20:46:25 +0200 (CEST)
In-Reply-To: <BANLkTinCn2Q+asKhGAoq+3S+AtqyHrg2wg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Am 18.05.2011 19:51, schrieb Daniel Mack:
>
> Hmm, I'm not sure whether I understand what you're trying to do. You
> want to add mixers that are not added by the generic driver?

I'm adding a mixer to a device that doesn't even tell the driver that a 
mixer is present. There's no descriptor for it whatsoever. Nevertheless, 
you can control the mixer just like a standard usb audio mixer. 
Therefore I wanted to reuse as much of already present code as possible. 
Most of all I didn't want to construct any URBs or write new control_get 
or _put functions.

The problem is not how to get the mixer for the Fast Track Ultra (FTU) 
working. The problem is how to do it without breaking other mixers ;-)

The main problem at the moment is that snd_usb_create_mixer() will not 
be called on quirked devices! Take a look at card.c: 
snd_usb_create_mixer() will only be called if snd_usb_create_quirk() 
returns > 0. But why should we assume that quirked devices don't have 
any mixers?

I have forced calling snd_usb_create_mixer() for every device in my 
patch set. But this way controls from other devices will show up 
multiple times. We definetely don't want that.

If snd_usb_create_mixer() will be called for the FTU then the rest of my 
patch set works just fine. So how can I tell card.c to call it? I think 
a generic solution would be best, like some entry in quirks-table.h.

> As a general rule, let the check-patch.pl script that ships with the
> kernel have a look at your patches, it will point out obvious coding
> style issues and the like :)

I knew it wasn't ready for submission. After generating the patch I send 
I had already corrected the whitespaces and those lines with over 80 
characters that weren't just copies from other locations. The remaining 
issues like "! cval" and "ERROR: do not use assignment in if condition" 
were all taken literally from other locations inside the respective 
files. So, besides one C99 comment it's very much in style with the 
files I've been working on ;-)

Regards,

Felix
