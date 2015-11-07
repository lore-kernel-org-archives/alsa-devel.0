From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: Intel: Skylake: Adding
 nau88l25+ssm4567 machine driver
Date: Sat, 7 Nov 2015 09:24:08 -0800
Message-ID: <CAOMFOmVKfhbQwwszo-FtnZJO_4cgJogtn-u9fA8_vVXz0jm+ug@mail.gmail.com>
References: <1446744188-1274-1-git-send-email-vinod.koul@intel.com>
 <1446744188-1274-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f43.google.com (mail-vk0-f43.google.com
 [209.85.213.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3806C2606B2
 for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2015 18:24:10 +0100 (CET)
Received: by vkex70 with SMTP id x70so33763921vke.3
 for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2015 09:24:09 -0800 (PST)
In-Reply-To: <1446744188-1274-3-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, patches.audio@intel.com, Conrad Cooke <conrad.cooke@intel.com>, liam.r.girdwood@linux.intel.com, Harsha Priya <harshapriya.n@intel.com>, Mark Brown <broonie@kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, Naveen M <naveen.m@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi


On Thu, Nov 5, 2015 at 9:23 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> From: Harsha Priya <harshapriya.n@intel.com>
>
> Add i2s machine driver with NAU88L25 and SSM4567 codecs

The mainline driver name is NAU8825. I suggest to stay consistent with
the codec name.

Nuvoton's documentation mostly refers the codec by name NAU8825 though
NAU88L25 is used as well.
