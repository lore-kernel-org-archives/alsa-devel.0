From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 6/6 v2] ASoC: fsl_ssi: adjust set DAI
 format in AC'97 mode
Date: Tue, 04 Aug 2015 00:42:48 +0200
Message-ID: <55BFEE68.7030007@maciej.szmigiero.name>
References: <55BA364E.1000803@maciej.szmigiero.name>
 <20150731055843.GX30895@pengutronix.de>
 <55BB9082.4030206@maciej.szmigiero.name>
 <20150802185103.GD19600@pengutronix.de>
 <55BE9D3B.3090303@maciej.szmigiero.name>
 <20150803162147.GB20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F10B2605E8
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 00:42:59 +0200 (CEST)
In-Reply-To: <20150803162147.GB20873@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Fabio Estevam <festevam@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

On 03.08.2015 18:21, Mark Brown wrote:
> On Mon, Aug 03, 2015 at 12:44:11AM +0200, Maciej S. Szmigiero wrote:
>> Adjust set DAI format function in fsl_ssi driver
>> so it doesn't fail and clears RXDIR in AC'97 mode.
>>
>> Changes from v1: fix indentation to be consistent with rest
>> of the driver.
> 
> Inter version changelogs go after the --- as covered in
> SubmittingPatches.
> 
>>
>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
> 
> Please don't bury new patches in reply to old submissions, especially
> not individual patches - it makes it hard to work out what's going on
> and make sure that the most current version of everything is being
> applied.  In order to avoid confusion I'm not going to look at these,
> please resubmit as a new thread.
> 
> Please also try to thread your patch series together (git send-email can
> do this for you) - it also helps people keep track of things.

Thanks for information.

In cases like this where only one patch of six patch series is updated
should other ones be resubmitted as well to keep the full patch series
together?

Best regards,
Maciej Szmigiero
