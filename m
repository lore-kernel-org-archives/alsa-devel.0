From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: future ALSA development
Date: Thu, 3 Jul 2003 16:39:36 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307031555370.27053-100000@ecabase.localdomain>
References: <3EF77D90.5080209@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from ecabase.localdomain (cs78235140.pp.htv.fi [62.78.235.140])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA22564
	for <alsa-devel@alsa-project.org>; Thu, 3 Jul 2003 15:44:07 +0200
In-Reply-To: <3EF77D90.5080209@folkwang-hochschule.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Ok, this is a bit late, but hopefully not too late. :)

On Tue, 24 Jun 2003, Joern Nettingsmeier wrote:
>>> other people might propose XML.  then it becomes to a question whether
>> I think that XML is too overkill for our purposes.
> otoh, the embedded guys will probably not like it, but then memory is 
> becoming cheaper by the minute, and its additional size will be a moot 
> point in the very near future.

This is a dangerous argument. While it's that true memory and cpu power
are becoming cheaper and cheaper all the time, minimizing resource usage
is still as important as ever. With big volume products, small things make
a big difference in the overall picture (i.e. which products survive in
the market). Saving an extra 100kB can make a huge difference if it allows
you to use a smaller flash chip on your device.

This doesn't mean ALSA should not take advantage of any additional
libraries, but these additions should not create new dependendencies to
the core system. In other words you should be able to build a compact
version of ALSA user-space libs and tools, and one that is cross-compiler
friendly. Otherwise people will be tempted to use OSS or write their own
drivers.

Already alsa-lib has some features that are not so good from embedded 
perspective:

- not a small lib; with default settings around 0.5MB; this 
  is an extra 0.5MB compared to just using OSS where there is no lib
- use of more advanced c-lib features such as dynamic loading (dlopen(), 
  etc); these can cause problems if you try to use libasound with other
  c-libs than glibc

... but, but, of course libasound also provides lots of great
functionality, so it's still a good alternative. And also, app developers
can always manually scale down the libasound build, or even write their
apps to directly communicate with ALSA's kernel interface. But if using
ALSA becomes too difficult, embedded-linux community will default to OSS
and/or custom solutions, which I think is a bad thing... (at least I'd
like to run ALSA apps on Linux PDAs and who-knows-what other gadgets that
might be released in the future).

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
