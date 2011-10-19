From: Stephen Warren <swarren@nvidia.com>
Subject: Re: ASoC: Correct way to set private data in
	machine	driver?
Date: Wed, 19 Oct 2011 07:57:44 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173D51BDDB@HQMAIL01.nvidia.com>
References: <C039722627B15F489AB215B00C0A3E66095C2501A4@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id E4325245D8
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 16:57:47 +0200 (CEST)
In-Reply-To: <C039722627B15F489AB215B00C0A3E66095C2501A4@bgsmsx501.gar.corp.intel.com>
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
To: "Abdullah, Omair M" <omair.m.abdullah@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Abdullah, Omair M wrote at Wednesday, October 19, 2011 12:42 AM:
>   Looking at the code of soc and any machine driver, soc-core uses
> dev_set_drvdata() and dev_get_drvdata() to pass a snd_soc_card
> structure. This needs to be set in the probe to the machine driver's
> snd_soc_card structure. Then how can the machine driver's private data
> be passed around (eg. in probe and remove)?

I imagine all machine drivers do the same, but use:

snd_soc_card_set_drvdata(card, machine);

For example, see sound/soc/tegra/tegra_wm8903.c's probe function about
half-way through. Then, functions use snd_soc_card_get_drvdata to
retrieve that later.

-- 
nvpublic
