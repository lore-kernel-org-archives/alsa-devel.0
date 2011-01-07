From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: SAMSUNG: Clean-up header includes
Date: Fri, 7 Jan 2011 16:03:46 +0900
Message-ID: <AANLkTikZQcxG85Ebjbf_gXbe_VBX-o8Zsg=QdUnuDUhB@mail.gmail.com>
References: <1294375429-16729-1-git-send-email-sw.youn@samsung.com>
	<1294376262-18364-1-git-send-email-sw.youn@samsung.com>
	<AANLkTim+ANz=cszy4gbiWAToPFAMokKe3z9JCZVzHddm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1E13B246C9
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2011 08:03:48 +0100 (CET)
Received: by wyi11 with SMTP id 11so17039066wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 06 Jan 2011 23:03:46 -0800 (PST)
In-Reply-To: <AANLkTim+ANz=cszy4gbiWAToPFAMokKe3z9JCZVzHddm@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, jassi.brar@samsung.com, Seungwhan Youn <sw.youn@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 7, 2011 at 3:08 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> On Fri, Jan 7, 2011 at 1:57 PM, Seungwhan Youn <sw.youn@samsung.com> wrote:
>> This patch remove including unnecessary/duplicated headers which relative
>> with Samsung SoCs.
>>
>> Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
>
> I think we'd better keep sound includes after linux's.

As you know, 'include/sound/soc.h' has some general linux's includes.
So I made these sequence to prevent dependency problem, because
reverse including could have some problem, if linux's includes has
their dependencies.

Do we really keep this, 'sound includes after linux's'? :(

Thanks
