From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: Re: dmix plugin
Date: Wed, 19 Feb 2003 07:45:02 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045669502.3e53a67e46b60@webmail.namezero.com>
References: <Pine.LNX.4.44.0302191131230.1224-100000@pnote.perex-int.cz> <3E5367B4.9BB02DED@libero.it> <3E538B79.26FEE5F6@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E538B79.26FEE5F6@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Quoting Abramo Bagnara <abramo.bagnara@libero.it>:
> 
> The results are amazing and I'd say Jaroslav has done some mistakes in
> his handmade asm.
> 

This may be true, but I think you're trying to be a little too quick yourself.
Did you *test* your code? I only had time to take a short glance at it, but
too me it seems that this is not the correct check for overflow on signed
numbers:

>                       if (unlikely(sample & 0xffff0000))
>                                s = sample > 0 ? 0x7fff : -0x8000;
>                        else
>                                s = sample;

I noticed it because this is the first thought I had, but it only works
for unsgined. Notice that -1 will be 0xffffffff in a 32 bit sample. So
your code will "saturate" all negative samples to -8000 effectively
killing half of the wave, the way a diode does. I'm pretty sure this
would not sound good ;-). Still, even if you change this to two normal
ifs I assume the speed will not be affected by an order of magnitude.

Secondly, the test code is hardly a good representation of our "working"
environment because we're expecting multiple processes to write
concurrently to the buffer. I think you sholud have a "verification"
procedure which carefully mixes the waves one by one and then the 
n test mixes should be run in m processes concurrently. And the result
compared to the "verification" table.

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
