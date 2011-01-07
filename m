From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: SAMSUNG: Clean-up header includes
Date: Fri, 7 Jan 2011 10:38:56 +0000
Message-ID: <20110107103855.GA9209@opensource.wolfsonmicro.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
	<1294376262-18364-1-git-send-email-sw.youn@samsung.com>
	<AANLkTim+ANz=cszy4gbiWAToPFAMokKe3z9JCZVzHddm@mail.gmail.com>
	<AANLkTikZQcxG85Ebjbf_gXbe_VBX-o8Zsg=QdUnuDUhB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EED7524335
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 11:38:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTikZQcxG85Ebjbf_gXbe_VBX-o8Zsg=QdUnuDUhB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Seungwhan Youn <claude.youn@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 07, 2011 at 04:03:46PM +0900, Seungwhan Youn wrote:

> As you know, 'include/sound/soc.h' has some general linux's includes.
> So I made these sequence to prevent dependency problem, because
> reverse including could have some problem, if linux's includes has
> their dependencies.

If there's dependency problems in the core headers we should just fix
those, users shouldn't need to worry about that sort of stuff.
