From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Mon, 14 Apr 2008 19:00:24 +0200
Message-ID: <20080414170022.GH22115@tango.0pointer.de>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id BDFB4244FB
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 19:00:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48010E62.2020404@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 12.04.08 21:32, Rene Herman (rene.herman@keyaccess.nl) wrote:

> 
> On 12-04-08 15:35, Lennart Poettering wrote:
> 
> > On Sat, 12.04.08 12:15, James Courtier-Dutton (James@superbug.co.uk) wrote:
> > 
> > My I thus assume that we can say that for all but the last element in
> > the series 0db means avg input power equals avg output power, and for
> > the last one 0db means max? That would fit on what you are saying but
> > also match my usb speakers, not depending on the existance of a
> > "Master".
> 
> If we add in ISA cards, it's not a very generic assumption at least. For 
> example on my cs4236, "master" is -94,5 to +12 dB with 0dB at "87" in the 
> integer scale.
> 
> It's a "Master Digital Gain" -- not sure what that "digital" implies as it 
> very much seems to be positioend in the post output mixer analog path...

Maybe the driver should add an internal offset to the dB scale, to
guarantee that 0dB is max, instead of just copying the hw specs?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
