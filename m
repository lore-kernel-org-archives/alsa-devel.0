From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Skylake: Add Cometlake
	PCI IDs
Date: Wed, 8 May 2019 14:57:27 -0700
Message-ID: <CAE=gft7JgbDo2xPwdRmY9-oiA_Wchg+mCz1foH267pob-223YA@mail.gmail.com>
References: <20190507215359.113378-1-evgreen@chromium.org>
 <20190507215359.113378-3-evgreen@chromium.org>
 <866afac2-e457-375b-d745-88952b11d75e@linux.intel.com>
 <CAE=gft4sDo1cLeU8Cm1CRZu2PzVG0iu-b7UaWxWVrsUeZ=SYhQ@mail.gmail.com>
 <6fd9ca2b-dcf6-801f-209e-11eba59203fe@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com
 [IPv6:2a00:1450:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B8D1F807B5
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 23:58:06 +0200 (CEST)
Received: by mail-lj1-x242.google.com with SMTP id d15so228376ljc.7
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2019 14:58:06 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com.
 [209.85.167.51])
 by smtp.gmail.com with ESMTPSA id v1sm27896lfa.93.2019.05.08.14.58.04
 for <alsa-devel@alsa-project.org>
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 May 2019 14:58:04 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id v18so51334lfi.1
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2019 14:58:04 -0700 (PDT)
In-Reply-To: <6fd9ca2b-dcf6-801f-209e-11eba59203fe@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Rajat Jain <rajatja@chromium.org>, alsa-devel@alsa-project.org, Yu Zhao <yuzhao@google.com>, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Ben Zhang <benzh@chromium.org>, Mark Brown <broonie@kernel.org>, Rakesh Ughreja <rakesh.a.ughreja@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Naveen M <naveen.m@intel.com>, Guenter Roeck <groeck@chromium.org>, Jenny TC <jenny.tc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 8, 2019 at 10:04 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
>
> On 5/8/19 11:51 AM, Evan Green wrote:
> > On Tue, May 7, 2019 at 3:31 PM Pierre-Louis Bossart
> > <pierre-louis.bossart@linux.intel.com> wrote:
> >>
> >> On 5/7/19 4:53 PM, Evan Green wrote:
> >>> Add PCI IDs for Intel CometLake platforms, which from a software
> >>> point of view are extremely similar to Cannonlake platforms.
> >>
> >> Humm, I have mixed feelings here.
> >>
> >> Yes the hardware is nearly identical, with the exception of one detail
> >> that's not visible to the kernel, but there is no support for DMICs with
> >> the Skylake driver w/ HDaudio, and Chrome platforms are only going with
> >> SOF, so is it wise to add these two CometLake platforms to the default
> >> SND_SOC_INTEL_SKYLAKE selector, which is used by a number of distributions?
> >>
> >> I don't mind if we add those PCI IDs and people use this driver if they
> >> wish to, but it may be time for an explicit opt-in? The
> >> SND_SOC_INTEL_SKYLAKE definition should even be pruned to mean SKL, APL,
> >> KBL and GLK, and we can add DMI-based quirks for e.g. the Up2 board and
> >> GLK Chromebooks which work with SOF.
> >
> > I don't have the context here, so feel free to ignore me. But it seems
> > like such a tiny amount of extra bits to add to make Cometlake work,
> > and then there's no hassle for the distributions when Cometlake
> > devices start showing up in the wild. So while things are more or less
> > the same, why not continue piggypacking off the default?
> > Or are you saying that the lack of DMIC support means the default
> > should be to use a different driver?
>
> Yes, it's the latter case, SOF will be the only driver supporting DMICs
> on CometLake, so it'd be better to avoid creating a conflict with SOF or
> enabling a configuration by default which is known to have restrictions.
> It's fine to add the CML IDs, but better avoid adding CML under the
> SKYLAKE all-you-can-eat selector.

Ok, I'll plan to remove the new selects from under SND_SOC_INTEL_SKYLAKE.
