From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: ASoC: UDA1380/I2S/SSP patches
Date: Tue,  3 Feb 2009 17:19:39 +0100
Message-ID: <1233677983-23710-1-git-send-email-philipp.zabel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CE3E10384F
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 17:19:48 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 13so971049fge.44
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 08:19:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org


Right now the snd-soc-magician driver in ASoC dev is severely bitrotted.
I can make it compile and load again, but until now it only outputs silence
(or pops and hisses as I fiddle with the uda1380 registers).
For now, I'd like feedback on these patches in preparation for the magician
update and switch from pxa2xx-ssp to pxa-ssp.

regards
Philipp
