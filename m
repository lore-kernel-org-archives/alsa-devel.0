From: joy ping <joy@pingfm.org>
Subject: asoundrc-howto
Date: Wed, 20 Mar 2002 12:44:53 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a79t23$bj3$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-user@alsa-project.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi,

cause i didnt found any sufficent documentation again i started to wrote a
kind of asoundrc-minihowto. my plan is to put it on the alsa-wiki-page,
but i dont know where the (un)offical alsa-wiki-page is, its not linked
on alsa-project.org. otherwise i will put it 'statically' somwhere on the
web.
there are still some questions open, maybe someone knows this:

what are hooks in detail? what are they good for??

how does ttable work in detail ??

all descriptions (in human readable form) to other pcm_types are welcome!

in the distributed asoundrc.txt is an example of how to define pcm_meter,
but i didn't found any docs about the meter module in
alsa-lib-documentation, also liblevel.so is not in the main package, why?

are there some other scopes around, i find this a very usefull feature of
alsa.

this belongs not to asoundrc but it bothers me a bit while installing the
drivers. INSTALL in the drivers package states:

The ALSA driver uses soundcore multiplexer for 2.2+ kernels and OSS
compatible devices. You should add line like 'alias char-major-14
soundcore'.

but i didnt found this soundcore module and kernel gives me errors, after
deleting this from modules.conf everything runs fine, even the OSS
emulation. is it still true for 2.4.X kernels??

______
joy


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
