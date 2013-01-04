From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: HDA regression on Fujitsu S7020 laptop (ALC260
 codec)
Date: Fri, 4 Jan 2013 14:54:23 +1030
Message-ID: <20130104042423.GD15726@marvin.atrad.com.au>
References: <20121228135207.GA24779@marvin.atrad.com.au>
 <s5hhamyr1ne.wl%tiwai@suse.de>
 <CAN8ccia6SGgukkzYQ_5XA0QkRXiq9E_vvqVmQ+sDBrg9ugqT9g@mail.gmail.com>
 <20130104032449.GA15708@marvin.atrad.com.au>
 <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id C45AE2616A0
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 05:24:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAN8cciYyWfq=hgdRt6abNpSfWDtG3mfbPNvf7TKGrsJ8OpaDhw@mail.gmail.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, jwoithe@just42.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 04, 2013 at 12:15:42PM +0800, Raymond Yau wrote:
> > > The driver need pin fixup  for the internal speaker and change the pin
> > > default of following node to [N/A]
> > >
> > > Node 0x13 [Jack] Line In at Sep Right
> > > Node 0x17 [Fixed] Aux at Oth Mobile-In
> > >
> > > -/* Initialisation sequence for ALC260 as configured in Fujitsu S702x
> > > - * laptops.  ALC260 pin usage: Mic/Line jack = 0x12, HP jack = 0x14, CD
> > > - * audio = 0x16, internal speaker = 0x10.
> > > - */
> > > -static const struct hda_verb alc260_fujitsu_ini
> > >
> > > Do the notebook really use node 0x16 CD ?
> >
> > Yes.  That's where the CD audio comes in.
> >
> 
> How about those HP and Mic of the port replicator ?

I have no idea: I never purchased the replicator.  In the absence of any
other information I would assume the replicator's ports are in parallel with
those of the laptop itself.  Unless someone with an S7020 and a replicator
turns up it will be impossible to know for sure.

> If also affect LIFEBOOK E8020
> https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1091868

At the very least it's a related issue.  I don't know what codec that laptop
uses though, so how that relates to the root cause of the trouble I'm having
on an S7020 is not clear to me.

Regards
  jonathan
