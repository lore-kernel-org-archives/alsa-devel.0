From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: Midi name string in mpu401_uart not unique
Date: Fri, 31 Mar 2006 11:02:37 +0100
Message-ID: <200603311102.37785.gineera@aspect135.co.uk>
References: <200603292313.21160.gineera@aspect135.co.uk> <200603301845.23074.gineera@aspect135.co.uk> <s5hpsk3n7jw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_94PLEekemSEN9vp"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hpsk3n7jw.wl%tiwai@suse.de>
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


--Boundary-00=_94PLEekemSEN9vp
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 30 March 2006 18:53, you wrote:
> At Thu, 30 Mar 2006 18:45:23 +0100,
> Alan Horstmann wrote:

> > On Thursday 30 March 2006 12:04, you wrote:
> > >
> > > Instead of adding a new argument to snd_mpu401_uart_new, the caller
> > > can overwrite the string after creating the instace.
> > >
> > > 	snd_mpu401_uart_new(card, device, type, ..., &rmidi);
> > > 	snprintf(rmidi->name, sizeof(rmidi->name),
> > > 		"MIDI Name As I Like %d", card->number);
> > >
> > > Then the change would be less intrusive.
> > >
> > > Or am I missing something else?
> >
> > Sounds a lot simpler -just involving the driver only; I will try this
> > later. In the mpu-names.diff midi names were added to
> > snd_ice1712_card_info to be used in the name string.  Is that still a
> > reasonable thing to do, or is there a better place, given that the
> > different sub-vendors might have different requirements?
>
> That addition looks OK to me.  What I don't want is to change the
> existing API if there is a simple solution.
>
> > Bearing in mind Clemens' comments, is there any value in improving the
> > name given by mpu401_uart_new when using ->shortname, as in the diff, by
> > adding card and device numbers?
>
> Maybe the order of "CARD DEVICE" like "DMX6fire WaveTable" is better?
> Just a matter of taste, though...

Would it be acceptable to add card, device to ->shortname in mpu401_uart as 
attached:

mpu401_uart.c-add-to-shortname.patch

Add card and device numbers to portnames generated from ->shortnames by 
snd_mpu401_uart_new.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>

--Boundary-00=_94PLEekemSEN9vp
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="mpu401_uart.c-add-to-shortname.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpu401_uart.c-add-to-shortname.patch"

--- mpu401_uart-orig.c	2005-11-18 18:52:14.000000000 +0000
+++ mpu401_uart.c	2006-03-31 10:33:33.000000000 +0100
@@ -506,7 +506,7 @@
 	mpu->irq = irq;
 	mpu->irq_flags = irq_flags;
 	if (card->shortname[0])
-		snprintf(rmidi->name, sizeof(rmidi->name), "%s MIDI", card->shortname);
+		snprintf(rmidi->name, sizeof(rmidi->name), "%s MIDI %d-%d", card->shortname, card->number, device);
 	else
 		sprintf(rmidi->name, "MPU-401 MIDI %d-%d", card->number, device);
 	snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_mpu401_uart_output);

--Boundary-00=_94PLEekemSEN9vp--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
