From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 09:28:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E5491AB.380AD286@libero.it>
References: <Pine.LNX.4.44.0302191931340.1224-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jaroslaw Sobierski <fycio@gucio.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Wed, 19 Feb 2003, Abramo Bagnara wrote:
> 
> > The results are amazing and I'd say Jaroslav has done some mistakes in
> > his handmade asm.
> 
> I don't think so. It seems that my brain still remembers assembler ;-)

I've no doubts about that ;-)

> You passed wrong values to my code so it did unaligned accesses.

I guessed that but I was too lazy to deeply analyze your asm.

> Fixes to make things same:

>                 volatile s32 *sum,
> -               unsigned int dst_step, unsigned int src_step)
> +               unsigned int dst_step,
> +               unsigned int src_step,
> +               unsigned int sum_step)

sum_step is useless I've deliberately removed it.
Please do it also on your code.

> +               ((char *)dst) += dst_step;
> +               ((char *)src) += src_step;

IMHO it's a sane assumption suppose that step is multiple of sample
size.
However this should not have any impact on efficiency (at least I
believe).

> -                       if (unlikely(sample & 0xffff0000))
> +                       if (unlikely(sample & 0x7fff0000))

As Jaroslaw has written this is a mistake and I've verified the right
version has no speed benefits.

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
