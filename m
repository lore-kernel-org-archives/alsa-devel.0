From: Patrick Lai <plai@codeaurora.org>
Subject: Multicasting transfer mode
Date: Mon, 14 May 2012 00:00:51 -0700
Message-ID: <4FB0ADA3.3020304@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
	[199.106.114.254])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CEB02451C
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2012 09:00:53 +0200 (CEST)
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

The hardware I am working on has CODEC transfer microphone signal to
two SOCs simultaneously . In the machine driver, I have two dai-links
defined for main SOC and secondary SOC. Both DAI-LINKs include same
CODEC DAI. As long as only one dai-link is being accessed at a time,
thing is fine. However, when two dai-links are accessed at the same
time and one dai-link goes down, soc framework tears down the CODEC DAI
as it does not take account of same CODEC DAI is being used by other
dai-link. I see playback_active and capture_active being defined in
struct snd_soc_dai. I am thinking about using these flags to address
this problem. Is it the right approach? Is there precedence being
addressed with different approach? Also, I am referring to kernel 3.4
rc7. In soc-dai.h, playback_active and capture active are defined as
  unsigned int capture_active:1;          /* stream is in use */
   unsigned int playback_active:1;         /* stream is in use */

However, in soc-pcm.c, playback_active and capture_active are being
incremented and decremented instead of set and clear. If I use these
flags to address my problem, I am going to increase number of bits.

Thanks
Patrick

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
