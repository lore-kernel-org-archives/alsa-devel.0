From: "Thibault LE MEUR" <Thibault.LeMeur@supelec.fr>
Subject: Patch usb-audio: I need guidelines
Date: Tue, 21 Feb 2006 18:10:34 +0100
Message-ID: <012201c63709$bcfd0650$a578e4a0@supelec.fr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from laposte.supelec.fr (laposte.supelec.fr [160.228.120.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 88F8318D
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 18:10:48 +0100 (MET)
Received: from lemeurnx (lemeur-nx.supelec.fr [160.228.120.165])
	by laposte.supelec.fr (8.13.1/8.13.1) with ESMTP id k1LHAbX0031329
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 18:10:47 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Alsa-Gurus,

I've found how to patch the snd-usb-audio driver in order to get the
Audiophile_USB analog capture to work. This device uses different
synchronization methods whether the the SPDIF input is connected or not.

This information should be given by the user at driver-loading-time and =
thus
I need a new init parameter for the snd-usb-audio module: I know that =
this
could be a blocking point, but please read below in order to see how I =
try
to make this patch "non-intrusive".

I've already designed an ugly patch that is working but I'd like to make =
it
clean before publishing it. Could you please give me comments and/or =
advice
on the following description ?

This is how I think things _could_ be done:
* add a new parameter called "device_setup" (integer)
  - this parameter uses a generic name, so that it could be used by any
subsequent devices (well..., only if needed of course)
  - the parameter bits signification depends on the USB_ID for the =
device

* if this parameter is not given, the =
_default_value_0x00_does_nothing_new_
(returns to previous behaviour)
  - This will ensure that no setup modification is needed for current =
happy
Audiophile_USB users ;-)

* use constants to name each significant bit of this parameter
  - "#defines" could go to "usbquirks.h" (for instance "#define
AUDIOPHILE_SET_DIGITAL_INPUT 0x04"). Or is there a better include file?
  - Are they any naming convention for these device specific constants?

* I am currently only using the least significant 8bits of the "int" =
value,
do you think an 'int' is enough to cover _would-be_ future needs? (I =
know
that this question seems stupid since no one but me has asked for such a
parameter ;-) but anyway I think it is worth asking)

* for Audiophile_USB, I need to patch "parse-audio-endpoints":
  - I have seen a "case USB_ID" section with existing quirks and would
integrate my patch in the already existing Audiophile_USB subsection

Is everything described above sounds good?

Thanks in advance for your comments,

Regards,
Thibault




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
