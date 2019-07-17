From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Is there a way to support TX master mode and RX
 slave mode?
Date: Wed, 17 Jul 2019 11:02:05 -0500
Message-ID: <548bda36-b81f-1811-7969-e80e698ecfa3@linux.intel.com>
References: <VE1PR04MB6479C4D2CD4B9D486209102FE3CE0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F7F6F800C2
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2019 18:02:10 +0200 (CEST)
In-Reply-To: <VE1PR04MB6479C4D2CD4B9D486209102FE3CE0@VE1PR04MB6479.eurprd04.prod.outlook.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "S.j. Wang" <shengjiu.wang@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 7/16/19 3:35 AM, S.j. Wang wrote:
> Hi  Experts
> 
> Is there a way to support TX master mode but RX slave mode?  It seems current .set_fmt only set same mode for TX and RX.

good question if you are thinking of supporting the 6-pin versions of 
I2S interfaces with independent bit clock and frame sync on RX and TX
Looking at the topology definition it could be that this mode needs to 
be handled with separate dailinks. Adding Mark in case he didn't see 
this question.
