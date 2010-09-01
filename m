From: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH 2/4] sound/soc/fsl/p1022_ds.c: Add
 of_node_put to avoid memory leak
Date: Wed, 1 Sep 2010 13:39:04 -0500
Message-ID: <AANLkTinpRVStYfHHaGTyLusMCjMQDH=MvcGVVKaxvHtN@mail.gmail.com>
References: <1283269738-14612-1-git-send-email-julia@diku.dk> <1283269738-14612-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283269738-14612-3-git-send-email-julia@diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia@diku.dk>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 31, 2010 at 10:48 AM, Julia Lawall <julia@diku.dk> wrote:
> Add a call to of_node_put in the error handling code following a call=
 to
> of_parse_phandle.
>
> This patch also moves the existing call to of_node_put tothe end of t=
he
> error handling code, to make it possible to jump to of_node_put witho=
ut
> doing the other cleanup operations. =A0These appear to be disjoint
> operations, so the ordering doesn't matter.

Acked-by: Timur Tabi <timur@freescale.com>

Thanks, Julia.

--=20
Timur Tabi
Linux kernel developer at Freescale
