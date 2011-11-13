From: Patrick Lai <plai@codeaurora.org>
Subject: Run-time CODEC reset
Date: Sat, 12 Nov 2011 22:15:29 -0800
Message-ID: <4EBF6081.8030907@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine02.qualcomm.com (wolverine02.qualcomm.com
	[199.106.114.251])
	by alsa0.perex.cz (Postfix) with ESMTP id BD68C2472E
	for <alsa-devel@alsa-project.org>; Sun, 13 Nov 2011 07:15:35 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I have a use case which requires CODEC to be reset at run-time. As
application exercises playback/capture through PCM device and mixer, my
understanding is that there is no interface for application to reset
CODEC through ALSA ASoC framework. CODEC driver would have to build
non-standard interface for this purpose. Is there precedence in any of
asoc CODEC driver which provides reset interface?

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
