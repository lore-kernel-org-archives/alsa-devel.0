From: Koushik jaikishan <jaykishankrk@yahoo.co.in>
Subject: reading constant length of data from sound card using readi api of alsa
Date: Thu, 5 May 2005 14:34:56 +0100 (BST)
Message-ID: <20050505133456.73351.qmail@web8309.mail.in.yahoo.com>
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

hello all,

i am not able to read constant amount of data from the
sound card i dont know why, it always gives me - 11 as
the returned value for reading 960 bytes of data.

r =3D snd_pcm_readi(handle, buf, 960);

r value will be always -11, i suppose this is a error
value for not getting any data from the sound card.
please give me a suggestion on this. Thank you,

regards,

Koushik P S R



________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, =
4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=3D20
