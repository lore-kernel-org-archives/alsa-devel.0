From: p z oooo <pzad@pobox.sk>
Subject: RE: Detecting ALSA OSS emulation
Date: Mon, 8 Dec 2003 13:15:18 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312081215.hB8CFI1b011127@www7.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
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
To: g_sf@zewt.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Probably user has normal soundcard handled by ALSA and TV card=20
(btaudio or saa7134) which provides only OSS drivers (warning - only=20
recording - not playback). TV card is default /dev/dsp (can by=20
changed by module option for btaudio, saa7134). For BT87x users there=20
is alsa driver in ALSA 1.0.0rc2 for saa7134 not.

Peter Zubaj


=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
