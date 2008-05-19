From: Travis Place <wishie@wishie.net>
Subject: Re: Incorrect model selection for HDA Intel based card.
Date: Tue, 20 May 2008 02:01:02 +1000
Message-ID: <200805200201.02530.wishie@wishie.net>
References: <200805190419.14316.wishie@wishie.net>
	<200805200143.31066.wishie@wishie.net>
	<s5h1w3yb871.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+QaMI8CLNaQ7oCi"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-101.dial.usertools.net
	[202.137.100.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 6048B245FD
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 18:01:24 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id A964431C83
	for <alsa-devel@alsa-project.org>; Mon, 19 May 2008 16:22:32 +1000 (EST)
In-Reply-To: <s5h1w3yb871.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_+QaMI8CLNaQ7oCi
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 20 May 2008 1:54:42 am Takashi Iwai wrote:
> At Tue, 20 May 2008 01:43:31 +1000,
>
> Travis Place wrote:
> > On Mon, 19 May 2008 10:09:00 pm Takashi Iwai wrote:
> > > At Mon, 19 May 2008 04:19:14 +1000,
> > >
> > > Travis Place wrote:
> > > > Just had a user in #alsa on freenode, with an Asus P5GD1 mainboard.
> > > > They couldnt seem to get surround sound working at all.
> > > > It has an ALC880 based HDA-Intel sound device on board.
> > > >
> > > > Now, the problem lies in the Susbsystem ID's (1043:814e).
> > > > These match in patch_realtek.c as follows:
> > > >
> > > > SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS)
> > > >
> > > > The users mainboard (The ASUS P5GD1) actually has 6 output jacks,
> > > > aswell as SPDIF, not the standard 3-jacks that the "ASUS" model quirk
> > > > implies.
> > > >
> > > > I talked this user through forcing the driver to use '6stack-digout'
> > > > for his sound device, and things all work fine now.
> > >
> > > Actually, this was changed originally from ALC880_5STACK for the
> > > exactly same mobo (changeset 4798).  I guess 6stack-digout wasn't
> > > tested by that user.
> > >
> > > So, if 6stack-digout is confirmed to match better than now, it's
> > > fairly safe to replace the line.  Care to send a patch with a proper
> > > changelog?
> > >
> > >
> > > thanks,
> > >
> > > Takashi
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
> > As previously mentioned, it appears the HG code has an entry for the
> > "ASUS P5GD1" mainboard. But its onboard sound vendor/device Ids dont
> > match those of the person i was helping. I have double checked the
> > pastebin post, and confirmed the mainboard model with the user though.
> >
> > The _original_ alsa-info.sh run (before the model was forced to
> > 6stack-digout) is as follows..
> >
> > http://pastebin.ca/1021995
> >
> > There it shows the vendor/device ids as 0x1043, 0x814e .
>
> 1043:814e is also P5GD1.
> 	http://www.linuxquestions.org/questions/showthread.php?p=2556497#post25564
>97
>
> It was changed to ALC880_ASUS based on the report in the above.
>
> > So according to the current HG code, those IDs would select the "asus"
> > model. Also, in the same, current HG code, we have..
> >
> > SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST)
> >
> > This shows the correct model name for the mainboard, but (from my
> > experience) wrong vendor/device ids.
> >
> > Perhaps we have to check with the person who originally added that P5GD1
> > quirk ?
> >
> > I have made up a patch, but want to confirm all this information before
> > proceeding. Please let me know your thoughts.
>
> I believe it's fine to change to 6stack model if the tester's board is
> also P5GD1 indeed.  Of course, it's possible that ASUS may change the
> hardware design completely for the same model number with PCI SSID,
> but I hope they aren't so crazy :)
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Below (as well as attached) is my patch, for the 0x814e variant.


diff -r e2b60934d1c8 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon May 19 12:32:25 2008 +0200
+++ b/pci/hda/patch_realtek.c	Tue May 20 01:50:04 2008 +1000
@@ -2981,7 +2981,7 @@ static struct snd_pci_quirk alc880_cfg_t
 	/* SND_PCI_QUIRK(0x1043, 0x1964, "ASUS", ALC880_ASUS_DIG), */
 	SND_PCI_QUIRK(0x1043, 0x1973, "ASUS", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x19b3, "ASUS", ALC880_ASUS_DIG),
-	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS),
+	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS P5GD1 w/SPDIF", ALC880_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8181, "ASUS P4GPL", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST),
 	SND_PCI_QUIRK(0x1043, 0x81b4, "ASUS", ALC880_6ST),

Changelog should be something like:

Corrected the model assignment for the ASUS P5GD1 w/SPDIF after reports of 
surround sound not being possible.

Let me know if you need a more detailed changelog entry.

Travis Place

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 

--Boundary-00=_+QaMI8CLNaQ7oCi
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="P5GD1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="P5GD1.patch"

diff -r e2b60934d1c8 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Mon May 19 12:32:25 2008 +0200
+++ b/pci/hda/patch_realtek.c	Tue May 20 02:00:37 2008 +1000
@@ -2981,7 +2981,7 @@ static struct snd_pci_quirk alc880_cfg_t
 	/* SND_PCI_QUIRK(0x1043, 0x1964, "ASUS", ALC880_ASUS_DIG), */
 	SND_PCI_QUIRK(0x1043, 0x1973, "ASUS", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x19b3, "ASUS", ALC880_ASUS_DIG),
-	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS", ALC880_ASUS),
+	SND_PCI_QUIRK(0x1043, 0x814e, "ASUS P5GD1 w/SPDIF", ALC880_6ST_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8181, "ASUS P4GPL", ALC880_ASUS_DIG),
 	SND_PCI_QUIRK(0x1043, 0x8196, "ASUS P5GD1", ALC880_6ST),
 	SND_PCI_QUIRK(0x1043, 0x81b4, "ASUS", ALC880_6ST),

--Boundary-00=_+QaMI8CLNaQ7oCi
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_+QaMI8CLNaQ7oCi--
