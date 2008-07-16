From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: is this card supported by ALSA?
Date: Wed, 16 Jul 2008 11:16:32 +0200
Message-ID: <487DBC70.1000307@keyaccess.nl>
References: <BLU137-W110C592A46588437241F1A958C0@phx.gbl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080205020204010905020608"
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <BLU137-W110C592A46588437241F1A958C0@phx.gbl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080205020204010905020608
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On 15-07-08 22:28, Landis McGauhey wrote:

> Yes, I did delete '-dry-run'.
> 
> In fact, just to be doubly certain, I just re-ran the whole process and

I still worry a little bit, since if all's well, you should have seen 
the "patch -p1" command fail this time (it commenting that the patch 
seemed already applied) but I'll assume you did see that then. It's 
unfortunate that the problem with your card seems involved in a way 
which makes it fairly hard to debug this while not having the card 
locally to fiddle around with, adding delays between things ...

> additionally ran alsaconf (and again there was a loud 'click' in the 
> speakers when alsaconf loaded the driver):
> 
> # cat /proc/asound/AudioPCI/codec97#0/ac97#0-0=
> 0-0/0: 0x83848384 STS

... because, lovely, yet another variant. There is an interface problem 
between the ES1371 and (supposed) STAC9704 chips on your card and even 
though that MIGHT not be all the problem (even though the ALSA driver 
doesn't recognize your AC97 codec due to this, the OSS driver also 
drives it without any special quirks) this will need to be taken care of 
first.

With the card locally, the attached is the first thing I'd try. It makes 
the driver wait around a bit to have the codec recover from reset. Apply 
it as before, run "make" and "make modules_install" and re-load the 
snd-ens1371 driver with (as root) "modprobe -r snd-ens1371 && modprobe 
-r es1371 && modprobe snd-ens1371" after which ALSA sound may or may not 
work (test through aplay).

(note by the way that for now I'm foregoing any other problems you have 
with rebooting not loading the correct driver and such -- your dmesg 
indicated that the OSS es1371 driver was loading even though you said 
you blacklisted that, so just do the manual modprobe/modprobe -r stuff.)

Please also make sure that, after loading the newly patched snd-ens1371, 
there's nothing interesting at the end of dmesg -- nothing about 
timeouts and such. If there is something, please post.

If this doesn't work (likely) I'll just have to sit down and trace AC97 
accesses one by one between OSS and ALSA driver as nothing jumped out at 
me yet.

Rene.

--------------080205020204010905020608
Content-Type: text/plain;
 name="ens1371-ac97_reset_hack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ens1371-ac97_reset_hack.diff"

diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index cd74fb2..5344d3e 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -1934,6 +1934,7 @@ static struct es1371_quirk es1371_ac97_reset_hack[] = {
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_CT5880, .rev = CT5880REV_CT5880_E },
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_ES1371, .rev = ES1371REV_CT5880_A },
 	{ .vid = PCI_VENDOR_ID_ENSONIQ, .did = PCI_DEVICE_ID_ENSONIQ_ES1371, .rev = ES1371REV_ES1373_8 },
+	{ .vid = PCI_VENDOR_ID_ECTIVA,  .did = PCI_DEVICE_ID_ECTIVA_EV1938,  .rev = EV1938REV_EV1938_A },
 	{ .vid = PCI_ANY_ID, .did = PCI_ANY_ID }
 };
 #endif

--------------080205020204010905020608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--------------080205020204010905020608
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--------------080205020204010905020608--
