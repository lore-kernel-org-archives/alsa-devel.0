From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Changing default card using its name
Date: Sun, 21 Nov 2010 22:10:08 +0100
Message-ID: <4CE98AB0.4030601@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id ED4F92438C
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 22:10:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id A382CA1A40B0F
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 22:10:21 +0100 (CET)
Received: from cable.insite.cz ([127.0.0.1])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LOpLoEGBho6R for <alsa-devel@alsa-project.org>;
	Sun, 21 Nov 2010 22:10:17 +0100 (CET)
Received: from [192.168.105.102] (ip28.insite.cz [81.0.237.28])
	by cable.insite.cz (Postfix) with ESMTPSA id 1A49EA1A40B18
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2010 22:10:17 +0100 (CET)
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

Hi,

Please excuse my ignorance but I have not been able to figure out this 
simple task. Nowadays most PCs have multiple soundcards (onboard plus 
HDMI, often another PCI card). Order of the cards is not stable. How do 
I define in /etc/asound.conf another default card using its name and 
keep the PCMs defined by its corresponding alsa card/pcm config files?

In my case aplay -L:
null
     Discard all samples (playback) or generate zero samples (capture)
front:CARD=Intel,DEV=0
     HDA Intel, STAC92xx Analog
     Front speakers
surround40:CARD=Intel,DEV=0
     HDA Intel, STAC92xx Analog
     4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
     HDA Intel, STAC92xx Analog
     4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
     HDA Intel, STAC92xx Analog
     5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
     HDA Intel, STAC92xx Analog
     5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
     HDA Intel, STAC92xx Analog
     7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
hdmi:CARD=NVidia
     HDA NVidia, NVIDIA HDMI
     HDMI Audio Output
front:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI DAC/ADC
     Front speakers
rear:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI 2nd DAC
     Rear speakers
surround40:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI 2nd DAC
     4.0 Surround output to Front and Rear speakers
surround41:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI 2nd DAC
     4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI 2nd DAC
     5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI 2nd DAC
     5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI 2nd DAC
     7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=CMI8768,DEV=0
     C-Media CMI8768, C-Media PCI DAC/ADC
     IEC958 (S/PDIF) Digital Audio Output

Is it actually possible to have iec958:CARD=CMI8768,DEV=0 as the 
system-wide device iec958? I have not been successful with

defaults.ctl.card "CMI8768"

which IMO would have been the simplest solution.

Thanks a lot for help.

Regards,


Pavel Hofman.
