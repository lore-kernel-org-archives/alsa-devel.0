From: Daniel Drake <drake@endlessm.com>
Subject: Re: [RFC PATCH 0/6] ALSA/HDA: abort probe when DMICs
	are detected
Date: Fri, 24 May 2019 09:45:21 -0600
Message-ID: <CAD8Lp47qCbPh+aZjr0pjzZAcBXqRbMU+5Y_HPy7jrJhUgsD3Tg@mail.gmail.com>
References: <20190523233951.31122-1-pierre-louis.bossart@linux.intel.com>
 <s5hk1ege12p.wl-tiwai@suse.de>
 <284f78d4-ec5a-0ff1-2b67-2977b3634692@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C05DF80C0F
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 17:45:34 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id o2so7897601qkb.3
 for <alsa-devel@alsa-project.org>; Fri, 24 May 2019 08:45:34 -0700 (PDT)
In-Reply-To: <284f78d4-ec5a-0ff1-2b67-2977b3634692@linux.intel.com>
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

Thanks for the patches!

On Fri, May 24, 2019 at 7:26 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> I am not sure if it's a good idea to enable this by default, the
> experience of the first round showed it's risky to make assumptions on
> what BIOS vendors implemented.

Can you clarify what you mean here, are you saying you don't want to
enable this new DMIC hardware support by default?

Daniel
