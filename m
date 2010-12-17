From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: soc-dapm: Introduce the new
 snd_soc_dapm_virt_mux type
Date: Fri, 17 Dec 2010 10:43:13 +0000
Message-ID: <1292582593.3286.4.camel@odin>
References: <1292514819-4254-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C1FF103830
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 11:43:16 +0100 (CET)
Received: by wyi11 with SMTP id 11so458421wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 02:43:16 -0800 (PST)
In-Reply-To: <1292514819-4254-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-12-16 at 15:53 +0000, Dimitris Papastamos wrote:
> This new type is a virtual version of snd_soc_dapm_mux.  It is used
> when a backing register value is not necessary for deciding which
> input path to connect.  A simple virtual enumeration control e.g.
> SOC_DAPM_ENUM_VIRT() can be exposed to userspace which will be used
> to choose which path to connect.
> 
> The snd_soc_dapm_virt_mux type ensures that during the initial
> path setup, the first (which is also the default) input path will
> be connected.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
