From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: [PATCH] Tascam US-224/428 MMC Implementation
Date: Sun, 1 Aug 2004 21:15:04 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32820.192.168.1.8.1091391304.squirrel@192.168.1.8>
References: <32814.192.168.1.8.1091390483.squirrel@192.168.1.8>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040801211504_62983"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <32814.192.168.1.8.1091390483.squirrel@192.168.1.8>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>, martin-langer@gmx.de, ws@seh.de, Paul Davis <paul@linuxaudiosystems.com>, ardour-dev <ardour-dev@lists.ardour.org>
List-Id: alsa-devel@alsa-project.org

------=_20040801211504_62983
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Hi everybody,

This is my latest patch against the alsa-tools tree (as of todays CVS
HEAD), regarding the us428control MMC implementation as for the Tascam
US-224/428 audio/midi USB control surfaces:

    us428control now bumps to version 0.4.4.

Interesting points are: jog wheel dialing is now alternating between
spitting out some MMC-Step or MMC-Shuttle messages, depending on transport
state, instead of those MMC-Locate(s) which was an early implementation
mistake of mine.

Controlling ardour with (my) US-224 is getting much more fun now :)

However, there's still some little annoyances due to my lack of advice
regarding ardour's Play/Record control behaviour:

1) Ardour doesn't seem to send out MMC-Play messages when one starts
transport within it (e.g. by clicking the playback button widget).

2) Ardour doesn't seem to react against MMC-RecordPause, which I assume
(probably erroneously) it would be equivalent to clicking on its record
widget button.

3) Sending a MMC-RecordStrobe message to ardour has the strange effect to
start playback while toggling recording off instantaneously.

AFAICT these issues seems to be specific to ardour (0.9beta18.4), not to
us428control which is just sending out the proper MMC messages. Or that I
think.

I would like to settle all this before I'm going off on holidays. Hope
it's welcome and on time for the imminent alsa dot-6 release :)

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


------=_20040801211504_62983
Content-Type: application/x-gzip; name="us428control-0.4.4.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="us428control-0.4.4.patch.gz"

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
------=_20040801211504_62983--




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
