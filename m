From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Sat, 5 Jan 2013 14:32:38 +0800
Message-ID: <CAN8ccib6xbxAjpNXzxQQGVSo9vuNNPU7NdB7FPFWaNCXLpn+Gw@mail.gmail.com>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
 <20130104042423.GD15726@marvin.atrad.com.au>
 <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
 <20130105031254.GD11016@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f180.google.com (mail-ia0-f180.google.com
 [209.85.210.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B66C52616CF
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2013 07:32:39 +0100 (CET)
Received: by mail-ia0-f180.google.com with SMTP id t4so14218185iag.39
 for <alsa-devel@alsa-project.org>; Fri, 04 Jan 2013 22:32:38 -0800 (PST)
In-Reply-To: <20130105031254.GD11016@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>, peter.golden@btinternet.com
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > > > > > The driver need pin fixup  for the internal speaker and change
the pin
> > > > > > default of following node to [N/A]
> > > > > >
> > > > > > Node 0x13 [Jack] Line In at Sep Right
> > > > > > Node 0x17 [Fixed] Aux at Oth Mobile-In
> > > > > >
> > > > > > -/* Initialisation sequence for ALC260 as configured in Fujitsu
S702x
> > > > > > - * laptops.  ALC260 pin usage: Mic/Line jack = 0x12, HP jack =
0x14, CD
> > > > > > - * audio = 0x16, internal speaker = 0x10.
> > > > > > - */
> > > > > > -static const struct hda_verb alc260_fujitsu_ini
> > > > > >
> > > > > > Do the notebook really use node 0x16 CD ?
> > > > >
> > > > > Yes.  That's where the CD audio comes in.
> > > > >
> > > >
> > > > How about those HP and Mic of the port replicator ?
> > >
> > > I have no idea: I never purchased the replicator.  In the absence of
any
> > > other information I would assume the replicator's ports are in
parallel with
> > > those of the laptop itself.  Unless someone with an S7020 and a
replicator
> > > turns up it will be impossible to know for sure.
> > >
> > > > If also affect LIFEBOOK E8020
> > > > https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1091868
> >
> > Does this mean that the internal speaker and line out at Sep right (dock
> > line out) at same node 0x10 ?
>
> Here is what I know:
>
>   Node 0x10 = Internal speaker

-static const struct hda_verb alc260_fujitsu_init_verbs[] = {
-       /* Disable all GPIOs */
-       {0x01, AC_VERB_SET_GPIO_MASK, 0},
-       /* Internal speaker is connected to headphone pin */
-       {0x10, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_HP},

The auto model won't set pin ctls to HP when pin default is line out or
speaker

https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1091868/comments/9

>   Node 0x12 = Mic/Line jack on laptop

-       /* Mic/Line-in jack is connected to mic1 pin, so make it an input */
-       {0x12, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},

>   Node 0x14 = Headphone jack on laptop

-       /* Headphone/Line-out jack connects to Line1 pin; make it an output
*/
-       {0x14, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},

Refer to your 3.3.5 info

Does auto mute work in kernel 3.3.5 since unsolicited event is not enabled ?

Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
Control: name="Headphone Jack Mode", index=0, device=0 Amp-Out caps:
ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense Vref caps: HIZ 50 80
Pin Default 0x0321101f: [Jack] HP Out at Ext Left Conn = 1/8, Color = Black
DefAssociation = 0x1, Sequence = 0xf Pin-ctls: 0x40: OUT VREF_HIZ
Unsolicited: tag=00, enabled=0
Connection: 1 0x0d
