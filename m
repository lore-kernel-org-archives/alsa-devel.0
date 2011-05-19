From: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Subject: Re: GR-55 Driver
Date: Thu, 19 May 2011 14:09:44 -0700
Message-ID: <1305839384.4443.41.camel@TrinaryDragon>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
	<1305233604.8214.2.camel@TrinaryDragon>
	<BANLkTikGVDWxShJOsfspETPVwKDqcJtNOg@mail.gmail.com>
	<1305253856.5076.65.camel@TrinaryDragon>
	<BANLkTi=jj7cjxgmOpH+EHnUMuazqLOEsZA@mail.gmail.com>
	<1305441562.2850.7.camel@TrinaryDragon>
	<BANLkTik-m+BmV0+vQyVfPPDSmCgXspCuAg@mail.gmail.com>
	<1305501208.7165.13.camel@TrinaryDragon>
	<BANLkTimD7pPS6ErrWA6rVKzjV1KoOj-yWw@mail.gmail.com>
	<1305581583.2594.40.camel@TrinaryDragon>
	<BANLkTik_oWtWLN+6Y_j7RznUzvztrzZybA@mail.gmail.com>
	<1305732893.3209.5.camel@TrinaryDragon>
	<BANLkTinmnzEpRspYb74edaH1q8NPqXZg5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 49B5D103820
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 23:09:50 +0200 (CEST)
Received: by pwi9 with SMTP id 9so1696439pwi.38
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 14:09:47 -0700 (PDT)
In-Reply-To: <BANLkTinmnzEpRspYb74edaH1q8NPqXZg5w@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Please take a second look at this information:

I do not understand what type of problem not related to the driver, that
you are referring to; if you can give me a few examples I can test that
theory; which is what I have been trying to do with my troubleshooting
file, configuration of Audacity is very simple, and works in Windows:
http://vetshelpcenter.com/media/troubleshooting-gr-55.txt

My document on driver activity in Windows, using Audacity to record
Audio, Guitar Pro 6 to record MIDI and the GR Floorboard to get Patch's,
which I have no problem getting this working; keep in mind I'm a Unix
programmer (30+ years), not Linux per say, but I'll work on that; but
I'm not a Windows End User, nor a Noobie; but I'm not in the best of
health; we all have our problems, I just don't want this interface to be
mine.
http://vetshelpcenter.com/media/GR-55-USB-Anlyzer.html

I do not see evidence that this driver patch is working as it should;
but its a good start, and I thank you for your work; now it shows up in
the system, and I do have limited access to the audio input channel; so
we are working in the right direction; but its far from saying that the
low-level part works; when I can only get one function working with
limited (still crashes) success.

Lets step back and look at this with Fresh eyes: 

This is the Roland GR-55 Guitar Synthesizer
http://www.rolandus.com/products/productdetails.php?ProductId=1148

You based this driver patch on the

BOSS JS-8
http://www.bossus.com/gear/productdetails.php?ProductId=1027

Instead of the GT-10; which seems more similar, but I do not know
anything about the difference in drivers, nor do I know that you have a
working driver for the GT-10, or that its based on the JS-8.

BOSS GT-10
http://www.bossus.com/gear/productdetails.php?ProductId=941

As such, all I can do is go along and see if I can get this to work; so
humor me, and lets see about basing this on the GT-10 and see how that
works; from what I read; they might be based on the same chip set; I
have contacted Roland, and they refuse to tell me what chip set they do
use; I can open up my GR-55 to see what chip set its using; its new, and
I hate to do this; but I did; below are my findings; but I still do not
know what chip set the GT-10 or JS-8 use; but I'm sure someone knows; so
maybe this is a better place to start.

High res image of GR-55 Motherboard interface
http://vetshelpcenter.com/media/GR-55-Motherboard.png

ROLAND WSP
R05011845
JAPAN 1026
HAL 889451

ROLAND SSC
R8A02021AB0
D4670467
BH11324
JAPAN 1035

ESMT
M12L128168A-
AZT1P00B4

I did a search with no results; so maybe this doesn't help at all; but I
had to try; my guess is that these are custom chips; Yamaha would be my
guess at manufacture; but I don't know that.

The work you do is very important to the community and I thank you.

-----Original Message-----
From: Daniel Mack <zonque@gmail.com>
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] GR-55 Driver
Date: Wed, 18 May 2011 19:39:53 +0200

On Wed, May 18, 2011 at 5:34 PM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
> Does this type of data (USBlyzer Report) help to write drivers?
> http://vetshelpcenter.com/media/GR-55-USB-Anlyzer.html

The problems you're still having are not related to the driver
anymore. The low-level part works. You're just facing a configuration
thing with the applications you're trying to use, but I don't see it
at the moment. It's most probably something trivial - can anyone else
on this list have a look at the comprehensive logs you've been
posting?


Thanks,
Daniel
