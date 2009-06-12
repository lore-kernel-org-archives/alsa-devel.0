From: "Steve Langstaff" <steve.langstaff@pebblebay.com>
Subject: Re: plug:dmix slows playback
Date: Fri, 12 Jun 2009 12:03:42 +0100
Message-ID: <42267.2293767848$1244804634@news.gmane.org>
References: <000001c9eb46$24a60d30$6df22790$@langstaff@pebblebay.com>	<alpine.LNX.2.00.0906121213520.13028@eeebox2.perex-int.cz>	<000101c9eb48$8e0a9280$aa1fb780$@langstaff@pebblebay.com>	<alpine.LNX.2.00.0906121229350.13028@eeebox2.perex-int.cz>	<000501c9eb49$d2458080$76d08180$@langstaff@pebblebay.com>
	<alpine.LNX.2.00.0906121240510.13028@eeebox2.perex-int.cz>
Reply-To: steve.langstaff@pebblebay.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ares.krystal.co.uk (ares.krystal.co.uk [77.72.0.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 43485246A5
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Jun 2009 13:03:46 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.0906121240510.13028@eeebox2.perex-int.cz>
Content-Language: en-gb
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Jaroslav Kysela' <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Jaroslav Kysela
> On Fri, 12 Jun 2009, Steve Langstaff wrote:
> 
> >> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> >> bounces@alsa-project.org] On Behalf Of Jaroslav Kysela
> >
> >> On Fri, 12 Jun 2009, Steve Langstaff wrote:
> >
> >>> Slave: Hardware PCM card 0 'LM4549' device 0 subdevice 0
> >>
> >>>  msbits       : 16
> >>
> >> If I remember correctly, this value was 32 in your dmix setup.
> >> Could you try command:
> >>
> >>  	aplay -D"plug:'dmix:FORMAT=S16_LE'" <filename>
> >
> > Yes, that works fine - is there something wrong with my configuration
> do you
> > think?
> 
> It seems that 32-bit samples are not handled correctly in driver.
> What's your hardware? Output from alsa-info.sh script might be helpful
> for
> identification.

I don't have alsa-info.sh installed, but here is the hardware info that I
can glean...

~ # aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: LM4549 [LM4549], device 0: PXA2xx-PCM []
  Subdevices: 1/1
  Subdevice #0: subdevice #0

~ # lsmod |fgrep snd
snd_page_alloc          6684  1 snd_pcm
soundcore               6844  1 snd
snd                    51952  4
snd_pxa2xx_ac97,snd_ac97_codec,snd_pcm,snd_timer
snd_timer              21340  1 snd_pcm
snd_pcm                73449  4
snd_pxa2xx_ac97,snd_ac97_codec,snd_pxa2xx_pcm,snd_pxa2xx_lib
snd_pxa2xx_lib         10748  2 snd_pxa2xx_ac97,snd_pxa2xx_pcm
snd_pxa2xx_pcm          2536  1 snd_pxa2xx_ac97
ac97_bus                1716  1 snd_ac97_codec
snd_ac97_codec        105828  1 snd_pxa2xx_ac97
snd_pxa2xx_ac97         4236  0
