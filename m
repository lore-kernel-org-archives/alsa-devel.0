From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Status of ALSA documentation?
Date: Tue, 12 Feb 2002 19:17:31 +0200 (EET)
Message-ID: <Pine.LNX.4.44.0202121854210.32090-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <Pine.GSO.3.96.1020212093858.23743A-100000@yin.interaccess.com>
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

> 	I was wondering about the status of ALSA's API documentation. The
> last time I checked, the ALSA developers were adding doxygen comments to
> the source code. Was that project completed?

Yes and no. Just like code, there's always room for improvement. Anyway,
almost all functions are already documented, see:

http://www.alsa-project.org/alsa-doc/alsa-lib/index.html

It's not a tutorial, but as a reference documentation it really is quite 
good!

The best part of javadoc is that it adds very little overhead. Even if we
had complete documentation for ALSA0.9 available, I don't think the ALSA
team would have resources for maintaining it at the moment. Keeping the
javadoc comments up-to-date on the other hand involves much less work. No
reason to write more documentation if it's known before hand that nobody
has time to maintain it.

This may sound pessimistic, but a fact is that lots of time went to
writing API docs for ALSA 0.3, 0.4 and 0.5. That time could have been
instead spent on working on the code.

I've said this before and I'll say it again; my biggest worry is that ALSA
team will lose their interest because of the huge amount work they are
facing.  In free sw projects people should be able to concentrate on doing
what they love to do. If someone likes to write code, it's best for
everyone involved that he can keep on doing just that. In the end this is
the only way to keep projects going on for long periods of time.

-- 
 http://www.eca.cx
 Audio software for Linux!


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
