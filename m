From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: MIDI port names
Date: Thu, 20 Feb 2003 00:46:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200302200046.18193.plcl@telefonica.net>
References: <E18lUe8-0003K3-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_61YKSLIGJTS4LR5KPKQ2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18lUe8-0003K3-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_61YKSLIGJTS4LR5KPKQ2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

On Wednesday 19 February 2003 14:51, Takashi Iwai wrote:
> there is the name field for each rawmidi substream, and the sequencer
> looks up this string.
>
> this reminds me the former patch by Clemens, and i've forgotten to
> check this issue until now.  sorry.
>
> i modified the sequencer part (and mpu401_uart) on the cvs so that the
> sequencer retrieves the rawmidi name string if the substream name is
> not defined. 

But Clemens' patch (attached is a slightly modified version) was not for port 
names but for client names, from "External MIDI x" to the more meaningful 
rawmidi name. I think that this is what some people is requesting, and makes 
things easier for large studio setups when some applications, like kaconnect, 
show client names but not port names. Please, apply.

Regards,
Pedro

-- 
ALSA Library Bindings for Pascal
http://alsapas.alturl.com


--------------Boundary-00=_61YKSLIGJTS4LR5KPKQ2
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="seq_midi.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="seq_midi.c.patch"

--- alsa-kernel/core/seq/seq_midi.c.old	Wed Feb 19 23:23:50 2003
+++ alsa-kernel/core/seq/seq_midi.c	Thu Feb 20 00:20:09 2003
@@ -329,7 +329,10 @@
 		memset(&inf,0,sizeof(snd_seq_client_info_t));
 		inf.client = client->seq_client;
 		inf.type = KERNEL_CLIENT;
-		sprintf(inf.name, "External MIDI %i", card->number);
+		if (info.name[0])
+			strncpy(inf.name, info.name, sizeof(inf.name) - 1);
+		else
+			sprintf(inf.name, "External MIDI %i", card->number);
 		snd_seq_kernel_client_ctl(client->seq_client, SNDRV_SEQ_IOCTL_SET_CLIENT_INFO, &inf);
 	}
 

--------------Boundary-00=_61YKSLIGJTS4LR5KPKQ2--



-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
