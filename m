From: p z oooo <pzad@pobox.sk>
Subject: ALC650 rev D. - SPDIF out
Date: Fri, 3 Oct 2003 08:33:19 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200310030633.IAA13612@www1.pobox.sk>
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
List-Id: alsa-devel@alsa-project.org

Hi,

I have ALC650 rev. D and spdif is not working with 0.9.7.

Please delete this row from ac97_patch.c from function patch_alc650

ac97->ext_id &=3D ~AC97_EI_SPDIF; /* disable extended-id */=20

I think, that all ALC650 have spdif out and rev. E and later have=20
spdif in.

Peter Zubaj

=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
