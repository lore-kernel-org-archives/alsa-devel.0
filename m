From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 6/8] ASoC: dapm: Implement and instantiate
 DAI widgets
Date: Fri, 17 Feb 2012 10:39:18 +0000
Message-ID: <1329475158.3972.15.camel@odin>
References: <1329458170-22119-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329458170-22119-6-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1329468009.24656.15.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240]) by alsa0.perex.cz (Postfix) with SMTP id CE0EA24551
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 11:39:22 +0100 (CET)
Received: by mail-we0-f176.google.com with SMTP id f1so2524594wer.21
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 02:39:20 -0800 (PST)
In-Reply-To: <1329468009.24656.15.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2012-02-17 at 14:10 +0530, Vinod Koul wrote:

> 
> Also in dai widget would it make sense to add channel map and associate
> that with DAI?
> 

Yeah, I think that would work. I've already started some work on the
channel mapping (just associating unique PCM channel masks with DAI
widgets) but I do need to upstream dynamic PCM first !

Liam
