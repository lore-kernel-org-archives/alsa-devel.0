From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: seq_midi client names
Date: Wed, 12 Apr 2006 14:02:48 +0100
Message-ID: <200604121402.48859.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_4pPPE7LVD/3pCxj"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


--Boundary-00=_4pPPE7LVD/3pCxj
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Takashi -message sent again with correct cc)

I delayed posting revised 'ice1712-pref-midi-names' patch to explore a 
side-effect:- the client name in /proc/asound/seq/clients also becomes 
'Wavetable DMX6fire 0' which is the intended name of the 2nd port.

AFAICT in seq_midi.c 'snd_seq_midisynth_register_port' occurs first for the 
2nd port, and has NULL client, so (L322) calls 
'snd_seq_create_kernel_client', passing info->name as the string augument, 
which is actually the specific port name.  Attached diff shows changing it to 
card->id for example; card->shortname would be similar, both give a more 
reasonable client name.  Is it correct for client to be NULL in this way?  
When 'snd_seq_midisynth_register_port' is called the second time ( for the 
first port) client == NULL is false so the section is passed.

Do you think this client name behaviour is OK as it is, or should it be 
changed?

Revised ice1712 patch posted separately.

Alan



--Boundary-00=_4pPPE7LVD/3pCxj
Content-Type: text/x-diff;
  charset="us-ascii";
  name="seq_midi.c-client-naming.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="seq_midi.c-client-naming.diff"

--- alsa-driver-orig-1.0.11rc3/alsa-kernel/core/seq/seq_midi.c	2006-01-16 16:29:08.000000000 +0000
+++ alsa-driver-1.0.11rc3/alsa-kernel/core/seq/seq_midi.c	2006-04-11 21:42:51.000000000 +0100
@@ -320,8 +322,8 @@
 		}
 		client->seq_client =
 			snd_seq_create_kernel_client(
-				card, 0, "%s", info->name[0] ?
-				(const char *)info->name : "External MIDI");
+				card, 0, "%s MIDI", card->id[0] ?
+				(const char *)card->id : "External");
 		if (client->seq_client < 0) {
 			kfree(client);
 			mutex_unlock(&register_mutex);

--Boundary-00=_4pPPE7LVD/3pCxj--




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
