From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: Re: Questions regarding ASoC
Date: Fri, 7 Jan 2011 12:28:58 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F47005A329E@irsmsx501.ger.corp.intel.com>
References: <2A84145621092446B6659B8A0F28E26F47003D6535@irsmsx501.ger.corp.intel.com>
	<201012071530.30789.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E8BB2103803
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 13:29:53 +0100 (CET)
In-Reply-To: <201012071530.30789.peter.ujfalusi@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> The driver in upstream at the moment handle only one DAI from the wl1273 (the
> shared BT/FM dai). wl1273 actually have 2 DAI, but the dedicated FM DAI
> support is not implemented.
> The codec driver can handle:
> BT playback/capture (full duplex)
> FM playback/capture (half duplex)
[Selma] in function wl1273_startup (due to the mode WL1273_MODE_BT) sets a constraint min/max to the HW RATE equal to 8000. However the FM runs @48000, did I miss something?

Thanks,
Selma.
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
