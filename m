From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: CodingStyle
Date: Tue, 05 Sep 2006 18:40:27 +0200
Message-ID: <44FDA87B.5030902@s5r6.in-berlin.de>
References: <20060831123706.GC3923@elf.ucw.cz> <s5h8xl52h52.wl%tiwai@suse.de>
	<20060831110436.995bdf93.rdunlap@xenotime.net>
	<20060902231509.GC13031@elf.ucw.cz>
	<20060902213046.dd9bf569.rdunlap@xenotime.net>
	<20060905080813.GE1958@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from hp3.statik.tu-cottbus.de (hp3.statik.TU-Cottbus.De
	[141.43.120.68])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E0CDB269
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Sep 2006 18:44:39 +0200 (MEST)
In-Reply-To: <20060905080813.GE1958@elf.ucw.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, kernel list <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rdunlap@xenotime.net>, pshou@realtek.com.tw, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Pavel Machek wrote:
> +Avoid extra spaces around ! operator, and do not place spaces around (s.

How about:

	Avoid extra spaces after the ! operator.
	Do not place spaces around parentheses.

Because "foo && !bar" is certainly OK.

Or more draconian for the former and less so for the latter rule:

	Do not put whitespace between any of the unary operators and
	their operand.

	It is usually unnecessary to have whitespace around parentheses
	as part of expressions, around brackets, or around the operators
	. and ->.

Rule 1 certainly applies likewise to ++, --, unary +, unary -, !, ~,
(typecast), unary *, unary &, sizeof.

Rule 2 applies to all of ( ), [ ], ., ->, except where line breaks and
indentation warrant whitespace, or where whitespace helps to read
expressions with more levels of braces. Although the latter should be
avoided anyway.
-- 
Stefan Richter
-=====-=-==- =--= --=-=
http://arcgraph.de/sr/

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
