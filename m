From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: Re: dmix plugin
Date: Thu, 20 Feb 2003 00:30:30 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045729830.3e549226bab91@webmail.namezero.com>
References: <Pine.LNX.4.44.0302191931340.1224-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302191931340.1224-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Abramo Bagnara <abramo.bagnara@libero.it>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Quoting Jaroslav Kysela <perex@suse.cz>:

> I don't think so. It seems that my brain still remembers assembler ;-)
...
>  			sample = *sum;
>  			s16 s;
> -			if (unlikely(sample & 0xffff0000))
> +			if (unlikely(sample & 0x7fff0000))
>  				s = sample > 0 ? 0x7fff : -0x8000;
>  			else
>  				s = sample;

I think I remember some of the x86 assembly myself and this correction
does not fix the problem. This code will still "saturate" all negative
samples to -8000. You cannot detect an overflow into the upper half of
the register with a simple bitwise and. The actual test should be as
follows : 
- extend the sign of the lower half
- check if the upper half is the same as the effect of expansion
 if it is - there is no overflow
 if it differs - there was overflow and you need to saturate.
examples : 
value 0x 0000 0335
ext   0x 0000 0335
  -> no overflow

value 0x 0002 43b1
ext   0x 0000 43b1
  -> overflow

value 0x ffff f25b
ext   0x ffff f25b
  -> no overflow

value 0x ff1c 35c9
ext   0x 0000 35c9
  -> overflow

to put it in asm:

mov ebx,eax
cwde
cmp eax,ebx

The problem is cwde operates only on ax/eax.
This may sound complicated but in fact it amounts to a very simple
question : does the sample fit in a 16 bit int, or does it not, so
I guess in C it could look something like :

    s16 s=sample;
    if (unlikely(sample != (s32)s))

The cast is just there for clarity I believe it would be done
implicitly anyway. But don't take my word for it - I did not
test this.

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
