From: "Brian Welch" <Brian-Welch@cox.net>
Subject: Re: Installing a "different" version of Alsa
Date: Sun, 20 Dec 2009 23:34:03 -0700
Message-ID: <69F4A42643E24687BFFD4D3D0F485DEA@brianoffice>
References: <mailman.3791.1261331960.2074.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao102.cox.net (fed1rmmtao102.cox.net [68.230.241.44])
	by alsa0.perex.cz (Postfix) with ESMTP id 466AE103821
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 07:34:10 +0100 (CET)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao102.cox.net
	(InterMail vM.8.00.01.00 201-2244-105-20090324) with ESMTP
	id <20091221063407.WZVZ8308.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2009 01:34:07 -0500
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Message: 1
Date: Sun, 20 Dec 2009 12:47:28 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] Installing a "different" version of Alsa
To: Brian Welch <Brian-Welch@cox.net>
Cc: alsa-devel@alsa-project.org
Message-ID: <20091220124727.GA2881@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii

On Sat, Dec 19, 2009 at 09:48:16PM -0700, Brian Welch wrote:

>> When I use kbuild to build my custom sound hardware driver against the 
>> SDK
>> in the kernel, it always trys to pick up the older ALSA header files that 
>> are in the
>> SDK, but I want to use the newer versions that are in the directory with 
>> the newer
>> version of ALSA.  What the best way to make sure I get the correct 
>> headers?
>> Is what I'm trying "dangerous" and should I be going about this a 
>> different way?

> The best way of integrating with the toolchain you're using will usually
> depend on the toolchain - you'll generally be able to get better advice
> about how to work with the toolchain by asking people who work with the
> toolchain.

I guess I don't understand exactly what you mean by "toolchain."  I've 
already
contacted the people that package up the SDK and they said I should solve it
myself.  I originally hoped that I could just re-build the kernel without 
Alsa
built-in, then add my new version of Alsa, but they claim that causes other
issues (i.e. no sound at all).
