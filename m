From: Sergej Sawazki <ssawazki@gmx.de>
Subject: ASoC: How to connect a single CPU DAI to two codecs?
Date: Sat, 27 Sep 2014 15:33:44 +0200
Message-ID: <5426BCB8.6030002@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D4CD26045D
 for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2014 15:33:46 +0200 (CEST)
Received: from [192.168.178.42] ([92.204.101.155]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MVJze-1Xlcyl2leY-00YgJN for
 <alsa-devel@alsa-project.org>; Sat, 27 Sep 2014 15:33:45 +0200
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I'm writing an ALSA SoC machine driver for a board that has two mono 
codecs (left and right audio channel). Each codec is controlled over I2C 
and has itsown address.Both codecs are connected to the same I2S CPU DAI 
(as shown below).

     +--------- (adr: 0x1a) -----+
     |                           |
     |             +--------> codec_1 ----> (left channel audio)
     |             |
    I2C    I2S ----+
     |             |
     |             +--------> codec_2 ----> (right channel audio)
     |                           |
     +--------- (adr: 0x1b) -----+

Can someone give me some advice on how to setup the 'snd_soc_card' and 'snd_soc_dai_link' in this case? Do I need two dai_links with the same 'cpu_dai_name' and 'platform_name'?

Are there examples for such a configuration? I didn't had much luck in finding one in the mainline?

Any help would be highly appreciated.  Thanks!

Sergej
