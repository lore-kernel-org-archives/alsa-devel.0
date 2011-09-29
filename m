From: Hou-xiang ZHU <hou-xiang.zhu@st.com>
Subject: alsa_aplay doesn't work on android on hdk7108
Date: Thu, 29 Sep 2011 19:17:02 +0800
Message-ID: <4E8453AE.7040201@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog108.obsmtp.com (eu1sys200aog108.obsmtp.com
	[207.126.144.125])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AC16244CD
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Sep 2011 13:17:06 +0200 (CEST)
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4C21E95
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 11:08:34 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas4.st.com [10.80.176.69])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A9F71F7F
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2011 11:17:02 +0000 (GMT)
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
List-Id: alsa-devel@alsa-project.org

Hello,

I am trying to add alsa feature to Android on hdk7108 (which is sh4 
architecture, not arm).

Basically on non android linux platform ,i.e STLinux-2.4, the driver and 
alsa-libs and alsa-utils works with the following test command:
---------------------------
#aplay -v -t raw -D hw:1,0 -c 2 -r 32000 -f S16_BE /32K_16Bit_Stereo.pcm"
---------------------------

But when working on Android platform, because the alsa-lib/alsa-utils 
are different from STLinux-2.4, so we ask someone  the two packages from 
a arm platform. and compilation ok.
but during run alsa_aplay, the following error occurred:

-----------------------------------
#/system/bin/alsa_aplay -v -t raw -D hw:1,0 -c 2 -r 32000 -f S16_BE 
/32K_16Bit_Stereo.pcm

ALSA lib 
vendor/STMicroelectronics/hdk7108/alsa/alsa-lib/src/confmisc.c:137:(snd_config_get_bool) 
confmisc.c in func snd_config_get_bool line 137 Invalid type for nonblock

ALSA lib 
vendor/STMicroelectronics/hdk7108/alsa/alsa-lib/src/pcm/pcm_hw.c:1417:(_snd_pcm_hw_open) 
Invalid type for subdevice
aplay: main:656: in aplay.c func main line 656 audio open error: Invalid 
argument
aplay/main.c in func main line 452
alsa-lib/src/pcm/pcm.c func snd_pcm_open line 2242 after call 
snd_config_update(), err=1
----------------------------------

looks like alsa configuration issue. I noticed that on STLinux-2.4 
platform, the alsa-libs is 1.0.21a and on android platform, it is 
1.0.16, can this be a issue?

or configuration file wrong or else? how to debug this?

Thanks you very much!
Houxiang
