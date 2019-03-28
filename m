From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH] ASoC: mt8183: change supported formats of
 DL2 and UL1
Date: Thu, 28 Mar 2019 14:59:56 +0800
Message-ID: <CA+Px+wUp+QXNSmwT6j7vYiQ8RA7aubrva2Y8k5HJTcBwaZGdKw@mail.gmail.com>
References: <20190327064236.144843-1-tzungbi@google.com>
 <1553732888.13776.2.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C7F9F80C16
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 08:00:08 +0100 (CET)
Received: by mail-ot1-x343.google.com with SMTP id u15so17311531otq.10
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 00:00:08 -0700 (PDT)
In-Reply-To: <1553732888.13776.2.camel@mtksdaap41>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, Jimmy Cheng-Yi Chiang <cychiang@google.com>, =?UTF-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <jiaxin.yu@mediatek.com>, broonie@kernel.org, =?UTF-8?B?U2h1bmxpIFdhbmcgKOeOi+mhuuWIqSk=?= <shunli.wang@mediatek.com>, eason.yen@mediatek.com, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I see.  This is common code for all 8183 platform and indeed a wrong place
to confine the formats.

Please ignore this patch.

On Thu, Mar 28, 2019 at 8:28 AM KaiChieh Chuang <
kaichieh.chuang@mediatek.com> wrote:

> On Wed, 2019-03-27 at 14:42 +0800, Tzung-Bi Shih wrote:
> > DL2 and UL1 should only provide 16-bit, mono, 8kHz and 16kHz to
> > userspace.  Change the formats accordingly.
> >
> > Signed-off-by: Tzung-Bi Shih <tzungbi@google.com>
>
> Hi,
>         i thought we should report hardware capabilities, not user space's
> intention?
>
>
