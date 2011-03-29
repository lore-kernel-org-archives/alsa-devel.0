From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: SSM2602: fix codec name
Date: Wed, 30 Mar 2011 07:18:25 +0900
Message-ID: <20110329221824.GE30482@opensource.wolfsonmicro.com>
References: <1301201053-3841-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA5DC103817
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Mar 2011 00:18:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301201053-3841-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 27, 2011 at 12:44:10AM -0400, Mike Frysinger wrote:
> The codec name should not have a "-codec" suffix since this is not part of
> a MFD.  This was incorrectly changed during the multi-component updated.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Applied all, thanks.
