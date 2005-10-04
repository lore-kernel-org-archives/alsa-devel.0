From: Tom Watson <sdc695@yahoo.com>
Subject: Rates for the Revolution 7.1 card (ICE1724 chip)
Date: Tue, 4 Oct 2005 15:18:36 -0700 (PDT)
Message-ID: <20051004221836.10161.qmail@web60820.mail.yahoo.com>
Reply-To: tsw@johana.com
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
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In my musings, I have found that the M-Audio Revolution 7.1 card seems to=
 only
support the following rates:
32000, 44100, 48000, 64000, 88200, 96000, 176400, and 19200.
These rates are from a small program I wrote using the
"snd_pcm_hw_params_test_rate" routine, iterating by one from 1 to 192000.
This is in contrast to the mixer control "Multi Track Internal Clock" (as
shown on 'alsamixer' that indicates the following additional rates:
8000, 9600, 11025, 12000, 16000, 22050, and 24000.

What could be the reason for this mismatch?  Shouldn't they be the same?
Is this a bug?

--=20
Tom Watson
tsw@johana.com


	=09
__________________________________=20
Yahoo! Mail - PC Magazine Editors' Choice 2005=20
http://mail.yahoo.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
