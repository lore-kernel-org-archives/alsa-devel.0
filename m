From: Vinod Koul <vinod.koul@intel.com>
Subject: Re:
 =?utf-8?q?=5BPATCH_09/14=5D_ASoC=3A_max9867=3A_remov?=
 =?utf-8?b?ZSB1bnVzZWQg4oCYcmV04oCZ?=
Date: Fri, 9 Dec 2016 12:26:13 +0530
Message-ID: <20161209065613.GI6408@localhost>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
 <1481218297-17568-10-git-send-email-vinod.koul@intel.com>
 <CAOMZO5C5WHW+a4F5gTV2T5xw3pMjrvkr4JsfS7rxU7d2=-tbKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BB6E2676BF
 for <alsa-devel@alsa-project.org>; Fri,  9 Dec 2016 07:56:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAOMZO5C5WHW+a4F5gTV2T5xw3pMjrvkr4JsfS7rxU7d2=-tbKA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 08, 2016 at 08:48:49PM -0200, Fabio Estevam wrote:
> On Thu, Dec 8, 2016 at 3:31 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> 
> > -       ret = regmap_write(max9867->regmap, MAX9867_IFC1A, iface1A);
> > -       ret = regmap_write(max9867->regmap, MAX9867_IFC1B, iface1B);
> > +       regmap_write(max9867->regmap, MAX9867_IFC1A, iface1A);
> > +       regmap_write(max9867->regmap, MAX9867_IFC1B, iface1B);
> 
> What about doing like this instead?
> 
> ret = regmap_write(max9867->regmap, MAX9867_IFC1A, iface1A);
> if (ret)
>     return ret;
> 
> ret = regmap_write(max9867->regmap, MAX9867_IFC1B, iface1B);
> if (ret)
>   return ret;

yeah we can, but I didn't want to add/remove anything from this code, so
skipped the return which has same effect as previous code.

Btw should regmap_write() return be strictly checked or not?

Thanks
-- 
~Vinod
