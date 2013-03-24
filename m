From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: need help for PCM constraint/rules
Date: Sun, 24 Mar 2013 22:58:46 +0900
Message-ID: <514F0696.1030109@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CF8D265CAD
 for <alsa-devel@alsa-project.org>; Sun, 24 Mar 2013 14:58:54 +0100 (CET)
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

Dear developers,

I'm a newbile for this project and working for kernel land driver for 
Fireworks with ALSA framework.

I need your help for constraint/rule of PCM component.

Related source is:
https://github.com/takaswie/snd-firewire-improve/blob/master/fireworks/fireworks_pcm.c

My device (AudioFirePre8) changes its channels according to sampling 
rate. For example:
32.0  - 48.0kHz  : 16ch: efw->channels_sets[0]
88.2  - 96.0kHz	 : 12ch: efw->channels_sets[1]
176.4 - 192.0kHz : 10ch: efw->channels_sets[2] (but not available)

The other devices such as AudioFire12 has the same number of channels 
(12ch)in each sampling rate.

I managed to write this rule refering to rme9652.c but I cannot achieve 
my purpose. It's my glad to get some help about this.

Regards


Takashi Sakamoto
o-takashi@sakamocchi.jp

========
Fireworks is Echo Audio's series of Firewire Audio interface.
http://echoaudio.com/products/audiofire-pre8

It utilizes IEC 61883-1 and -6 in its implementation and familiar with 
current snd-firewire-lib.ko.

FFADO also produce driver for it. It's a user-land implementation.
http://www.ffado.org/

My aim is writing kernel-land driver for it with ALSA framework.


Takashi Sakamoto
o-takashi@sakamocchi.jp
