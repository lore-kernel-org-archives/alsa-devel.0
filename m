From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Wed, 25 Mar 2015 08:48:43 +0800
Message-ID: <CAN8cciayer9MVbHaD1mZLV=kOXjpiAB9uSPkNEuZqDm3+-2u2g@mail.gmail.com>
References: <E7B1D079BA13FB44A978CC8F69C7D6A901BDB90F@SHSMSX101.ccr.corp.intel.com>
 <s5hvbhv6eio.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB93C@SHSMSX101.ccr.corp.intel.com>
 <s5hr3sj6bzj.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDB993@SHSMSX101.ccr.corp.intel.com>
 <s5hegoj69bs.wl-tiwai@suse.de>
 <1427108203.2968.57.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <550FFE2B.7050008@canonical.com>
 <20150323164129.GE14954@sirena.org.uk>
 <5511093F.1010708@canonical.com>
 <20150324175736.GA17265@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E291260688
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 01:48:44 +0100 (CET)
Received: by oier21 with SMTP id r21so8956438oie.1
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 17:48:43 -0700 (PDT)
In-Reply-To: <20150324175736.GA17265@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>
> > >>For headphone or headset, one hw switch only:
>
> > >>  * "Headphone Jack"
> > >>  * "Headset Mic Phantom Jack"
>
> > >I'd have expected these to be the same thing, just with the second case
> > >always having the same state for both switches.
>
> > We need to distinguish the use cases: in case of independent switches,
we
> > can make the assumption that if the user plugged in a headset, the user
> > wants to use the headset mic instead of the internal mic, so we switch
to
> > it.
>
> > In the other case, where we don't know if the user plugged in a
headphone or
> > a headset, we need to ask the user what (s)he plugged in, so we can
> > determine whether to select headphone+internal mic or headphone+headset
mic.::

Does the user maunal of those notebook explicitly state that the combo jack
support headset and headphone ( or mic) ?

if not, why do the driver need to support both headphone and headset ( or
mic ) especially when the icon near the jack is headset
