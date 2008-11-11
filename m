From: "Srinivas.Kandagatla" <srinivas.kandagatla@azingo.com>
Subject: Re: amixer error
Date: Tue, 11 Nov 2008 17:12:06 +0530
Message-ID: <1226403726.6171.27.camel@kandagatla-laptop>
References: <dfeb90390811110225m8e77523pd9cccccbae7ea1ec@mail.gmail.com>
Reply-To: srinivas.kandagatla@azingo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iceblock01.celunite.com (iceblock01.celunite.com [66.220.2.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 309DE1037F0
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 12:44:22 +0100 (CET)
In-Reply-To: <dfeb90390811110225m8e77523pd9cccccbae7ea1ec@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <getarunks@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

BTW: What are you trying to do?

To get out of that error, edit the alsa.conf and overwrite the default
using ctl.!default option.

some thing like
ctl.!default{
type hw
card 0
}

Rgrds
srinivas.kandagatla

On Tue, 2008-11-11 at 15:55 +0530, Arun KS wrote:
> Hi,
> 
> I am getting an error for amixer, but my amixer controls works fine.
> 
> Here is the log:
> 
> [root@OMAP2530EVM ~]#
> [root@OMAP2530EVM ~]#
> [root@OMAP2530EVM ~]#
> [root@OMAP2530EVM ~]# amixer
> amixer: Mixer default load error: Operation not permitted
> [root@OMAP2530EVM ~]#
> [root@OMAP2530EVM ~]#
> [root@OMAP2530EVM ~]#
> [root@OMAP2530EVM ~]# amixer controls
> numid=2,iface=MIXER,name='PCM Playback Volume'
> numid=22,iface=MIXER,name='Line Input Function'
> numid=20,iface=MIXER,name='Line Out Function'
> numid=9,iface=MIXER,name='Mic Bias Level'
> numid=23,iface=MIXER,name='Mic Function'
> numid=5,iface=MIXER,name='HP DAC Playback Switch'
> numid=3,iface=MIXER,name='HP Driver Gain'
> numid=1,iface=MIXER,name='ICE1724 EEPROM'
> numid=21,iface=MIXER,name='Jack Function'
> numid=6,iface=MIXER,name='LO DAC Playback Switch'
> numid=4,iface=MIXER,name='LO Driver Gain'
> numid=18,iface=MIXER,name='Left DAC_L Mixer HP Switch'
> numid=19,iface=MIXER,name='Left DAC_L Mixer LO Switch'
> numid=13,iface=MIXER,name='Left PGA Mixer Line1L Switch'
> numid=14,iface=MIXER,name='Left PGA Mixer Line2L Switch'
> numid=15,iface=MIXER,name='Left PGA Mixer Line3L Switch'
> numid=7,iface=MIXER,name='PGA Capture Volume'
> numid=8,iface=MIXER,name='Program Registers'
> numid=16,iface=MIXER,name='Right DAC_R Mixer HP Switch'
> numid=17,iface=MIXER,name='Right DAC_R Mixer LO Switch'
> numid=10,iface=MIXER,name='Right PGA Mixer Line1R Switch'
> numid=11,iface=MIXER,name='Right PGA Mixer Line2R Switch'
> numid=12,iface=MIXER,name='Right PGA Mixer Line3R Switch'
> [root@OMAP2530EVM ~]#
> 
> 
> Can somebody tell me what all can be the reasons for this?
> Should I need to enable some option in the kernel?
> 
> Regards,
> Arun
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
