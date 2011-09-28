From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 3/6] ASoC: Remove unused "control_data" field of struct
 cs4270_private
Date: Wed, 28 Sep 2011 14:30:53 -0500
Message-ID: <4E8375ED.1060209@freescale.com>
References: <1317175218.14102.1.camel@phoenix> <1317175838.14102.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1317175838.14102.4.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Axel Lin wrote:
> The control_data field is used to initialize the codec's control_data field,
> but since this is also done by the snd-soc-cache core, the redundant
> assignment can be removed and the field can be dropped.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---

Acked-by: Timur Tabi <timur@freescale.com>

Although Mark, it would have been nice if you had given me a chance to test this
change before applying the patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
