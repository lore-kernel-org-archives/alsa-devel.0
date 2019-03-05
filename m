From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Tue, 5 Mar 2019 09:23:46 -0500
Message-ID: <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E267EF896CE
 for <alsa-devel@alsa-project.org>; Tue,  5 Mar 2019 15:23:59 +0100 (CET)
Received: by mail-oi1-x243.google.com with SMTP id t206so6936674oib.3
 for <alsa-devel@alsa-project.org>; Tue, 05 Mar 2019 06:23:59 -0800 (PST)
In-Reply-To: <20190305044232.GA15636@workstation>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Mon, Mar 4, 2019 at 11:42 PM Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
>
> Anyway, when posting to change UAPI of Linux sound subsystem, it's
> better to describe the reason fot new stuffs; what they're designed for,
> and the reason to require them. Wnen posting in a result of series of
> discussion done previously, it's better to add any reference to it.

My apologies for not linking in previous discussions, I'll certainly make
sure to link in the future.

The original problem was that the fsl_ssi did not appear to work with the
tda998x hdmi codec. This codec seems to be 'unique' in the sense that it
needs to know the number of clocks per frame on the wire, i.e. the bclk_ratio,
which no-one in alsa is providing or using at the moment.

I first made the error of conflating the physical width and the bclk_ratio,
and posted this patch - Russell King quickly pointed out my error:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/145916.html

This then led to the following discussions:
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145985
https://mailman.alsa-project.org/pipermail/alsa-devel/2019-February/thread.html#145947

Most of the discussion is about a mechanism to convey bclk_ratio from
the frame master
to the tda998x. We don't yet seem to have a consensus on how to do this best.

My rfc patch was only intended to provoke discussion, and to allow
people to experiment
with a flawed solution that would allow the alsa core to negotiate
bclk_ratio between
components. The uapi change is a serious flaw. bclk_ratio negotiation should be
invisible to userspace. But I cannot see a way to accomplish this.

Sven
