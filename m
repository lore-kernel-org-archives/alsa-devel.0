From: vollmer.philipp@t-online.de (Philipp Vollmer)
Subject: Re: Newbie compile problem
Date: Fri, 4 Oct 2002 18:43:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210041843.01407.vollmer.philipp@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: hfyan0@ie.cuhk.edu.hk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

your mistake seems to be easy to eleminate:

I suppose, you compile with cc -o xxx xxx.c or something like this.
You'd better try out gcc -o xxx xxx.c -lasound for compiling that.
The -lasound  includes the library depending on the headerfile.
Without the static library you won't run any application and the
headerfile only give declarations.

73 Phil


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
