From: D Krishna Mohan <krishna.md@samsung.com>
Subject: Re: [PATCH 2/4 V3] ASoC: Samsung: Add arndale_rt5631 machine driver
Date: Mon, 24 Nov 2014 12:25:14 +0530
Message-ID: <77483D66251948E89F52C86B58891F8A@sisodomain.com>
References: <1415880864-2246-1-git-send-email-krishna.md@samsung.com>
 <1415880864-2246-3-git-send-email-krishna.md@samsung.com>
 <20141119175154.GI22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20141119175154.GI22111@sirena.org.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, kgene.kim@samsung.com, Claude Youn <claude.youn@gmail.com>
List-Id: alsa-devel@alsa-project.org

machine DT binding file added and patch sent.

-Krishna
--------------------------------------------------
From: "Mark Brown" <broonie@kernel.org>
Sent: Wednesday, November 19, 2014 11:21 PM
To: "Krishna Mohan Dani" <krishna.md@samsung.com>
Cc: <linux-samsung-soc@vger.kernel.org>; 
<linux-arm-kernel@lists.infradead.org>; <alsa-devel@alsa-project.org>; 
<kgene.kim@samsung.com>; "Claude Youn" <claude.youn@gmail.com>
Subject: Re: [PATCH 2/4 V3] ASoC: Samsung: Add arndale_rt5631 machine driver

On Thu, Nov 13, 2014 at 05:44:22PM +0530, Krishna Mohan Dani wrote:

> Signed-off-by: Krishna Mohan Dani <krishna.md@samsung.com>
> ---
>  sound/soc/samsung/Kconfig          |    6 ++
>  sound/soc/samsung/Makefile         |    2 +
>  sound/soc/samsung/arndale_rt5631.c |  150 
> ++++++++++++++++++++++++++++++++++++
>  3 files changed, 158 insertions(+)

This is fine but it is missing a binding document, please add one.
 
