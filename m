From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Drop unused state parameter from
 CODEC suspend callback
Date: Fri, 02 Dec 2011 09:27:31 +0000
Message-ID: <1322818051.7185.0.camel@odin>
References: <1322817508-23150-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 057E6103C7A
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 10:27:39 +0100 (CET)
Received: by mail-lpp01m010-f41.google.com with SMTP id i5so1367474lah.0
	for <alsa-devel@alsa-project.org>; Fri, 02 Dec 2011 01:27:37 -0800 (PST)
In-Reply-To: <1322817508-23150-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-12-02 at 10:18 +0100, Lars-Peter Clausen wrote:
> The existence of this parameter is purely historical. None of the CODEC drivers
> uses it and we always pass in the same value anyway, so it should be safe to
> remove it.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Fine by me.

Acked-by: Liam Girdwood <lrg@ti.com>
