From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: hdsploader causes Ooops in kernel 2.6.8.1 and
	AMD64
Date: Wed, 15 Sep 2004 00:23:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095222189.2406.136.camel@krustophenia.net>
References: <200409150329.i8F3TtR4028133@sanctuary.aproximation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409150329.i8F3TtR4028133@sanctuary.aproximation.org>
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

On Tue, 2004-09-14 at 23:29, thewade wrote:
> Ive made no success on solving my kernel Oops/hdsploader problem. Ive
> posted a bug in the kernel bugzilla (http://bugzilla.kernel.org/show_bug.cgi?id=3388).
> 
> Is there any value to using an earlier kernel release (like 2.6.4 which
> works on my other pIII laptop)? 
> 

Absolutely.  If it works with a previous kernel, we can narrow down the
search to the things that changed between those releases.

> I imagine that an earlier release would have the same x86-64 bug though,
> right?
> 

Only one way to find out...

> Is there eom way to dtermine if it was a kernel problem or a hdsploader
> problem?
> 

Anytime you get an Oops it is by definition a kernel problem.

> Should I post a bug in the alsa bugtracker?
> 

Yes.  People are not blowing you off, it's just that there aren't many
ALSA developers, and even fewer that have the same hardware.  I am sure
you will get a response soon.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: thawte's Crypto Challenge Vl
Crack the code and win a Sony DCRHC40 MiniDV Digital Handycam
Camcorder. More prizes in the weekly Lunch Hour Challenge.
Sign up NOW http://ad.doubleclick.net/clk;10740251;10262165;m
