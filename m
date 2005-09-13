From: Tom Watson <sdc695@yahoo.com>
Subject: Simple suggestion for a make target
Date: Tue, 13 Sep 2005 12:24:22 -0700 (PDT)
Message-ID: <20050913192422.73152.qmail@web60825.mail.yahoo.com>
References: <20050913175247.9B2BD895B2@sc8-sf-spam1.sourceforge.net>
Reply-To: tsw@johana.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050913175247.9B2BD895B2@sc8-sf-spam1.sourceforge.net>
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

Since it appears that frequently the kernel source has older versions of =
alsa
when released, wouldn't it be wise to have a target in the alsa-driver-xx=
.yy.z
directory that finds the kernel sources, and updates them.  Then one coul=
d
re-compile the kernel and all would be well with the world.

For those who don't wish to do this, the "./configure;make;make install"
sequence would work as well.

I suspect that the kernel configuration would pass thru, so one wouldn't =
need
to configure before "transferring" sources, but not being an expert, I do=
n't
know.

Maybe this would encourage distrubutions that diddle with the kernel sour=
ce to
have an up-to-date alsa.

Just an idea.


--=20
Tom Watson
tsw@johana.com

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server.=20
Download it for free - -and be entered to win a 42" plasma tv or your ver=
y
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
