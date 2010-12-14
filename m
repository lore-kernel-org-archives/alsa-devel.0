From: "Bensaid, Selma" <selma.bensaid@intel.com>
Subject: Re: Questions regarding ASoC
Date: Tue, 14 Dec 2010 17:04:10 +0000
Message-ID: <2A84145621092446B6659B8A0F28E26F47005248EE@irsmsx501.ger.corp.intel.com>
References: <2A84145621092446B6659B8A0F28E26F47003D6535@irsmsx501.ger.corp.intel.com>
	<201012071530.30789.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 05C7D103819
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2010 18:04:17 +0100 (CET)
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

> Take a look at sound/soc/codecs/wl1273.c
> You might need the v4l2 and the MFD parts for the wl1273.
> 
[Selma] do you plan to handle the audio path configuration for BT and FM within your driver.
Since BT and FM are sharing the same DAI, some HCI commands are required to configure the
audio path. We have identified with TI a different set of commands depending of the audio
connection used on the platform: internal or external connection.
Does the WL1273 intend to substitute some of the V4L2 interfaces like the volume?
Since the BT/FM driver I'm working on provides only PCM devices, why do you think that
I might need v4l2?

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
