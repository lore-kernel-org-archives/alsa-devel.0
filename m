From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Status of ALSA documentation?
Date: Tue, 12 Feb 2002 21:33:47 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202122058120.32090-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.GSO.3.96.1020212122334.26439A-100000@yin.interaccess.com>
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

On Tue, 12 Feb 2002, Kevin Conder wrote:

>>> last time I checked, the ALSA developers were adding doxygen comments to
>>> the source code.
>> The best part of javadoc is that it adds very little overhead.
> 	I'm confused. Is the ALSA project using javadoc or doxygen?

Good point. Javadoc is both a tool for extracting documentation (html)
from Java code and a name for referring to the style of documenting (ie.
putting documentation in the source code files). There are many tools for
extracting javadoc-style documentations. Javadoc and doxygen are two
well-known tools, but I've also used at least kdoc and scandoc. There are
probably quite a few others available. Doxygen has been my personal 
favorite for a while now (for C, C++ and Java).

>> This may sound pessimistic, but a fact is that lots of time went to
>> writing API docs for ALSA 0.3, 0.4 and 0.5. That time could have been
>> instead spent on working on the code.
> 	Are you implying that writing documentation is a waste of time?

No, no. I just think a short but up-to-date reference manual is a lot
better than huge amounts of unmaintained documentation. I've used this
minimal approach in ecasound and it has worked really well. There's quite
a lot of documentation available (and all of up-to-date!), but not too
much for me to maintain (= I can spend most of my time on fixing bugs,
implementing new features and improving old ones; things that I really
like to do).

For instance, let's say the following documents would exist:
	- javadoc comments stored in CVS
	- online implementation docs generated from 
	  the javadocs
	- reference manuals for alsa-kernel and alsa-lib APIs;
	  possibly SGML stored in CVS
	- web-version of the manuals at www.alsa-project.org;
	  generated from SGML-files
	- tutorial for writing ALSA apps; web site

If you now add a new feature, you might need to update all the above. If
you redesign some part of the system, you will have to rewrite the
related chapters. In any case you have to remember what is documented
where so you know when you need to update something.

And just to make sure, these comments are aimed at ALSA as a free software
project. In commercial software development the situation is completely
different. There developers are expected to document their work and they
get money from doing it.

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
