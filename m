From: Chris Rankin <rankincj@yahoo.com>
Subject: Audigy2 Microphone capture: alsa-driver-1.0.9rc1 works, alsa-driver-1.0.9rc2 doesn't
Date: Wed, 30 Mar 2005 22:30:09 +0100 (BST)
Message-ID: <20050330213009.41195.qmail@web52901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

I've just compared the results with the alsa-driver-1.0.9rc1 and alsa-dri=
ver-1.0.9rc2 tarballs
with my Audigy2 sound card.

The summary: I can record via the microphone with rc1, but can't with rc2=
.

The command I'm using is:

$ arecord -d10 -f cd -t wav > test.wav

Cheers,
Chris


Send instant messages to your online friends http://uk.messenger.yahoo.co=
m=20


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
