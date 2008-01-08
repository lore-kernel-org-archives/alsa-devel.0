From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC drivers for the Freescale MPC8610
	SoC
Date: Tue, 08 Jan 2008 12:38:12 +0000
Message-ID: <1199795892.19903.74.camel@localhost.localdomain>
References: <1199732204949-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	by alsa0.perex.cz (Postfix) with ESMTP id E88A924AF4
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 13:38:15 +0100 (CET)
In-Reply-To: <1199732204949-git-send-email-timur@freescale.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2008-01-07 at 12:56 -0600, Timur Tabi wrote:
> These patches add ALSA SoC device drivers for the Freescale MPC8610 SoC
> and the MPC8610-HPCD reference board.
> 
> The first patch updates some files in arch/powerpc and booting-without-of.txt.
> 
> The second patch adds the new audio driver files to sound/soc.
> 
> Both must be applied in order to avoid a build break.
> 
 
Both applied to the dev branch. This should let others use them atm and
allow us to port to ASoC v2.

I'll make a start on the port now.

Liam
