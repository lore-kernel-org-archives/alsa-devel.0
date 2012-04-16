From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fast Track Ultra mixer - opinions anyone?
Date: Mon, 16 Apr 2012 15:10:25 +0200
Message-ID: <4F8C1A41.2080807@ladisch.de>
References: <CAFz=ag4SmifT2jVE-NqcWXg_+go_WYD06c9ZM0HtC1KHKg7k6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CD0A5243DC
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 15:07:13 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 810F920ADE
	for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2012 09:07:12 -0400 (EDT)
In-Reply-To: <CAFz=ag4SmifT2jVE-NqcWXg_+go_WYD06c9ZM0HtC1KHKg7k6Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: Takashi Iwai <tiwai@suse.de>, =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Grant Diffey <gdiffey@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> IMO, the effect section on the FTUs really sucks. I can't believe that
> anybody can really use it in a reasonable way. So should we really add
> another 40 controls to the mixer which can cause a lot of pain when
> misadjusted (i.e. anything else but 0)?
>
> For those reasons I would prefer not to put effect support in the
> kernel. What do you think?

If you want to be able to use these effects at all, there must be _some_
way to access the controls.

Generic mixer programs like alsamixer are not really suitable for
complex devices; you'd need to write a custom mixer.

If you want to prevent the controls from showing up in alsamixer, set
their .iface to SNDRV_CTL_ELEM_IFACE_CARD instead of _MIXER.  (But if
these controls don't show up in alsamixer, you wouldn't be able to reset
them if they are misadjusted ...)

> Currently alsamixer does not report any dB changes when you change a
> control value.

Set the TLV.  For standard controls, the code reads the values from
the USB descriptors, but for control you create by hand, you have to
create these, too.


Regards,
Clemens
