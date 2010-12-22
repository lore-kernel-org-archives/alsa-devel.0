From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: SAMSUNG: Debug wrong parameter
Date: Wed, 22 Dec 2010 10:55:58 +0000
Message-ID: <1293015358.3329.15.camel@odin>
References: <1293011184-5171-1-git-send-email-sw.youn@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B3FB2103C28
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 11:56:01 +0100 (CET)
Received: by wyi11 with SMTP id 11so4726919wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 02:56:01 -0800 (PST)
In-Reply-To: <1293011184-5171-1-git-send-email-sw.youn@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <sw.youn@samsung.com>
Cc: cw00.choi@samsung.com, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, jassi.brar@samsung.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-12-22 at 18:46 +0900, Seungwhan Youn wrote:
> snd_soc_jack_new()'s first parameter was changed from snd_soc_card to
> snd_soc_codec after Multi-Component support patches. So, this patch
> fixes parameter that we missed.
> 
> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
> ---
> This patch-mail is just for sure about mail-delivery, because privious mail
> that I sent(with same subject and content) doesn't look deliver to alsa-devel
> mailing list. So, if you received same mail before few hours ago, please
> ignore this mail.
> 
> Thanks,
> Claude

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
