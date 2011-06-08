From: Stephen Warren <swarren@nvidia.com>
Subject: Re: [PATCH] UCM: get: Implement 'exact' value retrieval
Date: Wed, 8 Jun 2011 08:43:44 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0498E1CD8F@HQMAIL01.nvidia.com>
References: <1307391417-3199-1-git-send-email-swarren@nvidia.com>
	<s5hfwnkzwik.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C471244F4
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 17:43:59 +0200 (CEST)
In-Reply-To: <s5hfwnkzwik.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote at Wednesday, June 08, 2011 12:08 AM:
> At Mon,  6 Jun 2011 14:16:57 -0600, Stephen Warren wrote:
> >
> > [=]<NAME>[/[<modifier>|</device>][/<verb>]]
> > - value identifier <NAME>
> > - Search starts at given modifier or device if any,
> >     else at a verb
> > - Search starts at given verb if any,
> >     else current verb
> > - Searches modifier/device, then verb, then defaults
> > - Specify a leading "=" to search only the exact
> >   device/modifier/verb specified, and not search
> >   through each object in turn.
> > - Examples:
> >     "PlaybackPCM/Play Music"
> >     "CapturePCM/SPDIF"
> >   From ValueDefaults only:
> >     "=Variable"
> >   From current active verb:
> >     "=Variable//"
> >   From verb "Verb":
> >     "=Variable//Verb"
> >   From "Modifier" in current active verb:
> >     "=Variable/Modifier/"
> >   From "Modifier" in "Verb":
> >     "=Variable/Modifier/Verb"
> >
> > Signed-off-by: Stephen Warren <swarren@nvidia.com>
> 
> I couldn't apply it cleanly.  Any pending patch?

Yes, the 5-series patchset I posted last Friday starting with:
[PATCH 1/5] UCM: Deprecate index on Section{Device,Modifier}

(since they were ACK'd by Liam before I posted this patch, I
assumed they'd be applied before you attempted to apply this,
so I didn't mention the dependency in the patch description.)

Thanks.

-- 
nvpublic
