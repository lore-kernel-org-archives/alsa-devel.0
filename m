From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [REANNOUNCE] Audio Mini Summit 2015, 8th October,
 Dublin
Date: Mon, 03 Aug 2015 14:11:48 -0500
Message-ID: <55BFBCF4.2080508@linux.intel.com>
References: <20150714150352.GW11162@sirena.org.uk> <55BC772C.50801@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B2FE2605CD
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 21:11:53 +0200 (CEST)
In-Reply-To: <55BC772C.50801@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> Full media controller integration for both ALSA and ASoC. How this can be
> used to export topology information to userspace and how to for example
> attach a specific volume control to a specific media controller entity. And
> maybe also how to de-duplicate similar functionality between DAPM and media
> controller.

This is something I looked at, without much progress though beyond a set 
of initial patches to make use of the media controller API. There were 
two issues:
- one was to agree on a syntax/format for the (binary) topology 
information exposed by the kernel.
- the main issue was really how to link a user-visible volume slider to 
a specific or group of volume controls. A number of people have tried 
this before in other contexts and it's really hard to do based on 
topology information only.

But yes a good topic to re-discuss
-Pierre
