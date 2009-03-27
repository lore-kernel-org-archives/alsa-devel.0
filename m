From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2.6.30] ASoC: trim SSI sysfs statistics
	in	Freescale MPC8610 sound drivers
Date: Fri, 27 Mar 2009 11:39:00 +0000
Message-ID: <20090327113900.GA9621@sirena.org.uk>
References: <1238085758-5964-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 09CFC10388F
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 12:39:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1238085758-5964-1-git-send-email-timur@freescale.com>
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

On Thu, Mar 26, 2009 at 11:42:38AM -0500, Timur Tabi wrote:
> Optimize the display of SSI statistics in the Freescale MPC8610 sound driver
> to display the status count only of the interrupts that were actually enabled.
> Previously, it would display the counts of all SISR status bits, even those
> that were not enabled.

> Signed-off-by: Timur Tabi <timur@freescale.com>

Applied, thanks.
