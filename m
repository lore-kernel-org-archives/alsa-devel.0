From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: help needed on how to autoload snd-usb-midi
Date: Tue, 15 Oct 2002 16:40:56 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021015144056.40474.qmail@web12202.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>
Cc: Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

I am in the process of updating the tascam us-428
patch for alsa-current and need some hints:
formerly the snd-usb-us428 issued 
"request_module( "snd-usb-midi");"
to load that module. this doesn't work with
alsa-current anymore as the snd-usb-audio
initialisation, which is triggered, conflicts with the
initialisation of snd-usb-us428.
thus I deleted that "request_module( "snd-usb-midi");"
from snd_usb_us428.
I remember from some Mail on this list, that
snd-usb-midi  would be autoloaded if a users process
accesses a mididevice, which has been created by 
"snd_seq_device_new( ...SNDRV_SEQ_DEV_ID_USBMIDI)".
this does not happen here now.
what do I miss?
for the tests I use the bristolsynth with
"./startBristol -alsa -audiodev hw:1 -mididev hw:1"
having issued "modprobe snd-usb-midi" before,
everythingg works as expected. otherwise 
"Could not open the MIDI interface.
Error opening midi device hw:1, exiting midi thread"

TIA, Karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Möchten Sie mit einem Gruß antworten? http://grusskarten.yahoo.de


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
