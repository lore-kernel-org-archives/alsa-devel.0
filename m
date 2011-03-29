From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: SSM2602: fix codec name
Date: Tue, 29 Mar 2011 21:26:28 +0100
Message-ID: <1301430388.3402.3.camel@odin>
References: <1301201053-3841-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DBDCF1039D1
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 22:26:32 +0200 (CEST)
Received: by mail-wy0-f179.google.com with SMTP id 36so543911wyg.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Mar 2011 13:26:32 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-03-27 at 00:44 -0400, Mike Frysinger wrote:
> The codec name should not have a "-codec" suffix since this is not part of
> a MFD.  This was incorrectly changed during the multi-component updated.
> 
> Signed-off-by: Mike Frysinger <vapier@gentoo.org>

Acked-by: Liam Girdwood <lrg@ti.com>
