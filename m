From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 1/2 2.6.38] ASoC: WM8994: Improve
 robustness in some use cases
Date: Sun, 13 Feb 2011 16:18:19 +0000
Message-ID: <1297613899.3436.19.camel@odin>
References: <1297441932-13350-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 037941037EA
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 17:18:22 +0100 (CET)
Received: by wyi11 with SMTP id 11so3924774wyi.38
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2011 08:18:22 -0800 (PST)
In-Reply-To: <1297441932-13350-1-git-send-email-dp@opensource.wolfsonmicro.com>
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

On Fri, 2011-02-11 at 16:32 +0000, Dimitris Papastamos wrote:
> Ensure that on disabling certain registers such as AIF1DAC1L,
> AIF1DAC1R etc. the AIF1CLK and AIF2CLK remain enabled.  Similarly
> when enabling those registers, AIF1CLK and AIF2CLK will remain
> disabled.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
> ---

Both 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
