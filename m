From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: PCM hw mixing with volume
Date: Wed, 10 Mar 2004 10:46:21 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040310104621.pochini@shiny.it>
References: <1078853140.18057.165.camel@renegade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078853140.18057.165.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 09-Mar-2004 Ove Kaaven wrote:

> Independently? No, our software mixing code resamples, adjusts volume,
> and mixes the stream into the buffer in one step.

It should be more efficient than separate passes. It minimizes
memory i/o and some operation (multiply-add == volume-mix) can
be done natively in the vector unit.


> Since we're ranting anyway: It's a similar situation with 3D graphics
> hardware, where the 3D cards get ever more powerful, even though the CPU
> power is going up. [...]

No need to enter the philosophycal battlefield. The fact it there is
no ALSA support for this yet. Thus, you can just await for it, or use
another mixer library, or help ALSA developers to write it.
Please start writing what the API should provide. My experience about
game development is quite obsolete and I can't help much, but you
should have a better idea about how the API should look like or, at
least, what minimal/preferred/dreamed features it should have.


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
