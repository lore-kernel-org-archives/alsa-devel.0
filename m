From: Lee Revell <rlrevell@joe-job.com>
Subject: One more cross compile issue: alsa-utils
Date: Tue, 06 Jun 2006 17:46:18 -0400
Message-ID: <1149630378.4072.89.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

OK I have managed to cross compile alsa-lib 1.0.11 but now alsa-utils
complains about not being able to find the alsa-lib headers.

>From alsa-utils/config.log:

Invocation command line was

  $ ./configure --host=ppc-linux
--prefix=/home/rlrevell/cross-compile/usr/local
--includedir=/home/rlrevell/cross-compile/usr/local/include

...

This is where it dies:

configure:5355: checking dependency style of powerpc-440-linux-gnu-gcc
configure:5445: result: gcc3
configure:5475: checking for a BSD-compatible install
configure:5530: result: /usr/bin/install -c
configure:5541: checking whether ln -s works
configure:5545: result: yes
configure:5583: checking for ALSA CFLAGS
configure:5589: result:
configure:5592: checking for ALSA LDFLAGS
configure:5601: result:  -lasound -lm -ldl -lpthread
configure:5605: checking for libasound headers version >= 1.0.9
configure:5673: powerpc-440-linux-gnu-gcc -c -g -O2  conftest.c >&5
conftest.c:15:28: alsa/asoundlib.h: No such file or directory
conftest.c:36:9: #error not present
conftest.c:47:10: #error not present
configure:5679: $? = 1
configure: failed program was:

But, /home/rlrevell/cross-compile/usr/local/include/alsa/asoundlib.h
exists!!!  Why does ./configure insist that it does not?

Lee
