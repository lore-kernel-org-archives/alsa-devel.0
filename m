From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Accessing all 8 channels on a Audigy 2 card
Date: Mon, 21 Jun 2004 13:14:35 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200406211114.i5LBEZRH018924@www1.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: eklein@ait.nrl.navy.mil
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

This is mostly for Audigy 2 ZS, should work with Audigy 2 (if works).

Use patch  audigy2zs_driver.diff from
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_i=
d=3D0000270
Add changes below to conf files. And first test aplay with side device
(aplay -D side some.wav) (PCM Side controls should control volume of
side speakers.
Warning, I not tested this, maybe this works maybe not.

Peter Zubaj

Try to add this to /usr/share/alsa/conf/cards/Audigy2.conf


<confdir:pcm/side.conf>

Audigy2.pcm.side.0 {
=09@args [ CARD ]
=09@args.CARD {
=09=09type string
=09}
=09type hooks
=09slave.pcm {
=09=09type hw
=09=09card $CARD
=09=09device 0
=09}
=09hooks.0 {
=09=09type ctl_elems
=09=09hook_args [
=09=09=09{
=09=09=09=09name "EMU10K1 PCM Send Volume"
=09=09=09=09index { @func private_pcm_subdevice }
=09=09=09=09lock true
=09=09=09=09value [ 255 255 0 0 0 0 0 0  255 0 0 0 0 0 0 0  0 255 0 0 0 0 0=
 0 ]
=09=09=09}
=09=09=09{
=09=09=09=09name "EMU10K1 PCM Send Routing"
=09=09=09=09index { @func private_pcm_subdevice }
=09=09=09=09lock true
=09=09=09=09value [ 14 15 0 0 0 0 0 0  14 15 0 0 0 0 0 0  14 15 0 0 0 0 0 0=
 ]
=09=09=09}=20
=09=09]
=09}
}

<confdir:pcm/surround71.conf>

Audigy2.pcm.surround71.0 {
=09@args [ CARD ]
=09@args.CARD {
=09=09type string
=09}
=09type multi
=09slaves [
=09=09{
=09=09=09pcm {
=09=09=09=09@func concat
=09=09=09=09strings [
=09=09=09=09=09"cards.Audigy2.pcm.front.0:CARD=3D" $CARD
=09=09=09=09]
=09=09=09}
=09=09=09channels 2
=09=09}
=09=09{
=09=09=09pcm {
=09=09=09=09@func concat
=09=09=09=09strings [
=09=09=09=09=09"cards.Audigy2.pcm.rear.0:CARD=3D" $CARD
=09=09=09=09]
=09=09=09}
=09=09=09channels 2
=09=09}
=09=09{
=09=09=09pcm {
=09=09=09=09@func concat
=09=09=09=09strings [
=09=09=09=09=09"cards.Audigy2.pcm.center_lfe.0:CARD=3D" $CARD
=09=09=09=09]
=09=09=09}
=09=09=09channels 2
=09=09}
=09=09{
=09=09=09pcm {
=09=09=09=09@func concat
=09=09=09=09strings [
=09=09=09=09=09"cards.Audigy2.pcm.side.0:CARD=3D" $CARD
=09=09=09=09]
=09=09=09}
=09=09=09channels 2
=09=09}
=09]
=09bindings [
=09=09{ slave 0 channel 0 }
=09=09{ slave 0 channel 1 }
=09=09{ slave 1 channel 0 }
=09=09{ slave 1 channel 1 }
=09=09{ slave 2 channel 0 }
=09=09{ slave 2 channel 1 }
=09=09{ slave 3 channel 0 }
=09=09{ slave 3 channel 1 }
=09]
}=20


and create new file in /usr/share/conf/pcm/ with name surround71.conf
and put this in it

#
#  Hardware output from 5.1 speakers
#  Samples must be positioned:
#    chn0 - front left
#    chn1 - front right
#    chn2 - rear left
#    chn3 - rear right
#    chn4 - center
#    chn5 - lfe
#    chn7 - side left
#    chn8 - side right
#

pcm.!surround71 {
=09@args [ CARD DEV ]
=09@args.CARD {
=09=09type string
=09=09default {
=09=09=09@func getenv
=09=09=09vars [
=09=09=09=09ALSA_SURROUND71_CARD
=09=09=09=09ALSA_PCM_CARD
=09=09=09=09ALSA_CARD
=09=09=09]
=09=09=09default {
=09=09=09=09@func refer
=09=09=09=09name defaults.pcm.surround71.card
=09=09=09}
=09=09}
=09}
=09@args.DEV {
=09=09type integer
=09=09default {
=09=09=09@func igetenv
=09=09=09vars [
=09=09=09=09ALSA_SURROUND71_DEVICE
=09=09=09]
=09=09=09default {
=09=09=09=09@func refer
=09=09=09=09name defaults.pcm.surround71.device
=09=09=09}
=09=09}
=09}
=09@func refer
=09name {
=09=09@func concat
=09=09strings [
=09=09=09"cards."
=09=09=09{
=09=09=09=09@func card_driver
=09=09=09=09card $CARD
=09=09=09}
=09=09=09".pcm.surround71." $DEV ":CARD=3D" $CARD
=09=09]
=09}
}=20


and add this to /usr/share/alsa/conf/alsa.conf

defaults.pcm.surround71.card defaults.pcm.card
defaults.pcm.surround71.device defaults.pcm.device=20

after

defaults.pcm.surround51.card defaults.pcm.card
defaults.pcm.surround51.device defaults.pcm.device=20

and this=20
pcm.surround70 cards.pcm.surround70
pcm.surround71 cards.pcm.surround71=20

after

pcm.surround70 cards.pcm.surround70
pcm.surround71 cards.pcm.surround71=20


and create new file in /usr/share/conf/pcm/ with name side.conf
and put this in it

#
# Hardware output from side speakers
#

pcm.!side {
=09@args [ CARD DEV ]
=09@args.CARD {
=09=09type string
=09=09default {
=09=09=09@func getenv
=09=09=09vars [
=09=09=09=09ALSA_SIDE_CARD
=09=09=09=09ALSA_PCM_CARD
=09=09=09=09ALSA_CARD
=09=09=09]
=09=09=09default {
=09=09=09=09@func refer
=09=09=09=09name defaults.pcm.side.card
=09=09=09}
=09=09}
=09}
=09@args.DEV {
=09=09type integer
=09=09default {
=09=09=09@func igetenv
=09=09=09vars [
=09=09=09=09ALSA_SIDE_DEVICE
=09=09=09]
=09=09=09default {
=09=09=09=09@func refer
=09=09=09=09name defaults.pcm.side.device
=09=09=09}
=09=09}
=09}
=09@func refer
=09name {
=09=09@func concat
=09=09strings [
=09=09=09"cards."
=09=09=09{
=09=09=09=09@func card_driver
=09=09=09=09card $CARD
=09=09=09}
=09=09=09".pcm.side." $DEV ":CARD=3D" $CARD
=09=09]
=09}
}=20


=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REKLA=
MA =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=0ASpolocnost SUN Microsystems uviedla na trh novy server Sun Fire V20z=0Az=
alozeny procesoroch AMD Opteron.=0AViac informacii najdete na : http://www.=
somi.sk/sun/v20z.php=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
