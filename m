From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Safe to call snd_pcm_close after failed snd_pcm_open?
Date: Tue, 09 Sep 2003 10:05:56 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opru73f61vq1sf88@mail.broadpark.no>
References: <Pine.LNX.4.44.0309010807230.14319-100000@pnote.perex-int.cz> <3F53D15B.3090507@superbug.demon.co.uk> <Pine.LNX.4.53.0309021232410.29300@pnote.perex-int.cz> <3F548405.80902@superbug.demon.co.uk> <Pine.LNX.4.53.0309041141580.4568@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309041141580.4568@pnote.perex-int.cz>
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

Hi

Is it safe to call snd_pcm_close for a pcm which failed to open (assuming=
=20
the pcm handle is !NULL)? Not that important, but it might simplify my=20
code somewhat.

Regards

Arve Knudsen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
