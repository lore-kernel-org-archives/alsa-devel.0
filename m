From: Jerry Geis <geisj@pagestation.com>
Subject: Re: Gigabyte ALC889A Function ID: 0x01
Date: Wed, 15 Apr 2009 10:13:52 -0400
Message-ID: <49E5EBA0.5040407@pagestation.com>
References: <49E5E881.5020507@pagestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from unifiedpaging.messagenetsystems.com
	(www.emergencycommunicationsystems.com [24.123.23.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 18AA11038F3
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 16:13:51 +0200 (CEST)
Received: from devcentos5x64.msgnet.com (devcentos5x64 [192.168.1.8])
	by unifiedpaging.messagenetsystems.com (8.13.1/8.13.1) with ESMTP id
	n3FEDobV009478
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 10:13:50 -0400
In-Reply-To: <49E5E881.5020507@pagestation.com>
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

Another thing I noticed is that aplay -l reports two different things. 
both using 1.0.19.

On the motherboard that works:
alsamixer reports ALC889A
aplay -l reports:
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC883 Analog [ALC883 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: ALC883 Digital [ALC883 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI]
  Subdevices: 0/1
  Subdevice #0: subdevice #0


on the motherboard that does NOT work:
alsamixer reports ALC889A
aplay -l reports:
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC885 Analog [ALC885 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: ALC885 Digital [ALC885 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 3: ATI HDMI [ATI HDMI]
  Subdevices: 0/1
  Subdevice #0: subdevice #0


The lspci reports the same for both motherboards:
1002:960f

HOW - is the motherboard that is not working getting ALC885??? Why is 
not getting ALC883?
as the ALC883 works on the other motherboard?


Jerry
