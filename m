From: Peter Zubaj <pzad@pobox.sk>
Subject: Mixer API
Date: Tue, 3 Aug 2004 10:20:36 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200408030820.i738Ka4k016237@www7.pobox.sk>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I have question:
What is prefered mixer api for ALSA ?

There are 2 of them:
1) ctl (snd_ctl_* and snd_hctl_*)interface - directly maped to driver
2) mixer (snd_mixer_*) interface - build above ctl interface

For me looks like mixer interface is there only for compatibility
reasons with OSS and has two functions:
1) combine "X Playback Volume", "X Playback Switch", "X Capture
Volume", "X Capture Switch" to one "X" element (in alsa mixer showed
as two elements)
2) emulate "Capture Source" for AC97 based soundcards to "Capture
Switch-es".

I think, that ctl interface is better for mixer app (little more
complicated, but better).

I ask becase I start hate "Capture Source" emulated with "Capture
Switch-es" (average Audigy user problem - I can't set capture source).
And most of mixer GUI app have problems with alsa mixer api (KMix -
used in kde is broken for ALSA).
And I start to think implement new qt (kde) based mixer (based on ctl
interface).

Peter Zubaj



=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
