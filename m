From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: seq24 - midi sequencer released
Date: Sun, 14 Jul 2002 17:50:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207141750.28331.plcl@telefonica.net>
References: <E17TSLJ-0000Y3-00@usw-sf-list2.sourceforge.net> <20020713211622.GA23209@filter24.mshome.net> <20020714114006.GA5680@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020714114006.GA5680@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Frank Barknecht <barknech@ph-cip.uni-koeln.de>
Cc: rob buse <rcbuse@filter24.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

El Dom 14 Jul 2002 13:40, Frank Barknecht escribió:
> rob buse hat gesagt: // rob buse wrote:
> > I just GPL'd my seq24 midi sequencer.
> > http://www.filter24.org/seq24/index.html
> >
> I'm having a problem compiling it, because I get this error:
>
> sequence.C: In method `sequence::sequence()':
> sequence.C:47: `PTHREAD_MUTEX_RECURSIVE' undeclared (first use this
> function) sequence.C:47: (Each undeclared identifier is reported only once
> sequence.C:47: for each function it appears in.)
> sequence.C:47: implicit declaration of function `int
> pthread_mutexattr_settype(...)' make[1]: *** [sequence.o] Error 1
>
> I tried to add
> #include <pthread.h>
> to sequence.C, but that didn't help. Do you have any idea, where the
> error might come from?

Same results for me. After some googling, I've found that adding the flag 
-D_GNU_SOURCE at src/Makefile.am and reconfiguring I could compile it. This 
is the line I have changed:

CXXFLAGS = @CXXFLAGS@ $(GTKMM_CFLAGS) -Wall -D_GNU_SOURCE

Pedro


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
