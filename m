From: "Arcady Genkin" <agenkin@thpoon.com>
Subject: Files missing from src/conf/cards in alsa-lib-0.9.7?
Date: 27 Sep 2003 11:49:20 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <uosmmiqlj3.fsf@bashful.cdf.toronto.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Compilation of alsa-lib-0.9.7 breaks for me with the following
error message:

Making all in conf
make[2]: Entering directory
`/var/tmp/portage/alsa-lib-0.9.7/work/alsa-lib-0.9.7/src/conf'
Making all in cards
make[3]: Entering directory
`/var/tmp/portage/alsa-lib-0.9.7/work/alsa-lib-0.9.7/src/conf/cards'
make[3]: *** No rule to make target `SI7018/sndoc-mixer.alisp', needed
by `all-am'.  Stop.

It appears that nothing is shipped in src/conf/cards in the 0.9.7
tarball of the alsa-lib module.
-- 
Arcady Genkin

guilt is the cause of more disauders
than history's most obscene marorders (E.E. Cummings)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
