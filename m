From: "Ivica Bukvic" <ico@fuse.net>
Subject: CS4205 (Dell Inspiron 8200) -- what are the chances of implementing more than one codec for multiple simultaneous hw streams?
Date: Mon, 14 Oct 2002 19:18:04 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000001c273d7$f4e13d00$ac1f830a@ico>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all!

I was just wondering if there is any chance of implementing more than
one codec on the CS4205 (intel8x0 module) soundcard found in laptops, so
that the soundcard can at least do 2 streams at the same time? (my
understanding is that this soundcard supports at least 2 if not more
simultaneous streams)

Recent fixes seem encouraging (no more clicks), yet without this
feature, card still feels a bit useless for any serious
real-time-oriented audio work.

Furthermore, the driver as it is does not permit selection of the
microphone as a recording source (at least not using Kmix/KDE apps --
this may be an OSS compatibility problem). Can someone please shed some
light on this issue as well?

Thank you! Sincerely,

Ivica Ico Bukvic




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
