From: Rick Mann <rmann@latencyzero.com>
Subject: CircuitCo AudioCape and 4.4.6-bone-rt-r7 kernel,
	not quite there
Date: Wed, 6 Apr 2016 15:52:13 -0700
Message-ID: <5A691E07-AB96-44FC-93C1-CB3640927118@latencyzero.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id D4E6626506E
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 00:52:14 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 175D4219CF
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 18:52:14 -0400 (EDT)
Received: from [10.2.28.137] (unknown [12.97.18.26])
 by mail.messagingengine.com (Postfix) with ESMTPA id AE9E568014F
 for <alsa-devel@alsa-project.org>; Wed,  6 Apr 2016 18:52:13 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm thinking my problems are more ALSA-related than Beaglebone-specific. I wonder if anyone can help. With kernel 4.4.6-bone-rt-r7, and the CircuitCo AudioCape, I get a sound card in the system, but speaker-test reports errors (Unable to set hw params for playback: Invalid argument). I may have issues in various ALSA config settings; I'm hoping someone here can help me by showing me what to look at and change.

The CODEC is a tlv320aic3104. 

Thanks!

-----------
# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: B [AudioCape Rev B], device 0: davinci-mcasp.0-tlv320aic3x-hifi tlv320aic3x-hifi-0 []
  Subdevices: 1/1
  Subdevice #0: subdevice #0


-----------
# speaker-test 

speaker-test 1.0.28

Playback device is default
Stream parameters are 48000Hz, S16_LE, 1 channels
Using 16 octaves of pink noise
Rate set to 48000Hz (requested 48000Hz)
Buffer size range from 16 to 32768
Period size range from 8 to 16384
Using max buffer size 32768
Periods = 4
Unable to set hw params for playback: Invalid argument
Setting of hwparams failed: Invalid argument

-----
More info:

My DTB: http://pastebin.com/Wja7ZQRk
and DTBO: https://github.com/RobertCNelson/bb.org-overlays/blob/master/src/arm/BB-BONE-AUDI-02-00A0.dts

Results of speaker-test, aplay, etc.:

http://pastebin.com/mMPbReAV

One possibility, ALSA is still not configured correctly for this cape, but I wonder if anyone has the right configuration for it?

Thanks!

-- 
Rick Mann
rmann@latencyzero.com
