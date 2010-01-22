From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: fix a memory-leak in wm8903
Date: Fri, 22 Jan 2010 17:39:33 +0000
Message-ID: <1264181973.3094.160.camel@odin>
References: <Pine.LNX.4.64.1001221756240.4652@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id E69D7243CE
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 18:39:37 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so376996eyw.16
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 09:39:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1001221756240.4652@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-01-22 at 18:00 +0100, Guennadi Liakhovetski wrote:
> Remember to free the temporary register-cache.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
