From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: Re: ASoC SSP Driver Question
Date: Mon, 10 Jan 2011 12:46:29 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F47005A3561@irsmsx501.ger.corp.intel.com>
References: <2A84145621092446B6659B8A0F28E26F47005A34FF@irsmsx501.ger.corp.intel.com>
	<4D2AF42F.80308@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 51D8924479
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 13:46:34 +0100 (CET)
In-Reply-To: <4D2AF42F.80308@nokia.com>
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
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Aaltonen Matti Johannes <matti.j.aaltonen@nokia.com>, "Le Gall,
	Louis" <louis.le.gall@intel.com>
List-Id: alsa-devel@alsa-project.org

> Are you using the the existing ASoC codec driver for WL1273? It is in
> the tree:
> sound/soc/codecs/wl1273.*
> 
> I have put Matti Aaltonen, the author of the codec driver to the CC list.
Yes, I'm planning to use this codec driver however I'm not sure that it 
supports the FM capture. 
According to the code, the codec handles the WL1273_MODE_BT mode only. 
The ASoC driver I'm working on handles both BT and FM.
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
