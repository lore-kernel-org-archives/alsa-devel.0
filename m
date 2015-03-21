From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: getting the sound to work on my asus m6s00v
Date: Sat, 21 Mar 2015 11:24:27 +0800
Message-ID: <CAN8cciYFUAKwv2OA8xO6VDbMf=MmpABBTwFwwv7t+N9m7HX8AA@mail.gmail.com>
References: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
 <5508DD4D.3040901@canonical.com>
 <CAN8cciaU_U+UwpJkayz2RhpSjfur9TC+X_HVC1=AGY2ypbcEmA@mail.gmail.com>
 <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
 <CAN8cciYW6gcFuq-=oGyB85TgW=m9017yy83_M6vZMmy+f=yz=g@mail.gmail.com>
 <150081b6e7eaeec3b9495753945733c4@swn.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AC5426042F
 for <alsa-devel@alsa-project.org>; Sat, 21 Mar 2015 04:24:28 +0100 (CET)
Received: by oifl3 with SMTP id l3so75646923oif.0
 for <alsa-devel@alsa-project.org>; Fri, 20 Mar 2015 20:24:27 -0700 (PDT)
In-Reply-To: <150081b6e7eaeec3b9495753945733c4@swn.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gleerup <cromozon@swn.nu>, tiwai@suse.de
Cc: Hui Wang <hui.wang@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, nb@dagami.org
List-Id: alsa-devel@alsa-project.org

>
> > > The internal mic also works.
> > >
> > > but; I am a bit puzled, because I tried to comment out 'options
> > snd-hda-intel model=3stack-digout' and did a powercycle (power off)...
> > > and now the sound still works, so it seems the soundcard was woken
from
> > some deepsleep.
> > > The machine have been turned of for many (4/5) years...
> > >
> > > Anyway since the soundcard now is working with my current kernel
without
> > the extra options, I am unsure if trying the newest vanilla kernel would
> > make any sense?
> > >
> > > Any recommendations?
> >
> > If it is a netbook with one jack which can be used as headphone or mic
>
> Not a neetbook, two jacks, one Mic, and one S/PDIF

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=487a588d09db0d6508261867df208d8bdc718251

+ [ALC880_FIXUP_ASUS_W5A] = {
+ .type = HDA_FIXUP_PINS,
+ .v.pins = (const struct hda_pintbl[]) {
+ /* set up the whole pins as BIOS is utterly broken */
+ { 0x14, 0x0121411f }, /* HP */
+ { 0x15, 0x411111f0 }, /* N/A */
+ { 0x16, 0x411111f0 }, /* N/A */
+ { 0x17, 0x411111f0 }, /* N/A */
+ { 0x18, 0x90a60160 }, /* mic */
+ { 0x19, 0x411111f0 }, /* N/A */
+ { 0x1a, 0x411111f0 }, /* N/A */
+ { 0x1b, 0x411111f0 }, /* N/A */
+ { 0x1c, 0x411111f0 }, /* N/A */
+ { 0x1d, 0x411111f0 }, /* N/A */
+ { 0x1e, 0xb743111e }, /* SPDIF out */
+ { }
+ },
+ .chained = true,
+ .chain_id = ALC880_FIXUP_GPIO1,
+ },

Using hda emu and the latest alsa driver,   headphone mic phantom jack is
created and enable shared I/O jack at node 0x14

0x18, 0x90a60160   [Fixed] Mic at Int

this seem different from your hdajacksensetest result if you can detect mic
jack at node 0x18

This mean bug in create headphone  mic jack if headphone mic require
specifc sequence number
