From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Allow DAPM pin operations to match
	any context
Date: Fri, 08 Apr 2011 18:13:40 +0100
Message-ID: <1302282820.3315.96.camel@odin>
References: <1302057533-2295-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id ED9631037F5
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 19:13:44 +0200 (CEST)
Received: by wwi18 with SMTP id 18so751439wwi.2
	for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2011 10:13:44 -0700 (PDT)
In-Reply-To: <1302057533-2295-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-04-06 at 11:38 +0900, Mark Brown wrote:
> The DAPM pin operations currently require that the specific DAPM context
> that the pin being operated in is contained in be specified. With multi
> component and especially with the addition of a per-card DAPM context
> this isn't ideal as it means that things like disabling unused pins on
> CODECs require looking up the CODEC DAPM context.
> 
> Fix this by falling back to matching a widget in any context if there isn't
> a match in the current context. The code isn't ideal currently but will do
> the job.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
