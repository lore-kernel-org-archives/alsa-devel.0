From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH] ASoC: Suppress restore of default register values
 for lzo cache sync
Date: Thu, 13 Oct 2011 11:57:48 +0100
Message-ID: <20111013105747.GE5193@opensource.wolfsonmicro.com>
References: <1318498113.2857.16.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318498113.2857.16.camel@phoenix>
Sender: linux-kernel-owner@vger.kernel.org
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 13, 2011 at 05:28:33PM +0800, Axel Lin wrote:
> Currently we do suppress restore of default register values for rbtree
> and flat cache sync.
> A couple users use this trick to avoid writing reset register while resume.
> Thus make lzo cache sync suppress restore of default register values,
> so we have consistent behavior for all types of cache sync.

Given that we never acquired any in tree users for the LZO cache it'd
probably be as well to just work on the regmap version and deprecate
this one - there's no users to move over and it'll save effort.
