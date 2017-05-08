From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 2/9] of_graph: add
	of_graph_get_remote_endpoint()
Date: Mon, 8 May 2017 12:08:42 -0500
Message-ID: <CAL_JsqLHSLyNgNv8JOxaxSf+_sUAG6h9_npLLnN9+_DbobW_pA@mail.gmail.com>
References: <87fuh3oon8.wl%kuninori.morimoto.gx@renesas.com>
 <87d1c7ool6.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_JsqLB=tqai6cDr6Cr0=sL+0au__Gr2uw5gqr0Q8muhsL3=A@mail.gmail.com>
 <87shkgcgl7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6B1266483
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 19:09:08 +0200 (CEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id E87102024D
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 17:09:05 +0000 (UTC)
Received: from mail-yw0-f177.google.com (mail-yw0-f177.google.com
 [209.85.161.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D5D6E20219
 for <alsa-devel@alsa-project.org>; Mon,  8 May 2017 17:09:03 +0000 (UTC)
Received: by mail-yw0-f177.google.com with SMTP id l135so32527522ywb.2
 for <alsa-devel@alsa-project.org>; Mon, 08 May 2017 10:09:03 -0700 (PDT)
In-Reply-To: <87shkgcgl7.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

On Sun, May 7, 2017 at 8:00 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Rob
> Cc Mark
>
>> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> >
>> > It should use same method to get same result.
>> > To getting remote-endpoint node,
>> > let's use of_graph_get_remote_endpoint()
>> >
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > ---
>> > v6 -> v7
>> >
>> >  - no change
>> >
>> >  drivers/of/base.c        | 18 ++++++++++++++++--
>> >  include/linux/of_graph.h |  8 ++++++++
>> >  2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Thank you for your Acked-by.
> But, does these mean, Mark (= ALSA SoC maintainer)
> can pickup all OF-graph related patches ?

Yes, that's usually the easiest way to deal with a series with cross
tree dependencies.

Rob
