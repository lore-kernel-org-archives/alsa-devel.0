From: Lars Hamren <hamren@sdu.se>
Subject: BUG REPORT: Not all configure scripts honour --with-alsa-inc-prefix=/path/to/includes
Date: Thu, 20 Mar 2003 17:54:19 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15993.62011.418259.236234@maxi.int.sdu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
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

The following configure scripts generates makefiles that disregards
`--with-alsa-inc-prefix=3D/path/to/includes':

    alsa-tools-0.9.0rc7/ac3dec/configure
    alsa-tools-0.9.0rc7/sb16_csp/configure
    alsa-tools-0.9.0rc7/seq/sbiload/configure

The variable `ALSA_CFLAGS' gets set corectly in the Makefile, but is
not used in the compile command line.

Regards
/Lars
-------------------------------------------------------------------
Lars Hamr=E9n              Tel...: +46(46)189090
Svensk Datorutveckling   e-post: hamren@sdu.se
Vadm=F6llan 211            WWW...: www.sdu.se
S-225 94 Lund
Sweden


-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
