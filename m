From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: pcm: Staticise non-exported functions
Date: Thu, 10 May 2012 10:29:40 +0100
Message-ID: <1336642180.8605.4.camel@odin>
References: <1336596450-28653-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
	[74.125.149.76])
	by alsa0.perex.cz (Postfix) with ESMTP id E493310BA3C
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 11:29:44 +0200 (CEST)
Received: by wibhr2 with SMTP id hr2so258358wib.1
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2012 02:29:42 -0700 (PDT)
In-Reply-To: <1336596450-28653-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Wed, 2012-05-09 at 21:47 +0100, Mark Brown wrote:
> They pollute the global namespace and cause sparse to complain.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
