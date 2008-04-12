From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sat, 12 Apr 2008 21:32:50 +0200
Message-ID: <48010E62.2020404@keyaccess.nl>
References: <20080411204610.GA32413@tango.0pointer.de>	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 649ED2441C
	for <alsa-devel@alsa-project.org>;
	Sat, 12 Apr 2008 21:30:07 +0200 (CEST)
In-Reply-To: <20080412133536.GC32491@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12-04-08 15:35, Lennart Poettering wrote:

> On Sat, 12.04.08 12:15, James Courtier-Dutton (James@superbug.co.uk) wrote:
> 
> My I thus assume that we can say that for all but the last element in
> the series 0db means avg input power equals avg output power, and for
> the last one 0db means max? That would fit on what you are saying but
> also match my usb speakers, not depending on the existance of a
> "Master".

If we add in ISA cards, it's not a very generic assumption at least. For 
example on my cs4236, "master" is -94,5 to +12 dB with 0dB at "87" in the 
integer scale.

It's a "Master Digital Gain" -- not sure what that "digital" implies as it 
very much seems to be positioend in the post output mixer analog path...

Rene.
