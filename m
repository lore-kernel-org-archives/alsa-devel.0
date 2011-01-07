From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: SAMSUNG: Clean-up header includes
Date: Fri, 7 Jan 2011 20:22:27 +0900
Message-ID: <AANLkTikW6-B5O5CCD80-Z2wCuJcgTAAszLatEW+DwJ4P@mail.gmail.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
	<1294376262-18364-1-git-send-email-sw.youn@samsung.com>
	<AANLkTim+ANz=cszy4gbiWAToPFAMokKe3z9JCZVzHddm@mail.gmail.com>
	<AANLkTikZQcxG85Ebjbf_gXbe_VBX-o8Zsg=QdUnuDUhB@mail.gmail.com>
	<20110107103855.GA9209@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 22FCB24386
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 12:22:28 +0100 (CET)
Received: by wyi11 with SMTP id 11so17209903wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 07 Jan 2011 03:22:27 -0800 (PST)
In-Reply-To: <20110107103855.GA9209@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 7, 2011 at 7:38 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jan 07, 2011 at 04:03:46PM +0900, Seungwhan Youn wrote:
>
>> As you know, 'include/sound/soc.h' has some general linux's includes.
>> So I made these sequence to prevent dependency problem, because
>> reverse including could have some problem, if linux's includes has
>> their dependencies.
>
> If there's dependency problems in the core headers we should just fix
> those, users shouldn't need to worry about that sort of stuff.

Hmm... I see. I'll re-submit this patch which applies Jassi's
suggestion with compile test. ;)

Thanks.
claude
