From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v4 00/17] ASoC: fsl_ssi: Clean up - program
	flow level
Date: Wed, 17 Jan 2018 01:11:29 +0100
Message-ID: <301c4cb1-d0ad-4fe8-0388-059d355b4c2e@maciej.szmigiero.name>
References: <1516058192-65519-1-git-send-email-nicoleotsuka@gmail.com>
 <56fb5b43-383f-c0f2-360c-eef0e4d0844f@maciej.szmigiero.name>
 <20180116235258.GA6849@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F31A266E62
 for <alsa-devel@alsa-project.org>; Wed, 17 Jan 2018 01:11:34 +0100 (CET)
In-Reply-To: <20180116235258.GA6849@Asurada-Nvidia>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, caleb@crome.org, timur@tabi.org, broonie@kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 17.01.2018 00:52, Nicolin Chen wrote:
> On Wed, Jan 17, 2018 at 12:38:09AM +0100, Maciej S. Szmigiero wrote:
> 
>>> Example of uncovered tests: AC97, PowerPC and FIQ.
>>
>> I've tested the whole series in the AC'97 mode on an i.MX6 UDOO board
>> and everything seems to work fine as long as few small changes are made
>> to patches 13 and 16.
> 
> Thanks for the review and testing. Really appreciate that. I'll
> take care of those issues in the next version.
Thanks for these cleanups Nicolin!

> And I believe those issues are confined to AC97. So Caleb should
> be able to skip his test if only these two places get updated.
> (Thanks for keeping testing on each version.)

Yes, these required changes only affect the AC'97 mode, there
shouldn't be any functionality change in the I2S mode.

Maciej
