From: Hans de Goede <hdegoede@redhat.com>
Subject: Cherry Trail + RT5645 devices with a mono speaker ?
Date: Sat, 14 Oct 2017 20:12:29 +0200
Message-ID: <f5ad13fc-2b25-7f64-d5f0-6ad035fd09ab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 4673B266EAF
 for <alsa-devel@alsa-project.org>; Sat, 14 Oct 2017 20:12:32 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bardliao@realtek.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Pierre-Louis, Bard,

I've been looking into getting some Cherry Trail + RT5645
devices with a mono speaker I have to work properly.

Specifically the goal is to mix the right channel into
the left output, so that sounds which are only played
over the right channel do not get lost.

I'm using this UCM file:
https://github.com/plbossart/UCM/blob/master/byt-rt5640/HiFi

Looking at the rtl5640 UCM file, getting the mono speaker
to work (in a first simple attempt) should be as simple
as replacing:

                 cset "name='SPOR MIX SPKVOL R Switch' on"

With

                 cset "name='SPOL MIX SPKVOL R Switch' on"

But this does not work, the speaker test sound for the
right speaker is still silent (works with headphones).

I've also looked into directly poking the
RT5645_SPO_MIXER i2c register for testing, but when
checking its value with the original unmodified UCM
file:

[root@localhost ~]# i2cget -y -f 1 0x1a 0x48  w
0x06c8

That is: 0xc806 as the output of i2cget "w" mode
needs byteswapping. Note that both the
RT5645_M_SV_L_SPM_L and RT5645_M_SV_R_SPM_L bits
are already cleared, which is weird as this is
before I've modified anything. Also the
RT5645_M_SV_R_SPM_R bit is cleared, but that is
expected.

Even if I manually set reg 0x48 to 0x07c8 which AFAIK
should enable output of both left and right channels
on the left speaker I still only get sounds played
on the left channel.

Any insights / help with this would be very much
welcome.

Regards,

Hans
