From: =?UTF-8?B?SsO2cm4gTmV0dGluZ3NtZWllcg==?= <nettings@stackingdwarves.net>
Subject: MIDI issue with RME HDSPM MADI
Date: Wed, 01 Jun 2011 19:27:32 +0200
Message-ID: <4DE67684.9010401@stackingdwarves.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080800050104080006010108"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.stackingdwarves.net (vm-evil.stackingdwarves.net
	[78.47.233.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7B90B1038AA
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:20:59 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Adrian Knoth <adi@drcomp.erfurt.thur.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080800050104080006010108
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi *!


The HDSPM MADI driver seems to have an issue with its MIDI=20
implementation. It is rock-solid for audio under Jack at 64=20
frames/period, but as soon as I start using the MIDI over MADI interface=20
(to remote-control my Micstasy preamps), I'm getting xruns every ten=20
seconds or so.

I've tried to debug the issue with the help of faberman, and he came up=20
with a midi drain() implementation for the driver, but it didn't help=20
with the xrun issue. It did help with busy MIDI programs in that they=20
are no longer stuck in D state almost all the time, but sleeping, like=20
any good program should.

This is a 2.6.39-rc7 kernel, and faberman has confirmed the issue with .3=
9.

The attached test program rawmiditest.c (build with -lasound) will=20
reproducibly cause xruns as soon as there is a mictasy on the MADI ring=20
so that there's actual traffic. With no-one listening, there will be no=20
xruns. (Might that be a hint that the problem is at the receiving end?)

This is really totally over my head, but I found one place in the driver=20
(snd_hdspm_midi_input_trigger) where a midi routine locks the entire=20
hdspm structure. it's flushing the midi input with the hdspm spinlock=20
held - could this be taking so long as to cause xruns?

I'm waiting for a MIDI cable to arrive so that I can test if the same=20
problem occurs when using the normal MIDI interfaces of the card (i.e.=20
not the MIDI over MADI one)...

For the record, faberman suspected that there is a bit too much locking=20
going on wrt the hmidi struct. OTOH, when we removed all hmidi=20
spinlocks, I was able to lock up the machine twice... maybe there is=20
some middle ground?

Meanwhile, any insights would be appreciated.


Best,


J=C3=B6rn



--=20
J=C3=B6rn Nettingsmeier
Lortzingstr. 11, 45128 Essen, Tel. +49 177 7937487

Meister f=C3=BCr Veranstaltungstechnik (B=C3=BChne/Studio)
Tonmeister (VDT)

http://stackingdwarves.net

--------------080800050104080006010108
Content-Type: text/x-csrc;
 name="rawmiditest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="rawmiditest.c"


#include <stdio.h>
#include <pthread.h>
#include <strings.h>
#include <alsa/asoundlib.h>

snd_rawmidi_t *in, *out;


void midi_open(char *rawmidi_device) {
	int err;

	err = snd_rawmidi_open(&in, &out, rawmidi_device, SND_RAWMIDI_NONBLOCK);
	if (err < 0) {
		fprintf(stderr, "snd_rawmidi_open %s failed: %d\n", rawmidi_device, err);
		exit(EXIT_FAILURE);
	}

}



int main() {
	int cnt, err;
	unsigned char c;
	unsigned char cmd[8] = {0xF0, 0x00, 0x20, 0x0D, 0x68, 0x02, 0x10, 0xF7};

	midi_open("hw:1,2");

	for (;;) {
		cnt++;
		err = snd_rawmidi_write(out, &cmd, 8);
		if (err < 0) {
			fprintf(stderr,"snd_rawmidi_write failed: %d\n", err);
			exit(EXIT_FAILURE);
		}

		snd_rawmidi_drain(out);

		for (;;) {
			err = snd_rawmidi_read(in, &c, 1);
			if (err < 0) {
				if (err==-11) {
					printf("\n");
					break;
				}
				fprintf(stderr,"snd_rawmidi_read failed: %d\n", err);
				exit(EXIT_FAILURE);
			} else {
				printf(" 0x%02x", c);
			}
		}
		

		
		printf("\r%d", cnt);
	}

	
}

--------------080800050104080006010108
Content-Type: text/x-patch;
 name="hdspm-locks+drain.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hdspm-locks+drain.diff"

--- sound/pci/rme9652/hdspm.c.orig	2011-05-15 17:56:25.819000813 +0200
+++ sound/pci/rme9652/hdspm.c	2011-06-01 19:05:06.402951169 +0200
@@ -1621,6 +1621,8 @@
 
 	spin_lock_irqsave (&hmidi->lock, flags);
 	n_pending = snd_hdspm_midi_input_available (hmidi->hdspm, hmidi->id);
+	spin_unlock_irqrestore(&hmidi->lock, flags);
+	
 	if (n_pending > 0) {
 		if (hmidi->input) {
 			if (n_pending > (int)sizeof (buf))
@@ -1639,12 +1641,12 @@
 		}
 	}
 	hmidi->pending = 0;
-
+	
+	spin_lock_irqsave (&hmidi->hdspm->lock, flags);
 	hmidi->hdspm->control_register |= hmidi->ie;
 	hdspm_write(hmidi->hdspm, HDSPM_controlRegister,
 		    hmidi->hdspm->control_register);
-
-	spin_unlock_irqrestore (&hmidi->lock, flags);
+	spin_unlock_irqrestore(&hmidi->hdspm->lock, flags);
 	return snd_hdspm_midi_output_write (hmidi);
 }
 
@@ -1773,11 +1775,25 @@
 	return 0;
 }
 
+static void snd_hdspm_midi_output_drain(struct snd_rawmidi_substream *substream)
+{
+	struct hdspm *hdspm;
+	struct hdspm_midi *hmidi;
+	
+	hmidi = substream->rmidi->private_data;
+	hdspm = hmidi->hdspm;
+	
+	while (128 != snd_hdspm_midi_output_possible(hdspm, hmidi->id)) {
+		mdelay(2);
+	}
+}
+
 static struct snd_rawmidi_ops snd_hdspm_midi_output =
 {
 	.open =		snd_hdspm_midi_output_open,
 	.close =	snd_hdspm_midi_output_close,
 	.trigger =	snd_hdspm_midi_output_trigger,
+	.drain = 	snd_hdspm_midi_output_drain,
 };
 
 static struct snd_rawmidi_ops snd_hdspm_midi_input =

--------------080800050104080006010108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080800050104080006010108--
