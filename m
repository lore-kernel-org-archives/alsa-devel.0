From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Alsa 1.0.13 (and others) does not work on ALC880
Date: Sat, 19 May 2007 08:47:49 -0700
Message-ID: <1179589669.15236.28.camel@razman.gruemaster.com>
References: <Pine.LNX.4.58.0705190144230.8331@integrity.ugnet.org>
	<s5h7ir4etl6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vObiFWfjhIr8h5UxMEUI"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F75C24504
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 17:47:52 +0200 (CEST)
In-Reply-To: <s5h7ir4etl6.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>, Andrew Callan <acallan.alsa@ugnet.org>
List-Id: alsa-devel@alsa-project.org


--=-vObiFWfjhIr8h5UxMEUI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Based on this information, I'll go ahead and add your device ID to the
codec driver so you won't need to add the "model=" modprobe parameter
(see attached patch).  The probe_mask issue will need more work to
figure out what exactly is going on.  I wonder if it might be acpi
related?

---- cut --------- cut --------- cut --------- cut -----

Summary: hda-codec:  Add support for Clevo D900 system

This patch adds subsystem ID for the D900 system to the ALC880 code.


Signed off by Tobin Davis <tdavis@dsl-only.net>

---- cut --------- cut --------- cut --------- cut -----

On Sat, 2007-05-19 at 17:11 +0200, Takashi Iwai wrote:

> At Sat, 19 May 2007 02:08:14 -0500 (CDT),
> Andrew Callan wrote:
> > 
> > I have been without sound using Fedora Core ever since the 2.6.16 or
> > 2.6.17 kernel update (2.6.16 crashed during initialization, so I could not
> > tell whether sound worked or not).  It had worked well through the 2.6.15
> > Fedora kernels.  I finally sat down tonight to work the problem as hard as
> > I could and happened upon Eric and Tobin's timely exchange.
> > 
> > First, simply adding probe_mask=1 to the snd-hda-intel options worked for
> > me as well; I did not end up having to specify a specific model.
> > 
> > Second, I too was seeing a LONG hang when trying to do:
> > cat /proc/asound/card0/codec#0
> > but now with the probe_mask=1, I do not see this.
> > 
> > If it helps, the alsa-info.sh output for my system is at
> > http://pastebin.ca/496293
> > If it makes any difference, I'm not sure which model I had specified on
> > the modprobe line at the time I captured this output.
> > 
> > One thing I do notice is that after adding probe_mask=1, aplay -l does not
> > show the Si3054 Modem which shows up in the alsa-info output.
> > 
> > Thanks for the help you gave in the thread with Eric.
> > 
> > Andrew
> 
> Interesting.  I've seen similar reports that probe_mask helps.
> Do you disable the modem codec on BIOS or is it enabled?
> 
> If this happens even though it's enabled on BIOS, we'd need a
> blacklist of non-working devices, or a more robust probing routine...
> 
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel



--=-vObiFWfjhIr8h5UxMEUI
Content-Disposition: attachment; filename=Clevo.patch
Content-Type: text/x-patch; name=Clevo.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -r 5bd948503866 pci/hda/patch_realtek.c
--- a/pci/hda/patch_realtek.c	Tue May 15 11:47:48 2007 +0200
+++ b/pci/hda/patch_realtek.c	Sat May 19 08:44:04 2007 -0700
@@ -2563,6 +2565,7 @@ static struct snd_pci_quirk alc880_cfg_t
 	SND_PCI_QUIRK(0x107b, 0x3032, "Gateway", ALC880_5ST),
 	SND_PCI_QUIRK(0x1558, 0x0520, "Clevo m520G", ALC880_CLEVO),
 	SND_PCI_QUIRK(0x1558, 0x0660, "Clevo m655n", ALC880_CLEVO),
+	SND_PCI_QUIRK(0x1558, 0x0900, "Clevo D900", ALC880_CLEVO),
 	SND_PCI_QUIRK(0x1565, 0x8202, "Biostar", ALC880_5ST_DIG),
 	SND_PCI_QUIRK(0x161f, 0x203d, "W810", ALC880_W810),
 	SND_PCI_QUIRK(0x1695, 0x400d, "EPoX", ALC880_5ST_DIG),

--=-vObiFWfjhIr8h5UxMEUI
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--=-vObiFWfjhIr8h5UxMEUI--
