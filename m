From: "Aaron J. Grier" <agrier@poofygoof.com>
Subject: Re: alsa-lib has anyone ever looked at taking it cross
	platform?
Date: Wed, 30 Jul 2008 12:07:26 -0700
Message-ID: <20080730190726.GT835@arwen.poofy.goof.com>
References: <e7d8f83e0807250351j42894f2dm7f19483f8d66afaa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.poofygoof.com (209-162-215-114.dq1sn.easystreet.com
	[209.162.215.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 25D072438E
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jul 2008 21:07:32 +0200 (CEST)
Received: from arwen.poofy.goof.com (muzgash.poofy.goof.com [10.0.0.26])
	by smtp.poofygoof.com (Postfix) with ESMTP id 997032989
	for <alsa-devel@alsa-project.org>; Wed, 30 Jul 2008 12:07:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e7d8f83e0807250351j42894f2dm7f19483f8d66afaa@mail.gmail.com>
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

On Fri, Jul 25, 2008 at 08:51:13PM +1000, Peter Dolding wrote:
> Now why are not alsa interfaces practical to use.   It is ment to be
> "Advanced Linux Sound Architecture"  The complete Architecture.   Not
> something you have to tack bits onto because its not functional or
> hard to use.  Have we got to the point like xlib where the complete
> alsa-lib has to be reworked for usability.

alsa-lib's weakness from my perspective is the sheer breadth and extent
of its API.  the simplest polled output case for PCM requires a
significant amount of code.  there are a dozen snd_pcm_*() functions
before snd_pcm_writei() can be called.  I can't just open() a device,
ioctl() a struct or two to set sampling and buffer parameters, and start
write()ing data.  

ALSA appears to trade large data structures for large numbers of
function calls.  I assume this is intended to give finer granularity of
error reporting, but it makes programming ALSA very involved, perhaps
unnecessarily.

the recent step of deprecating (and subsequently removing) function
calls to slim down the API is a step in the right direction.

-- 
  Aaron J. Grier | "Not your ordinary poofy goof." | agrier@poofygoof.com
