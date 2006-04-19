From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: seq_midi client names
Date: Wed, 19 Apr 2006 20:54:16 +0100
Message-ID: <200604191247.12207.gineera@aspect135.co.uk>
References: <200604121402.48859.gineera@aspect135.co.uk> <200604131354.45544.gineera@aspect135.co.uk> <20060413152617.GB1147@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oVpREjr1r1pizdO"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060413152617.GB1147@turing.informatik.uni-halle.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_oVpREjr1r1pizdO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 13 April 2006 16:26, Clemens wrote:
> Alan Horstmann wrote:
> > I'll post a patch to change seq_midi to use card->shortname instead of
> > info->name for the new client name, if that is OK with you?
>
> Yes.

Patch to change midi client names, following discussion with Clemens.

seq_midi.c-client-naming.patch

Summary: Change seq_midi.c so client name is card, rather than port, specific

Change snd_seq_midisynth_register_port() in seq_midi.c so that if a new client 
is created, the client name string is based on card->shortname not 
(port-specific) info->name.

Signed-off-by: Alan Horstmann <gineera@aspect135.co.uk>





--Boundary-00=_oVpREjr1r1pizdO
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="seq_midi.c-client-naming.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="seq_midi.c-client-naming.patch"

--- alsa-driver-orig-1.0.11rc3/alsa-kernel/core/seq/seq_midi.c	2006-01-16 16:29:08.000000000 +0000
+++ alsa-driver-1.0.11rc3/alsa-kernel/core/seq/seq_midi.c	2006-04-11 21:42:51.000000000 +0100
@@ -320,8 +320,8 @@
 		}
 		client->seq_client =
 			snd_seq_create_kernel_client(
-				card, 0, "%s", info->name[0] ?
-				(const char *)info->name : "External MIDI");
+				card, 0, "%s", card->shortname[0] ?
+				(const char *)card->shortname : "External MIDI");
 		if (client->seq_client < 0) {
 			kfree(client);
 			mutex_unlock(&register_mutex);

--Boundary-00=_oVpREjr1r1pizdO--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
