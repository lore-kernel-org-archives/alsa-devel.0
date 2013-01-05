From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Sat, 5 Jan 2013 17:46:05 +1030
Message-ID: <20130105071605.GA11323@marvin.atrad.com.au>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
 <20130104042423.GD15726@marvin.atrad.com.au>
 <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
 <20130105031254.GD11016@marvin.atrad.com.au>
 <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 2485F261714
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2013 08:16:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, jwoithe@just42.net, peter.golden@btinternet.com
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 05, 2013 at 02:32:38PM +0800, Raymond Yau wrote:
> > > Does this mean that the internal speaker and line out at Sep right (dock
> > > line out) at same node 0x10 ?
> >
> > Here is what I know:
> >
> >   Node 0x10 = Internal speaker
> 
> -static const struct hda_verb alc260_fujitsu_init_verbs[] = {
> -       /* Disable all GPIOs */
> -       {0x01, AC_VERB_SET_GPIO_MASK, 0},
> -       /* Internal speaker is connected to headphone pin */
> -       {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},
> 
> The auto model won't set pin ctls to HP when pin default is line out or
> speaker
> 
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1091868/comments/9

Do you require feedback from me about this?  As far as I can tell it's just
an observation which might partly explain why the speaker doesn't work on
the S7020.

In case it helps clarify things, perhaps I should explain some of the
comments which were previously contained within alc260_quirks.c (since I
wrote them).

  /* Internal speaker is connected to headphone pin */

Node 0x10 is notionally labelled "headphone pin" in the ALC260 datasheet. 
However, on the S7020 it is instead electrically connected to the internal
speaker.

  /* Headphone/Line-out jack connects to Line1 pin; make it an output */

Node 0x14 is described as "Line1 pin" in the ALC260 datasheet.  On the S7020
the designers have chosen to connect it to the headphone/line-out jack on
the laptop.

  /* Mic/Line-in jack is connected to mic1 pin, so make it an input */

This is perhaps the only consistent pin on the laptop.  The "mic1" pin of
the ALC260 is conected to the "Mic/Line-in" hack on the laptop.

In other words, on this particular laptop (and probably many others) the
designers have been fairly free when connecting pins to physical entities.

> Refer to your 3.3.5 info

What for, exactly?  Sorry, I'm confused as to what you're asking for here.

> Does auto mute work in kernel 3.3.5 since unsolicited event is not enabled ?

No idea - I have no interest in using auto-mute and have never had the
inclination to test it or look into it.

I've just looked now.  3.3.5 was booted, alsamixer does not show any
"automute" control to enable or disable this.  In any case, automute is
certainly not happening, so I'm guessing the answer to your question is no.

Regards
  jonathan
