From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610 codec
	driver naming
Date: Tue, 3 Jun 2008 09:41:14 +0100
Message-ID: <20080603084113.GB11006@rakim.wolfsonmicro.main>
References: <1212447336-13492-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E2791103820
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Jun 2008 10:41:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1212447336-13492-1-git-send-email-timur@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 02, 2008 at 05:55:36PM -0500, Timur Tabi wrote:
> Change the Freescale MPC8610 HPCD codec and fabric drivers to use the codec
> name and id, instead of just the name, to match codec instances.  Previously,
> the codec and fabric drivers would create a name string based on the
> I2C bus and address.  Instead, keep the name as "cs4270" and combine the
> bus and address into a unique number.

Applied, thanks.
