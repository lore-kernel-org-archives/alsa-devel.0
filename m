From: Paul Davis <pbd@op.net>
Subject: Re: Re: About integer64
Date: Thu, 09 May 2002 09:40:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205091339.g49Dd8907029@post2.fast.net>
References: <3CDA78CE.BE2D0F56@alsa-project.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 09 May 2002 15:25:34 +0200."
             <3CDA78CE.BE2D0F56@alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Not very much:
>a) if 32 bit integer could be enough expressive, what's the problem to
>truncate it in your driver?

if i knew that this was true, i would do so. i don't know that. the
rms meters are the *only* registers on the h-dsp that are 64 bit, so i
assume there is some reason for this.

>b) if a 32 bit integer is not enough and a float is preferrable:
>considered that an ieee754 floating point is in the form (1+man)*2^exp
>what's the problem in converting it in your driver using ffs and some
>shift?

if the lkml crew see us using floating point in any form in the
kernel, we will attract complaints, even if we use integer operations
to do so. i am firmly convinced of this.

>With both way I don't see the two point you make:
>1) why bother with signed vs unsigned

for purity abramo! for purity!

>2) why use 64 bit integer
>
>Of course if a 64 bit integer is the best way to represent/report the
>value all is fine, but in this case I doubt that you don't have
>available the 64th bit for the sign.

that seems likely to me also. i suspect we have somewhere between 32
and 64 bits of information. 

i didn't say that i conclusively needed the sign bit - i was noting
that the current API doesn't make unsigned values possible.

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
