From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: Realtek ALC883 support on Albatron KI690-AM2
	motherboard
Date: Mon, 3 Dec 2007 14:13:22 -0500
Message-ID: <76366b180712031113y14c945aejbfbbd0d5d21c4e02@mail.gmail.com>
References: <76366b180712021308n4d5fd0fk5906c8928795b0c3@mail.gmail.com>
	<s5hr6i3dcch.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E589E2434C
	for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2007 20:13:24 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so2443769rvb
	for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2007 11:13:22 -0800 (PST)
In-Reply-To: <s5hr6i3dcch.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Claudio Matsuoka <cmatsuoka@gmail.com>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi,

Thanks, I'll work on getting this upgraded and post results. Some
things I noticed while looking over patch-realtek.c:

1) There is no enum defining the different NID values. The hex values
are used all over the code and you always have to keep referring back
to the list. Would a patch be accepted to convert the hex values to a
proper enum? It makes the code more clear to someone who hasn't looked
at the chipset datasheet before. I see the complete list in the ALC883
datasheet, but I'm not sure if it is specific to the ALC883 or if it
is defined by each HDA spec revision.

2) There does not appear to be an ALC883 profile which sets all
available NIDs to output. In my case, I am attempting to get as many
stereo outputs as possible from the chipset and I do not care at all
about capturing audio. The 6stack profile does not set the pin
configurations for the MIC1/2 and LINE1/2 NIDs. Would a new model be
required if I want to attempt to configure all possible NIDs for
output? Should this be called "all-out"?

3) I noticed a few discrepancies with the hda header files and the
ALC883 documentation in regards to bits being checked for a few
values. I'll follow up with those once I'm back in front of the code.

-Andrew

On Dec 3, 2007 10:31 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sun, 2 Dec 2007 16:08:32 -0500,
> Andrew Paprocki wrote:
> >
> > Hello everyone,
> >
> > I'm currently trying to get the ALC883 on the Albatron KI690-AM2
> > motherboard working under ALSA and I'm running into problems with some
> > of the ports. From looking at the patch_realtek.c file inside the
> > intel_hda driver, it appears there are many variants of hookups to
> > this chipset which all require some manual configuration in the
> > driver. I've tried what appears to be the closest match
> > (ALC883_6ST_DIG or 6stack-dig), but it still does not enable all of
> > the ports.
> >
> > The motherboard webpage is here:
> > http://www.albatron.com.tw/English/product/mb/pro_detail.asp?rlink=Specification&no=239
> >
> > The board has two audio stacks on the back panel. Facing the jack
> > inputs, the left-hand stack contains:
> >     <S/PDIF output>
> >     <TOSLINK w/ green cover>
> >
> > Next to that stack is a larger 6-stack with the following configuration:
> >     <blue> <black>
> >     <green> <pink>
> >     <grey> <TOSLINK w/ pink cover>
> >
> > The box is running a stock debian 2.6.18-4-486 kernel.
>
> First of all, try the very latest ALSA version (from HG repo) if you
> want to debug HD-audio stuff.  It's the most actively changed part in
> ALSA drivers.  2.6.18 is way too old as a reference.  Also you should
> build the driver with debug option (in the case of alsa-driver tree,
> pass --with-debug=full to configure).
>
> If the latest version still doesn't work (with all available models),
> then check /proc/asound/card0/codec#* files.
>
> (Anyway, I'll be on vacation from tomorrow, so cannot work on your
>  problem.  Hopefully this will interest other guys...)
>
>
> Takashi
