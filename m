From: Frank Barknecht <barknech@ph-cip.uni-koeln.de>
Subject: Re: seq24 - midi sequencer released
Date: Sun, 14 Jul 2002 13:40:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020714114006.GA5680@fliwatut.scifi>
References: <E17TSLJ-0000Y3-00@usw-sf-list2.sourceforge.net> <20020713211622.GA23209@filter24.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020713211622.GA23209@filter24.mshome.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
rob buse hat gesagt: // rob buse wrote:

> I just GPL'd my seq24 midi sequencer.  
> http://www.filter24.org/seq24/index.html
> 
> Uses ALSA 0.9.0 and GTKmm.
> 
> I hope someone else finds it useful :)	

I'm having a problem compiling it, because I get this error:

sequence.C: In method `sequence::sequence()':
sequence.C:47: `PTHREAD_MUTEX_RECURSIVE' undeclared (first use this function)
sequence.C:47: (Each undeclared identifier is reported only once
sequence.C:47: for each function it appears in.)
sequence.C:47: implicit declaration of function `int pthread_mutexattr_settype(...)'
make[1]: *** [sequence.o] Error 1

I tried to add
#include <pthread.h>
to sequence.C, but that didn't help. Do you have any idea, where the
error might come from? 

ciao,
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
