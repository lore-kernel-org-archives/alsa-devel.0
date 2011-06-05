From: =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
Subject: [PATCH] RME HDSPM MADI lock fix
Date: Sun, 05 Jun 2011 11:57:57 +0200
Message-ID: <4DEB5325.9070903@stackingdwarves.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070803010807060206050509"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.stackingdwarves.net (vm-evil.stackingdwarves.net
	[78.47.233.26]) by alsa0.perex.cz (Postfix) with ESMTP id C792A10380B
	for <alsa-devel@alsa-project.org>;
	Sun,  5 Jun 2011 11:51:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Adrian Knoth <adi@drcomp.erfurt.thur.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070803010807060206050509
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

hi *!

while we were trying to debug the midi-related xruns in the current=20
driver, i came across what looks like an unrelated locking bug to me:

static int snd_hdspm_midi_input_read (struct hdspm_midi *hmidi)
...
         spin_lock_irqsave (&hmidi->lock, flags); <---------------
         n_pending =3D snd_hdspm_midi_input_available (hmidi->hdspm,=20
hmidi->id);
         if (n_pending > 0) {
                 if (hmidi->input) {
                         if (n_pending > (int)sizeof (buf))
                                 n_pending =3D sizeof (buf);
                         for (i =3D 0; i < n_pending; ++i)
                                 buf[i] =3D snd_hdspm_midi_read_byte=20
(hmidi->hdspm,
=20
hmidi->id);
                         if (n_pending)
                                 snd_rawmidi_receive (hmidi->input, buf,
                                                      n_pending);
                 } else {
                         /* flush the MIDI input FIFO */
                         while (n_pending--)
                                 snd_hdspm_midi_read_byte (hmidi->hdspm,
                                                           hmidi->id);
                 }
         }
         hmidi->pending =3D 0;

         hmidi->hdspm->control_register |=3D hmidi->ie;<------- !!!
         hdspm_write(hmidi->hdspm, HDSPM_controlRegister,
                     hmidi->hdspm->control_register);

         spin_unlock_irqrestore (&hmidi->lock, flags);<---------
         return snd_hdspm_midi_output_write (hmidi);
}


if i understand this whole business correctly, we should be holding the=20
hdspm lock here, not the hmidi one.

please review the attached patch and apply if you think it's ok.


best,


j=C3=B6rn



--=20
J=C3=B6rn Nettingsmeier
Lortzingstr. 11, 45128 Essen, Tel. +49 177 7937487

Meister f=C3=BCr Veranstaltungstechnik (B=C3=BChne/Studio)
Tonmeister (VDT)

http://stackingdwarves.net

--------------070803010807060206050509
Content-Type: text/x-patch;
 name="hdspm-lockfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdspm-lockfix.diff"

--- sound/pci/rme9652/hdspm.c~	2011-06-01 21:30:24.000000000 +0200
+++ sound/pci/rme9652/hdspm.c	2011-06-01 22:04:08.184946711 +0200
@@ -1619,7 +1619,7 @@
 	int n_pending;
 	int i;
 
-	spin_lock_irqsave (&hmidi->lock, flags);
+	spin_lock_irqsave (&hmidi->hdspm->lock, flags);
 	n_pending = snd_hdspm_midi_input_available (hmidi->hdspm, hmidi->id);
 	if (n_pending > 0) {
 		if (hmidi->input) {
@@ -1644,7 +1644,7 @@
 	hdspm_write(hmidi->hdspm, HDSPM_controlRegister,
 		    hmidi->hdspm->control_register);
 
-	spin_unlock_irqrestore (&hmidi->lock, flags);
+	spin_unlock_irqrestore (&hmidi->hdspm->lock, flags);
 	return snd_hdspm_midi_output_write (hmidi);
 }
 

--------------070803010807060206050509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070803010807060206050509--
