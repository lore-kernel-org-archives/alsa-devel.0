From: Nathaniel Gray <n8gray@caltech.edu>
Subject: Re: dmix plugin problems -- Resend
Date: Mon, 26 May 2003 21:16:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305262116.21379.n8gray@caltech.edu>
References: <200305261528.32421.n8gray@caltech.edu> <1053992910.1404.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1053992910.1404.7.camel@localhost>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "David E. Storey" <dave@tamos.net>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Monday 26 May 2003 04:48 pm, David E. Storey wrote:
> nice. Your config just helped me make it work for me. I too have an
> intel8x0. (I also have some other gear, but in essence I can use
> alsaplayer and xmms on my intel8x0 simultaneously.) Not being an
> expert in .asound voodoo, I would say that yours is a bit more
> complicated than it needs to be. Without changing your .asound file,
> have you tried:
>
> aplay -D mydmix test.wav

I'm pretty sure that will only work if the sample you're playing is at 
the "correct" rate.  In other words, dmix doesn't do any resampling, so 
if you try to play a file that has the wrong rate you'll get problems.  
That's the reason for the extra layer with the "plug" plugin -- it does 
rate conversion.

> The only other difference is that I don't have rate 44100. It is my
> understanding that the intel8x0 is locked at 48000 for the hardware I
> have. 

Certain files play with the "rate 44100" line and others don't, but more 
play with it than without it.  I'd recommend testing it with the KDE_* 
files in /usr/share/sounds if you have KDE installed.  They have lots 
of funky sampling rates that aplay seems to choke on.

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
