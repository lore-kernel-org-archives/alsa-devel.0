From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Exporting playback and capture capability to user space
Date: Thu, 17 Nov 2011 19:05:46 +0530
Message-ID: <4EC50DB2.6090009@st.com>
References: <4E65E934.2070706@st.com>
	<20110906180138.GC2924@opensource.wolfsonmicro.com>
	<4E66EFC3.2070706@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog119.obsmtp.com (eu1sys200aog119.obsmtp.com
	[207.126.144.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 6EF08103822
	for <alsa-devel@alsa-project.org>; Thu, 17 Nov 2011 14:36:10 +0100 (CET)
In-Reply-To: <4E66EFC3.2070706@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark

I have a single codec with playback and capture capability. We are using 
it for different i2s controller. Below are the details for that.

case 1: I2S controller-1: with playback and capture capability
case 2: I2S controller-2: with playback capability only
case 3: I2S controller-3: with capture capability only.

We are registering all the I2S controller with there respective  capability.

In command 'aplay -l' or 'cat /proc/asound/pcm', among playback devices, 
capture device is also listed.  This is true in case-1 but for case-2 
and case-3 also it is showing the same behavior. According to my 
understanding it should not show the list of all devices i.e. in case of 
controller having playback capability it should show only playback 
devices not capture devices and vice versa. Please correct me if I am wrong.

So  my questions are
1. How to separate playback and capture devices in case-2 and case-3. 
Are we need to register different codec for different i2s controller?

2. Is it codec capability only which is exported to user space ?


Best Regards
Rajeev
