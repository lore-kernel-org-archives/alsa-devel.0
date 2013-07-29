From: Bard Liao <bardliao@realtek.com>
Subject: Re: Broken headphone and speaker amplifier
	suppliesforthe rt5640 driver
Date: Mon, 29 Jul 2013 11:04:46 +0800
Message-ID: <1121E117AD4ECE49880A389A396215BB935C48A592@rtitmbs7.realtek.com.tw>
References: <51F29064.8080003@metafoo.de> <20130727173509.GJ9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 79379261A0B
 for <alsa-devel@alsa-project.org>; Mon, 29 Jul 2013 05:04:53 +0200 (CEST)
In-Reply-To: <20130727173509.GJ9858@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Mark Brown [mailto:broonie@kernel.org]
> Sent: Sunday, July 28, 2013 1:35 AM
> To: Lars-Peter Clausen
> Cc: Stephen Warren; Bard Liao; Linux-ALSA
> Subject: Re: [alsa-devel] Broken headphone and speaker amplifier supplies
> forthe rt5640 driver
> 
> On Fri, Jul 26, 2013 at 05:06:12PM +0200, Lars-Peter Clausen wrote:
> 
> > I guess for the heaphone amplifier the right fix is to set the shift
> > to RT5640_PWR_HA_BIT. For the speaker amplifier I'd assume that the
> > right bit is RT5640_PWR_CLS_D_BIT. But the speaker amplifier widget
> > also as an event callback in which it already seems to set/clear the
> > bit. I think the right fix is to remove the register change from the
> > event callback and set the shift to RT5640_PWR_CLS_D_BIT. But I
> > neither have the hardware nor the datasheet, so this is all just an educated
> guess.
> 
> Or set the register to SND_SOC_NOPM allowing the manual sequencing which
> is (I presume) needed?  If we're going to need an event to do the sequencing
> we may as well have it do both writes.

We do need a sequence for headphone depop.
Another question about it.
Can I do mute/unmute in the widget event?
The mute/unmute control is written in rt5640_snd_controls[] now.
It allows user to unmute speaker or headphone before dapm power on the related power.
And it will bring a pop noise.
So I prefer to do the unmute/mute step in the widget event.
Is that ok?

> 
> ------Please consider the environment before printing this e-mail.
