From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 2.6.38] ASoC: Fix build error caused by
 merging a fix for 2.6.37 into 2.6.38
Date: Fri, 10 Dec 2010 23:02:33 +0000
Message-ID: <1292022153.3422.26.camel@odin>
References: <1292007235-22090-1-git-send-email-jhnikula@gmail.com>
	<1292007289-22124-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 14E2124627
	for <alsa-devel@alsa-project.org>; Sat, 11 Dec 2010 00:02:37 +0100 (CET)
Received: by wwe15 with SMTP id 15so4035702wwe.20
	for <alsa-devel@alsa-project.org>; Fri, 10 Dec 2010 15:02:36 -0800 (PST)
In-Reply-To: <1292007289-22124-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-12-10 at 20:54 +0200, Jarkko Nikula wrote:
> Fix "ASoC: Fix bias power down of non-DAPM codec" for 3.6.37 will cause a
> build error when merging into ASoC for-2.6.38. Fix the issue by doing a
> change that commit ce6120c "ASoC: Decouple DAPM from CODECs" would do.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> ---
> Ideally this would be squashed in ce6120c "ASoC: Decouple DAPM from CODECs".
> ---

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
