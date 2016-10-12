From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: Jack sensing in snd_usb_audio ?
Date: Wed, 12 Oct 2016 19:36:22 +0900
Message-ID: <9449bd71-7766-5323-9fe8-30e954ca8f45@sakamocchi.jp>
References: <1476249011.6699.15.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 23C83266AB5
 for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2016 12:36:27 +0200 (CEST)
In-Reply-To: <1476249011.6699.15.camel@hadess.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bastien Nocera <hadess@hadess.net>, alsa-devel@alsa-project.org, linux-usb@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Oct 12 2016 14:10, Bastien Nocera wrote:
> My questions are:
> - does the USB audio driver support jack sensing?
> - is this something standard that's just not implemented yet? In which
> case, I'd be up for at least trying, given specs.
> - or is it something that depends on the device, and in which case, how
> would I find out?

In ALSA usb-related codes, there's no functions calls for snd_jack_*(),
thus none of ALSA drivers for USB support Jack sense feature of ALSA
control interface.

The requirement of Jack sense feature is whether hardwares support it.
For example, some hardware codecs such as HDA codecs generates signals
when plugs are insert to jacks connected to the codecs. Corresponding
ALSA drivers catch the signals, then tell it to user land.

If your hardware performs like it, you have a probability to add support
for jack sense feature to ALSA drivers for USB. But I don't know exactly
that USB related specifications such as USB Audio Device Class
1.0/2.0/3.0 supports the feature.


Regards

Takashi Sakamoto
