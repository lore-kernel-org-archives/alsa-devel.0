From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Audio:suspend to ram issue
Date: Thu, 18 Aug 2011 11:35:48 +0530
Message-ID: <4E4CABBC.20901@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	by alsa0.perex.cz (Postfix) with ESMTP id 3053924506
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 08:07:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


Hi Mark
I am not sure about the behavior in case of audio suspend/resume.

I tested the audio driver with aplay and then suspended to ram (using 
echo mem > /sys/power/state). After pressing wake to resume,
the audio does not play unless aplay is closed and re-run.  Do we expect 
the audio suspend/resume to work?

In the platform trigger part I am doing nothing and in case of cpu(i2s) 
, just disabling the i2s.

Best Regards
Rajeev
