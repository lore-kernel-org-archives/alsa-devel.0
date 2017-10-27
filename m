From: Bard Liao <bardliao@realtek.com>
Subject: Re: Cherry Trail + RT5645 devices with a mono speaker ?
Date: Fri, 27 Oct 2017 06:39:35 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D7026F4A1F@RTITMBSV02.realtek.com.tw>
References: <f5ad13fc-2b25-7f64-d5f0-6ad035fd09ab@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D7026E85AB@RTITMBSV02.realtek.com.tw>
 <c5eb261c-4a02-d793-aeab-abc845579343@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FB9226749F
 for <alsa-devel@alsa-project.org>; Fri, 27 Oct 2017 08:39:41 +0200 (CEST)
In-Reply-To: <c5eb261c-4a02-d793-aeab-abc845579343@redhat.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Albert Chen <albertchen@realtek.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Hans de Goede [mailto:hdegoede@redhat.com]
> Sent: Thursday, October 26, 2017 11:09 PM
> To: Bard Liao; Pierre-Louis Bossart
> Cc: alsa-devel@alsa-project.org
> Subject: Re: Cherry Trail + RT5645 devices with a mono speaker ?
> 
> Hi,
> 
> On 16-10-17 13:31, Bard Liao wrote:
> >> -----Original Message-----
> >> From: Hans de Goede [mailto:hdegoede@redhat.com]
> >> Sent: Sunday, October 15, 2017 2:12 AM
> >> To: Pierre-Louis Bossart; Bard Liao
> >> Cc: alsa-devel@alsa-project.org
> >> Subject: Cherry Trail + RT5645 devices with a mono speaker ?
> >>
> >> Hi Pierre-Louis, Bard,
> >>
> >> I've been looking into getting some Cherry Trail + RT5645
> >> devices with a mono speaker I have to work properly.
> >>
> >> Specifically the goal is to mix the right channel into
> >> the left output, so that sounds which are only played
> >> over the right channel do not get lost.
> >>
> >> I'm using this UCM file:
> >> https://github.com/plbossart/UCM/blob/master/byt-rt5640/HiFi
> >>
> >> Looking at the rtl5640 UCM file, getting the mono speaker
> >> to work (in a first simple attempt) should be as simple
> >> as replacing:
> >>
> >>                   cset "name='SPOR MIX SPKVOL R Switch' on"
> >>
> >> With
> >>
> >>                   cset "name='SPOL MIX SPKVOL R Switch' on"
> >>
> >> But this does not work, the speaker test sound for the
> >> right speaker is still silent (works with headphones).
> >>
> >> I've also looked into directly poking the
> >> RT5645_SPO_MIXER i2c register for testing, but when
> >> checking its value with the original unmodified UCM
> >> file:
> >>
> >> [root@localhost ~]# i2cget -y -f 1 0x1a 0x48  w
> >> 0x06c8
> >>
> >> That is: 0xc806 as the output of i2cget "w" mode
> >> needs byteswapping. Note that both the
> >> RT5645_M_SV_L_SPM_L and RT5645_M_SV_R_SPM_L bits
> >> are already cleared, which is weird as this is
> >> before I've modified anything. Also the
> >> RT5645_M_SV_R_SPM_R bit is cleared, but that is
> >> expected.
> >>
> >> Even if I manually set reg 0x48 to 0x07c8 which AFAIK
> >> should enable output of both left and right channels
> >> on the left speaker I still only get sounds played
> >> on the left channel.
> >>
> >> Any insights / help with this would be very much
> >> welcome.
> >
> > Could you dump all registers for us?
> 
> Here you go:
> 
>       0,8  1,9  2,a  3,b  4,c  5,d  6,e  7,f
> 00: 0000 0808 c8c8 c8c8 0ac8 0000 0000 0000
> 08: 0000 0000 0200 2738 00e0 0000 0000 0000
> 10: 0000 0000 0000 0000 3333 0000 004b 0000
> 18: 8b01 afaf afaf 1100 3f3f 7f7f 00f0 0000
> 20: 00a0 0000 0000 0000 0000 0000 0000 2038
> 28: 3030 8080 1616 4444 a0aa 0000 0000 0210
> 30: 0000 0050 0000 0000 0000 0000 0000 0000
> 38: 0000 0000 0000 0000 7d00 0000 7d00 0000
> 40: 1c00 0000 1c00 0000 0000 0050 3800 3800
> 48: 06c8 0000 0400 0000 1f03 0000 0000 ff01
> 50: 0000 0000 ff01 00f0 0000 0000 1101 6400
> 58: 0eef f0f0 0eef f0f0 0eef f0f0 00f0 0000
> 60: 0000 019b 0008 1ae8 0402 0230 00c0 0000
> 68: 0000 0000 0000 0000 aa0a 0000 0000 0000
> 70: 8380 0080 0080 7017 003e 0924 0a00 0058
> 78: 0000 2301 0080 0000 0000 0000 0000 0000
> 80: 0040 030f 0030 000c 1111 0000 0800 0000
> 88: 0000 0000 2001 0000 0300 0000 0000 4011
> 90: 3606 060c 0000 0801 0202 0000 0000 0000
> 98: 0000 0000 8421 0a01 ea0a 0c00 0004 0000
> a0: e8a0 5900 0100 0000 0000 0000 0000 0000
> a8: 0000 0000 0000 0000 0000 0000 0060 0000
> b0: 0060 0000 0000 1f00 0c02 001f 0000 0040
> b8: 0000 0000 0000 0000 0000 8002 0000 8011
> c0: 0080 0000 0000 0020 0000 0000 0000 0000
> c8: 0000 0000 0000 0000 0000 0000 0000 1418
> d0: 9006 171c 0000 20b3 0000 0000 0004 0000
> d8: 0000 0908 0000 0300 4900 1b00 0000 0000
> e0: 0000 0000 0000 0000 0000 0000 0080 0007
> e8: 0080 0007 200f 0000 00b3 0000 0000 0000
> f0: 1f00 0c02 001f 0000 0040 0000 0000 0000
> f8: 0000 0000 6120 4040 001a 0400 ec10 0863
> 
> Note that i2cdump swaps the low and high bytes
> in all the 16 bit words.

Could you dump registers by regmap?
cat /sys/kernel/debug/regmap/<bus name>/registers
It will be more readable for me.
Also, could you do a loopback test?
Open capture and playback simultaneously, then
set 0x78 register bit 12 = 1.
It will record what codec received. It is to make sure
there is no problem on Intel side.

> 
> Regards,
> 
> Hans
> 
> ------Please consider the environment before printing this e-mail.
