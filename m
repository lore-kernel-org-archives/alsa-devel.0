From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v3 1/2] ALSA: jack: create jack kcontrols
 for every jack input device
Date: Wed, 25 Mar 2015 13:27:07 +0800
Message-ID: <CAN8ccibHD_5NGZuP11yLdvpYhB-TA-4q_=AHyGQyCPA1PxVQag@mail.gmail.com>
References: <1426865953-1606-1-git-send-email-yang.jie@intel.com>
 <1426865953-1606-2-git-send-email-yang.jie@intel.com>
 <s5ha8z7zlrd.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDBBA0@SHSMSX101.ccr.corp.intel.com>
 <1427105297.2968.19.camel@tkkaskin-mobl3.ger.corp.intel.com>
 <s5hzj743p0x.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDD602@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 75FB72614BB
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2015 06:27:09 +0100 (CET)
Received: by obdfc2 with SMTP id fc2so11300474obd.3
 for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2015 22:27:08 -0700 (PDT)
In-Reply-To: <E7B1D079BA13FB44A978CC8F69C7D6A901BDD602@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Jie, Yang" <yang.jie@intel.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

> BTW, Takashi, according to what Tanu mentioned, kctls indexes other than 0
> are currently ignored by PA, so creating and exporting kctls with non-zero
> indices for the same name in HD-Audio Jack before, seems no use for upper
> layer?

Does this mean that pulseaudio don't support notebook with dual headphone
jacks since you need to use  jack states of both headphone jacks to
determine the speaker is muted or not even you assign different name to the
headphone jacks

For notebook with dock station ,  headphone jack and dock headphone jack
usually share volume
