From: p z oooo <pzad@pobox.sk>
Subject: audigy2 strange behaviour
Date: Fri, 28 Mar 2003 14:40:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303281340.OAA13096@www4.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
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
Cc: alsa@slackware.ru
List-Id: alsa-devel@alsa-project.org

Try this:
Find in file
alsa-driver/alsa-kernel/pci/emu10k1/emufx.c
this

/* analog speakers */
=09//A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R,=20
playback + SND_EMU10K1_PLAYBACK_CHANNELS);
=09A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R,=20
playback + SND_EMU10K1_PLAYBACK_CHANNELS);=20

------------------------
and change to
------------------------

/* analog speakers */
=09A_PUT_STEREO_OUTPUT(A_EXTOUT_AFRONT_L, A_EXTOUT_AFRONT_R,=20
playback + SND_EMU10K1_PLAYBACK_CHANNELS);
=09//A_PUT_STEREO_OUTPUT(A_EXTOUT_AC97_L, A_EXTOUT_AC97_R,=20
playback + SND_EMU10K1_PLAYBACK_CHANNELS);=20

Peter Zubaj



=0A____________________________________=0Ahttp://www.pobox.sk/ - najvacsi s=
lovensky freemail=0A=0A=0A


-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
