From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: jack: Always update jack state even
 for noop changes
Date: Thu, 26 Jul 2012 00:08:12 +0100
Message-ID: <1343257692.16982.10.camel@odin>
References: <1343253571-21610-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog123.obsmtp.com (na3sys009aog123.obsmtp.com
 [74.125.149.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 6540A265B4A
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2012 01:08:16 +0200 (CEST)
Received: by weyx10 with SMTP id x10so943673wey.24
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2012 16:08:14 -0700 (PDT)
In-Reply-To: <1343253571-21610-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-07-25 at 22:59 +0100, Mark Brown wrote:
> Now that DAPM is very cheap for most updates we've no need to avoid trying
> to run it so always notify even if we don't think there are any changes.
> This avoids potential issues with bootstrapping state like the pin state
> or other notifiers when there's nothing in the jack.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
