From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/2] ASoC: Use DAPM context rather than
 CODEC when constructing sequences
Date: Mon, 15 Nov 2010 13:10:59 +0000
Message-ID: <1289826659.3377.32.camel@odin>
References: <1289577671-13837-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1289577671-13837-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E9A61103824
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 14:11:02 +0100 (CET)
Received: by wwb17 with SMTP id 17so2751510wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 05:11:02 -0800 (PST)
In-Reply-To: <1289577671-13837-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Fri, 2010-11-12 at 16:01 +0000, Mark Brown wrote:
> DAPM widgets may be associated with non-CODEC devices so compare based
> on the DAPM context rather than the CODEC pointer.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Both

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
