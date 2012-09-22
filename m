From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Let it understand mono
Date: Sat, 22 Sep 2012 10:56:20 -0400
Message-ID: <20120922145619.GB4495@opensource.wolfsonmicro.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
 <50589DD7.8050409@freescale.com>
 <CAOMZO5D-oHc8hdakFHPHSW_duAZ+dMuM77wUn=K=7jUMwxmg-A@mail.gmail.com>
 <505A3DDB.4060208@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 14A66261640
 for <alsa-devel@alsa-project.org>; Sat, 22 Sep 2012 16:56:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <505A3DDB.4060208@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Fabio Estevam <festevam@gmail.com>, javier.martin@vista-silicon.com, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 19, 2012 at 04:49:15PM -0500, Timur Tabi wrote:

> I still have seen no explanation as to how mono audio can work on an I2S
> device.  The I2S standard calls for a left and right channel in every
> sample, and the playback frequency is based on that sample rate.

In I2S mono just means ignoring the right channel or duplicating the
left channel into the right channel at one end of the link or the other.
As you say the clocking always has to be for an even number of channels.
