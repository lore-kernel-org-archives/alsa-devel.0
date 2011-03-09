From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Simplify WM9081 speaker startup by
 using widgets for spaker output
Date: Wed, 09 Mar 2011 11:55:03 +0000
Message-ID: <1299671703.3360.85.camel@odin>
References: <1299610355-17455-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 34C391039A1
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:55:07 +0100 (CET)
Received: by wyj26 with SMTP id 26so347300wyj.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 03:55:07 -0800 (PST)
In-Reply-To: <1299610355-17455-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-03-08 at 18:52 +0000, Mark Brown wrote:
> Now we have a register write minimisation code in DAPM we don't need to
> worry about the ordering of the enable and disable of the PGA and the
> output stage.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
