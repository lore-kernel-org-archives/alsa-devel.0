From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [resend][PATCH v5 01/10] of_graph: export symbol
	of_phandle_iterator_init/next
Date: Mon, 17 Apr 2017 19:06:45 -0500
Message-ID: <CAL_Jsq+q0Nj7M07AaXqS97Wi8L7c7xn+s5E5ZjTZfEb_hrOrog@mail.gmail.com>
References: <87bmrvvqgs.wl%kuninori.morimoto.gx@renesas.com>
 <87a87fvqfc.wl%kuninori.morimoto.gx@renesas.com>
 <CAL_JsqJSN88P2D8sbWimxTjc=mUPBV4H7hfLzHCLmzZbOcZzQg@mail.gmail.com>
 <87zifey47b.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 122AC266CA1
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 02:07:09 +0200 (CEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 04B68203B4
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 00:07:08 +0000 (UTC)
Received: from mail-yw0-f173.google.com (mail-yw0-f173.google.com
 [209.85.161.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 11AB7203AA
 for <alsa-devel@alsa-project.org>; Tue, 18 Apr 2017 00:07:06 +0000 (UTC)
Received: by mail-yw0-f173.google.com with SMTP id u70so20522266ywe.2
 for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2017 17:07:06 -0700 (PDT)
In-Reply-To: <87zifey47b.wl%kuninori.morimoto.gx@renesas.com>
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

On Mon, Apr 17, 2017 at 7:05 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Rob
>
>> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> >
>> > of_for_each_phandle() uses of_phandle_iterator_init/next
>> > but these aren't exported. So kernel module complile will say
>> >
>> > ERROR: "of_phandle_iterator_init" [xxx.ko] undefined!
>> > ERROR: "of_phandle_iterator_next" [xxx.ko] undefined!
>> >
>> > This patch solves this issue
>> >
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>
> Thanks.
> But I wonder you are the maintainer of of_graph ?

get_maintainers.pl can answer that for you: yes.

Rob
