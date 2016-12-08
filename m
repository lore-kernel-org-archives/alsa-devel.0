From: Fabio Estevam <festevam@gmail.com>
Subject: Re:
	=?utf-8?q?=5BPATCH_09/14=5D_ASoC=3A_max9867=3A_remov?=
	=?utf-8?b?ZSB1bnVzZWQg4oCYcmV04oCZ?=
Date: Thu, 8 Dec 2016 20:48:49 -0200
Message-ID: <CAOMZO5C5WHW+a4F5gTV2T5xw3pMjrvkr4JsfS7rxU7d2=-tbKA@mail.gmail.com>
References: <1481218297-17568-1-git-send-email-vinod.koul@intel.com>
 <1481218297-17568-10-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f65.google.com (mail-oi0-f65.google.com
 [209.85.218.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D46142675B4
 for <alsa-devel@alsa-project.org>; Thu,  8 Dec 2016 23:48:50 +0100 (CET)
Received: by mail-oi0-f65.google.com with SMTP id f201so102206oib.0
 for <alsa-devel@alsa-project.org>; Thu, 08 Dec 2016 14:48:50 -0800 (PST)
In-Reply-To: <1481218297-17568-10-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 8, 2016 at 3:31 PM, Vinod Koul <vinod.koul@intel.com> wrote:

> -       ret = regmap_write(max9867->regmap, MAX9867_IFC1A, iface1A);
> -       ret = regmap_write(max9867->regmap, MAX9867_IFC1B, iface1B);
> +       regmap_write(max9867->regmap, MAX9867_IFC1A, iface1A);
> +       regmap_write(max9867->regmap, MAX9867_IFC1B, iface1B);

What about doing like this instead?

ret = regmap_write(max9867->regmap, MAX9867_IFC1A, iface1A);
if (ret)
    return ret;

ret = regmap_write(max9867->regmap, MAX9867_IFC1B, iface1B);
if (ret)
  return ret;

return 0;
