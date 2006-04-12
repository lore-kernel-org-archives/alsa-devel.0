From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: ice1712 overwrite standard midi port names
Date: Wed, 12 Apr 2006 10:48:23 +0100
Message-ID: <200604121048.23790.gineera@aspect135.co.uk>
References: <200604012206.27893.gineera@aspect135.co.uk> <200604032240.29121.gineera@aspect135.co.uk> <s5hslot746r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nzMPE0oBvYgHapN"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hslot746r.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_nzMPE0oBvYgHapN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 04 April 2006 16:26, you wrote:
> At Mon, 3 Apr 2006 22:45:58 +0100,
>
> Alan Horstmann wrote:
> > On Monday 03 April 2006 17:47, you wrote:
> > > At Sat, 1 Apr 2006 22:06:27 +0100,
> > >
> > > Alan Horstmann wrote:
> > > > Following our discussions I had time to prepare this patch for
> > > > ice1712 driver. I figured you prefered the minimum changes to achieve
> > > > the end result.  The replacement names in ews.c are left as I prefer,
> > > > 'detail, card', but if you choose, just reverse the order, to comply
> > > > instead with convention.  How does this proposal look?
> > >
> > > I don't think -0 and -1 suffix are necessary.  You give the individual
> > > name for each device, so they must be unique as they are.
> >
> > True, however I included them for the following reasons:-
> >   a)  The default name in mpu401...new has the 2 numbers with a hyphen,
> > so there is consistency making it clearer what they refer to.
> >   b)  If only a single number were used, there would need to be some
> > extra characters to say that it refered to the card number, not device,
> > eg c-1 or card-1.
>
> There wasn't any assumption about the card/device number appearing in
> the name, and there won't.  The rule is simple: the name should be
> unique.  The current name is generated just to achieve it easily.
>
> >   c)  It records somewhere to users (not reading the source-code) which
> > device is connected to each of the name strings.
>
> For users, basically it doesn't matter which device has the device
> number 0 or 1.  User needs to know only what these devices are.
>
> >   d)  There seemed to be no overriding reason to leave them out.
>
> Ugliness.
>
> > > - Fix spaces / indentation
> >
> > Can you be more specific?  Do you mean second half of sprintf brackets? 
> > I can only see one unneccesary blank line.  From the patch lines it is
> > probably not obvious that the second port lines are indented further due
> > to an extra 'if' statement.
>
> The indent level isn't aligned properly.  Not a big issue, I can
> adjust it by myself before merging.

Revised patch is attached which I think is as requested.

Alan

ice1712-add-pref-midi-names-2.patch

Summary: Provides specified midi port names instead of defaults

Patch provides for the ice1712 card driver to overwrite the midi port name 
string given by default in mpu401_uart, with one specified in 
snd_ice1712_card_info.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_nzMPE0oBvYgHapN
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ice1712-add-pref-midi-names-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ice1712-add-pref-midi-names-2.patch"

diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c	2005-11-22 14:33:27.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ews.c	2006-03-31 14:12:46.000000000 +0100
@@ -1031,6 +1031,8 @@
 		.model = "dmx6fire",
 		.chip_init = snd_ice1712_ews_init,
 		.build_controls = snd_ice1712_ews_add_controls,
+		.mpu401_1_name = "MIDI-Front DMX6fire",
+		.mpu401_2_name = "Wavetable DMX6fire",
 	},
 	{ } /* terminator */
 };
diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c	2006-01-16 16:34:25.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.c	2006-03-31 14:02:30.000000000 +0100
@@ -2725,8 +2743,11 @@
 			snd_card_free(card);
 			return err;
 		}
+		if (c->mpu401_1_name != NULL)   /*  Prefered name available in card_info  */
+			snprintf(ice->rmidi[0]->name, sizeof(ice->rmidi[0]->name),
+						"%s %d", c->mpu401_1_name, card->number);
 
-		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401)
+		if (ice->eeprom.data[ICE_EEP1_CODEC] & ICE1712_CFG_2xMPU401) {  /*  2nd port used  */
 			if ((err = snd_mpu401_uart_new(card, 1, MPU401_HW_ICE1712,
 						       ICEREG(ice, MPU2_CTRL), 1,
 						       ice->irq, 0,
@@ -2734,6 +2755,10 @@
 				snd_card_free(card);
 				return err;
 			}
+			if (c->mpu401_2_name != NULL)   /*  Prefered name available in card_info  */
+				snprintf(ice->rmidi[1]->name, sizeof(ice->rmidi[1]->name),
+							"%s %d", c->mpu401_2_name, card->number);
+		}
 	}
 
 	snd_ice1712_set_input_clock_source(ice, 0);
diff -ru ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h
--- ../alsa-driver-orig-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h	2006-01-16 16:34:25.000000000 +0000
+++ ../alsa-driver-1.0.11rc3/alsa-kernel/pci/ice1712/ice1712.h	2006-03-29 11:23:12.000000000 +0100
@@ -493,6 +494,8 @@
 	int (*chip_init)(struct snd_ice1712 *);
 	int (*build_controls)(struct snd_ice1712 *);
 	unsigned int no_mpu401: 1;
+	const char *mpu401_1_name;
+	const char *mpu401_2_name;
 	unsigned int eeprom_size;
 	unsigned char *eeprom_data;
 };

--Boundary-00=_nzMPE0oBvYgHapN--




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
