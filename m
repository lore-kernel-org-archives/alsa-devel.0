From: rajeev <rajeev-dlh.kumar@st.com>
Subject: RFC: ST specific ASoC sound driver
Date: Wed, 16 Mar 2011 16:34:08 +0530
Message-ID: <4D809928.2000905@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C953103873
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 12:06:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@perex.cz>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I have developed a ASoC sound driver for a ST specific platform (SPEAr).
This module actually uses the Designware (Synopsys) "dw_apb_i2s_db" IP
+ some ST specific glue logic on top of it.

Now I am confused as to whether I should submit a single patch for
the SPEAr ASoC driver or should I try to break the driver such that
the Designware and glue logic parts are handled separately (which given
the current shape of design seems improbable)

Any pointers on the same will be highly appreciated.

Best Regards
Rajeev
