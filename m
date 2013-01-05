From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
	codec)
Date: Sat, 5 Jan 2013 09:31:23 +0800
Message-ID: <CAN8cciYhydz6e6oz2QU4NeQgWsJU+4BQrhW6CK1tYd_+4E6pBw@mail.gmail.com>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
 <20130104042423.GD15726@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 0159C264F53
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2013 02:31:24 +0100 (CET)
Received: by mail-ie0-f179.google.com with SMTP id k14so20305033iea.38
 for <alsa-devel@alsa-project.org>; Fri, 04 Jan 2013 17:31:24 -0800 (PST)
In-Reply-To: <20130104042423.GD15726@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > > > The driver need pin fixup  for the internal speaker and change the
pin
> > > > default of following node to [N/A]
> > > >
> > > > Node 0x13 [Jack] Line In at Sep Right
> > > > Node 0x17 [Fixed] Aux at Oth Mobile-In
> > > >
> > > > -/* Initialisation sequence for ALC260 as configured in Fujitsu
S702x
> > > > - * laptops.  ALC260 pin usage: Mic/Line jack = 0x12, HP jack =
0x14, CD
> > > > - * audio = 0x16, internal speaker = 0x10.
> > > > - */
> > > > -static const struct hda_verb alc260_fujitsu_ini
> > > >
> > > > Do the notebook really use node 0x16 CD ?
> > >
> > > Yes.  That's where the CD audio comes in.
> > >
> >
> > How about those HP and Mic of the port replicator ?
>
> I have no idea: I never purchased the replicator.  In the absence of any
> other information I would assume the replicator's ports are in parallel
with
> those of the laptop itself.  Unless someone with an S7020 and a replicator
> turns up it will be impossible to know for sure.
>
> > If also affect LIFEBOOK E8020
> > https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1091868
>

Does this mean that the internal speaker and line out at Sep right (dock
line out) at same node 0x10 ?

Table 109. Port Connectivity

11b  Both a jack and an internal device are attached.  The Information
provided in all other fields refers to the integrated device.  The PD pin
will reflect the status of the jack; the user will need to be queried to
figure out what it is

As Line in at ext right (Dock line in) at node 0x13

Node 0x10 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x00 0x00]
Pincap 0x0001003f: IN OUT HP EAPD Detect Trigger ImpSense
EAPD 0x2: EAPD
Pin Default 0xe4011110: [Both] Line Out at Sep Right Conn = 1/8, Color =
Black DefAssociation = 0x1, Sequence = 0x0 Misc = NO_PRESENCE
Pin-ctls: 0xc0: OUT HP
Unsolicited: tag=00, enabled=0
Connection: 1 0x09

Node 0x13 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
Amp-Out vals: [0x80 0x80]
Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense Vref caps: HIZ 50 80
Pin Default 0x24811121: [Jack] Line In at Sep Right
Conn = 1/8, Color = Black DefAssociation = 0x2, Sequence = 0x1 Misc =
NO_PRESENCE
Pin-ctls: 0x00: VREF_HIZ
Unsolicited: tag=00, enabled=0
Connection: 1 0x0c
