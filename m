From: Lee Revell <rlrevell@joe-job.com>
Subject: Cross compile bug?
Date: Tue, 06 Jun 2006 16:46:01 -0400
Message-ID: <1149626761.4072.65.camel@mindpipe>
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

I'm on an x86 machine trying to cross compile alsa-lib for PPC440 and it
insists on installing to /usr/lib.

My build script looks like:

echo " Building and installing alsa-lib (~1min)"
cd packages/alsa-lib-1.0.11
CC="$CROSS_COMPILE"gcc ./configure --host=ppc-linux
make -s
make -s prefix=$1/usr/local install 
        ^^^^^^^^^^^^^^^^^^^
make -s distclean

However, libasound is installed to /usr/lib.

Why is prefix being ignored?  What is the correct way to cross compile
alsa-lib?

Lee
