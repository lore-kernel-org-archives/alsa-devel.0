From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: pcm: Improve error logging
Date: Thu, 02 Feb 2012 13:57:55 +0000
Message-ID: <1328191075.3974.6.camel@odin>
References: <1328131855-22916-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id 659B9103C5D
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 14:58:01 +0100 (CET)
Received: by mail-we0-f171.google.com with SMTP id b14so4692207wer.30
	for <alsa-devel@alsa-project.org>; Thu, 02 Feb 2012 05:57:58 -0800 (PST)
In-Reply-To: <1328131855-22916-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2012-02-01 at 21:30 +0000, Mark Brown wrote:
> Use the standard logging macros and use dev_ variants where we can, also
> reporting error codes whenever we report an error. These changes (the
> error codes in particular) make it noticeably easier to figure out what
> went wrong just from the basic dmesg output.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---

Acked-by: Liam Girdwood <lrg@ti.com>
