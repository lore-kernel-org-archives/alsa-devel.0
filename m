From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: dapm: Fix _PRE and _POST events for
 DAPM performance improvements
Date: Mon, 23 Jul 2012 08:59:43 +0100
Message-ID: <1343030383.4873.0.camel@odin>
References: <1342801940-11549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
 [74.125.149.244])
 by alsa0.perex.cz (Postfix) with ESMTP id DE06F265212
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 10:00:18 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so2108342wib.14
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2012 00:59:45 -0700 (PDT)
In-Reply-To: <1342801940-11549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-07-20 at 17:32 +0100, Mark Brown wrote:
> Ever since the DAPM performance improvements we've been marking all widgets
> as not dirty after each DAPM run. Since _PRE and _POST events aren't part
> of the DAPM graph this has rendered them non-functional, they will never be
> marked dirty again and thus will never be run again.
> 
> Fix this by skipping them when marking widgets as not dirty.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
