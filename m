From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] Asoc: WM8994: fix wrong value in tristate
	function
Date: Wed, 19 Jan 2011 12:44:59 +0000
Message-ID: <1295441099.3328.92.camel@odin>
References: <1295435447-1569-1-git-send-email-zhouqiao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CF1010399C
	for <Alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 13:45:03 +0100 (CET)
Received: by wwe15 with SMTP id 15so790388wwe.20
	for <Alsa-devel@alsa-project.org>; Wed, 19 Jan 2011 04:45:02 -0800 (PST)
In-Reply-To: <1295435447-1569-1-git-send-email-zhouqiao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Qiao Zhou <zhouqiao@marvell.com>
Cc: Alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-01-19 at 19:10 +0800, Qiao Zhou wrote:
> fix wrong value in wm8994_set_tristate func. when updating reg bits,
> it should use "value", not "reg".
> 
> Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
