From: Case van Rij <case@seattle.gii.net>
Subject: Re: problem with alsa "ameter" plugin ?
Date: Wed, 9 Jul 2003 02:48:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030709094836.GF29757@seattle.gii.net>
References: <20030709031211.GE29757@seattle.gii.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030709031211.GE29757@seattle.gii.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 08, 2003 at 08:12:11PM -0700, Case van Rij wrote:
> 
> Laurent Georget reported a problem with alsa "level" and "ameter"
> plugins earlier, I'm not sure this problem is related since it doesn't
> seem to involve pcm_wait.. but Im still relativly unfamiliar with the
> inner workings of the code. 
> 
> I'm using ameter 0.3 with alsa-* 0.9.3 and 0.9.4 which works fine on 2
> of my systems with snd-ens1371, but I cant seem to get it to work on
> otherwise identical systems that use snd-hdsp and snd-rme9652 
> 
> Ive tried setting up ameter on either hw:0,0 and plug:hw:0 and running:
> 
> arecord -D ameter -t wav -c 18 -r 44100 -f S16_LE file.wav
> 
> which fails with 
> pcm_mmap.c:137: snd_pcm_mmap_read_areas: 
>  Assertion `snd_pcm_mmap_capture_avail(pcm) >= size)`

As a matter of fact, it appears snd_pcm_mmap_capture_avail(pcm) is 0 

Case

> 
> Any ideas what's going on here ? 
> 
> Thanks,
> Case
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Parasoft
> Error proof Web apps, automate testing & more.
> Download & eval WebKing and get a free book.
> www.parasoft.com/bulletproofapps
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps
