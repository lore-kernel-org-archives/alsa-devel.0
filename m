From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: 4/6-channel output on CMI8738
Date: 03 Jun 2003 12:45:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xk7c3l9rg.fsf@zaphod.guide>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I'm trying to get 4/6-channel playback to work with a CMI8738 chip.
It's behaving a little oddly, however.

First I have to switch off "Four Channel Mode", which I guess is
normal.  With that switch off, I can play 4 channels on hw:0,1 or
surround40.  The problem is that the front output is replicated on the
rear jack.  This is cured by turning on "Exchange DAC".  The "PCM"
volume control also works in this mode, but the "Master" control only
affects front output.  Anyhow, 4-channel playback is pretty much OK.

Next I try 6-channel playback.  With the same settings it works,
except that the volume control doesn't affect channels 5 and 6.  With
"Exchange DAC" off, the front output is silent, but channels 1 and 2
are sent to the rear instead.

All this would be acceptable if it wasn't for some quirks.  Sometimes,
the right rear output goes to maximum volume, with no apparent reason,
and a few times the output has suddenly stopped completely.  This has
happened while playing with the mixer settings.  Stopping and
restarting the playback program helps.

Finally, the surround51 device behaves like a duplicate of hw:0,0.

Am I doing something wrong, or is the driver just not perfect?

Here's my /proc/asound/cards:
0 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                     C-Media PCI CMI8738-MC6 (model 55) at 0x8800, irq 24

and /proc/asound/version:
Advanced Linux Sound Architecture Driver Version 0.9.2.
Compiled on Mar 31 2003 for kernel 2.4.21-pre5.

Maybe I should upgrade, but I haven't noticed any changes to the
cmipci driver that seem related to the problems.

-- 
Måns Rullgård
mru@users.sf.net



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
