From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Not able to restart audio after hibernation
Date: Fri, 6 Jan 2012 16:17:50 +0530
Message-ID: <4F06D156.1020208@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog120.obsmtp.com (eu1sys200aog120.obsmtp.com
	[207.126.144.149])
	by alsa0.perex.cz (Postfix) with ESMTP id B770A24398
	for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2012 11:48:13 +0100 (CET)
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, tiwai@suse.de, "spear--sw-devel@lists.codex.cro.st.com" <spear--sw-devel@lists.codex.cro.st.com>, Armando VISCONTI <armando.visconti@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hello Mark,

I am testing my audio driver on spear platform with the linux kernel 
2.6.37. During testing I put my system in hibernation mode and found 
that there is no sound after resume. The steps I am using for 
hibernation are
1. Have audio player on, select some audio, (using aplay utils)
2. Hibernate machine
3. Resume from hibernate

After resume it seems that there is no data available in the buffer to 
play, as application is giving pcm_write error and  exit.

While going through the suspend/resume implementation in the alsa 
framework, get to know that feature to support hibernation is missing.
The suspend/resume implementation for audio is with dev_pm_ops which is 
present in snd-core.c . If we look into the structure, we have only 
suspend, resume and poweroff feature present in it. To support 
hibernation we need freeze,thaw and restore also.
Please correct me if I am wrong?

Just for experiment I modified the structure and added freeze, thaw and 
restore functionality, but the result is same. The new modified 
structure looks like

static const struct dev_pm_ops soc_pm_ops = {
	.suspend = soc_suspend,
	.resume = soc_resume,
	
	.freeze = soc_suspend,
	.thaw = soc_resume,
	.restore = soc_resume,

	.poweroff = soc_poweroff,
}

Just for info audio is working fine in case of suspend-to-ram.

Best Regards
~Rajeev
