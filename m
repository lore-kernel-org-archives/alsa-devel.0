From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: properly initialize the
 sysfs attribute object
Date: Tue, 15 Nov 2011 11:59:43 +0000
Message-ID: <20111115115943.GE3077@opensource.wolfsonmicro.com>
References: <1321310126-12614-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id AE844243F9
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2011 12:59:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321310126-12614-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 14, 2011 at 04:35:26PM -0600, Timur Tabi wrote:
> Commit 6992f533 ("sysfs: Use one lockdep class per sysfs attribute")
> requires 'struct attribute' objects to be initialized with sysfs_attr_init().

Applied, thanks (for stable).
