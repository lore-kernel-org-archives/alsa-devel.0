From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hdsploader causes Ooops in kernel 2.6.8.1 and
	AMD64
Date: Fri, 10 Sep 2004 22:32:10 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094869930.1306.3.camel@krustophenia.net>
References: <200409110151.i8B1pDfb003976@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409110151.i8B1pDfb003976@sanctuary.aproximation.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: thewade <pdman@aproximation.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2004-09-10 at 21:51, thewade wrote:
> Hello,
> 
> Im trying to solve my own problem, which is getting the hammerfall to 
> work on my AMD64 laptop running Fedora Core 3 test 1 and the standard 
> kernel 2.6.8.1.
> 
> On boot I get Found hammerfall dsp: no multiface or digiface connected: 
> waiting for firmware even when the multiface is connected.

Are you sure Linux sees the hammerfall (1394 support enabld, etc)?  What
does dmesg say about it?

The Oops is certainly a bug and should be fixed.

Lee






-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
