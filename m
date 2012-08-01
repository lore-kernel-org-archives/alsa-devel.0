From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Revert "ASoC: core: Try to use regmap if
 the driver doesn't set up any I/O"
Date: Wed, 1 Aug 2012 16:22:48 +0100
Message-ID: <20120801152248.GZ11892@opensource.wolfsonmicro.com>
References: <1343829022-23259-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B22E7265D23
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 17:31:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1343829022-23259-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 01, 2012 at 04:50:22PM +0300, Peter Ujfalusi wrote:
> Some codec driver can not have regmap implementation so core should not
> assume that codecs without control_data have implemented regmap of it's
> own.
> 
> This reverts commit 38cbf9598feba97de9f9b43efa9153fd7c1a2ec9.

No, this isn't constructive - it just shoves things onto the drivers
that are relying on the implicit functionality.  Why not just change the
criteria we use to check, for example looking for the ops instead?
