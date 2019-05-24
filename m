From: Daniel Drake <drake@endlessm.com>
Subject: Re: [RFC PATCH 0/6] ALSA/HDA: abort probe when DMICs
	are detected
Date: Fri, 24 May 2019 13:33:34 -0600
Message-ID: <CAD8Lp46B523hZ5jRya5HFcRK6ZHL7JxRFj=FiGPf47aaVuUbog@mail.gmail.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <s5hk1ege12p.wl-tiwai@suse.de>
 <284f78d4-ec5a-0ff1-2b67-2977b3634692@linux.intel.com>
 <CAD8Lp47qCbPh+aZjr0pjzZAcBXqRbMU+5Y_HPy7jrJhUgsD3Tg@mail.gmail.com>
 <72729168-214a-264d-c704-f718d7cfde4b@linux.intel.com>
 <CAD8Lp47Yc5CwkM-y=eqXdPDZ7+1=qa6m1sCELhBsidsYYSzfQQ@mail.gmail.com>
 <d399bbcb-c094-d0b9-5ae3-8267ee613d6f@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF35CF89625
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 21:33:47 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id w25so9151473qkj.11
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 12:33:47 -0700 (PDT)
In-Reply-To: <d399bbcb-c094-d0b9-5ae3-8267ee613d6f@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Curtis Malainey <cujomalainey@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 24, 2019 at 12:38 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> > In the case of DMICs attached to PCH and BIOS/NHLT reports DMIC, is
> > the HDaudio legacy probe aborted by default or not?
>
> no.

Thanks for the clarification. The plan makes sense to me! I'll check
if we have any more devices available with DMIC where we can test.

Daniel
