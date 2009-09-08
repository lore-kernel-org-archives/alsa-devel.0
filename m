From: Giovanni Maruzzelli <gmaruzz.lists@gmail.com>
Subject: Re: snd_dummy on Centos - Redhat
Date: Tue, 8 Sep 2009 15:29:54 +0200
Message-ID: <7c5010d60909080629s502f99c7l43f1dccf84aa4d8@mail.gmail.com>
References: <7c5010d60909020912k1b9b64bdsab2363c4762e8c5c@mail.gmail.com>
	<s5hzl9bypj3.wl%tiwai@suse.de>
	<7c5010d60909040338x69700bf5kef90819625679d1e@mail.gmail.com>
	<s5hpra7ynut.wl%tiwai@suse.de>
	<7c5010d60909040411y76818280p7b7ded46f2df9b64@mail.gmail.com>
	<7c5010d60909040910l2cd54890rc89222b17ca6d8eb@mail.gmail.com>
	<7c5010d60909070400n48b5d494h1769285c958e9626@mail.gmail.com>
	<s5heiqjxbc8.wl%tiwai@suse.de>
	<7c5010d60909071205o74873cadh5eb3703224531940@mail.gmail.com>
	<s5hocpl60ax.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f215.google.com (mail-fx0-f215.google.com
	[209.85.220.215])
	by alsa0.perex.cz (Postfix) with ESMTP id D664F244C0
	for <alsa-devel@alsa-project.org>;
	Tue,  8 Sep 2009 15:29:56 +0200 (CEST)
Received: by fxm11 with SMTP id 11so1136043fxm.39
	for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2009 06:29:55 -0700 (PDT)
In-Reply-To: <s5hocpl60ax.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 8, 2009 at 3:19 PM, Takashi Iwai<tiwai@suse.de> wrote:
> If this is true, I think it's rather a bug of Skype.
> But we cannot check it by the obvious reason :)

Cannot agree the more! :-)

> I don't like adding too many module parameters. =A0There are many
> other adjustable parameters in that struct, I simply added a proc
> interface to show and store the values now.

I'm not sure I've understood. There will be a /proc pseudofile that I
can read and write and that alters the values of period and buffer?

>
> Try the latest alsa-driver-snapshot tarball. =A0Note that the proc file
> is enabled only in the debug mode. =A0With the external build, pass
> --with-debug=3Dfull configure option.

When you will release, the /proc file will be also present in the
normal build (eg: no debug build)?

The best for the users would be having a standard (from the official
ALSA distribution, not hacked by me) alsa driver that they can control
around the Skype bug, eg using a config param or (if you like better)
using the /proc interface. In a while there will be a prepackaged
build for CentOS, and all them will be happy and feel safe :-).

Many many thanks,
-giovanni
