From: "Philippe De Muyter" <phdm@macqel.be>
Subject: BUG/PATCH alsaconf in 1.0.0pre1
Date: Wed, 19 Nov 2003 13:28:08 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311261759.hAQHxeo29672@mail.macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

Here are two small unrelated fixes to alsaconf.in :

First, a big one : alsaconf does not work for any legacy soundchip,
because of a typo when checking that the driver modules are really
loaded.

Second, for the digital celebris pc's, the cs4236b chip has its control port
located at 0xf00.  That's currently not in the list of the tested cport's.

Could you apply that to the main source tree ?

Thanks in advance

Philippe

Philippe De Muyter  phdm at macqel dot be  Tel +32 27029044
Macq Electronique SA  rue de l'Aeronef 2  B-1140 Bruxelles  Fax +32 27029077

2003-11-19  Philippe De Muyter  <phdm@macqel.be>

	* alsaconf.in (ac_try_load, ac_try_capture) : Removed erroneous
	space between `snd[-_]' and $1 in grep search expression.
	(ac_try_card_cs4236) : Test also `0xf00' for `cport'.

--- alsaconf.in	2003-11-17 19:32:52.000000000 +0100
+++ alsaconf.in	2003-11-19 10:50:05.000000000 +0100
@@ -677,7 +677,7 @@ check_irq_avail () {
 ac_try_load () {
     test $do_logging = 1 && echo "$1 ${*:2}" >> $LOGFILE
     /sbin/modprobe snd-$1 ${*:2} >/dev/null 2>&1
-    $lsmod | grep -E '(snd-|snd_)' $1 >/dev/null 2>&1 || return 1
+    $lsmod | grep -E '(snd-|snd_)'$1 >/dev/null 2>&1 || return 1
 
     # mute mixers
     amixer set Master 0% mute >/dev/null 2>&1
@@ -711,7 +711,7 @@ ac_try_load () {
 ac_try_capture () {
     test $do_logging = 1 && echo "$1 ${*:2}" >> $LOGFILE
     /sbin/modprobe snd-$1 ${*:3} >/dev/null 2>&1
-    $lsmod | grep -E '(snd-|snd_)' $1 >/dev/null 2>&1 || return 1
+    $lsmod | grep -E '(snd-|snd_)'$1 >/dev/null 2>&1 || return 1
 
     # mute mixers
     amixer set Master 0% mute >/dev/null 2>&1
@@ -913,7 +913,7 @@ ac_try_card_cs4236 () {
     card=cs4236
     irq_list=`check_irq_avail 5 7 9 11 12 15`
     isapnp=`ac_check_option $card ${mpfx}isapnp 0`
-    for cport in 0x538 0x210; do
+    for cport in 0x538 0x210 0xf00; do
 	for port in 0x530 0x534; do
 	    opts="${mpfx}port=$port ${mpfx}cport=$cport $isapnp"
 	    ac_try_dmas $card "$opts" $irq_list && return 0



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
