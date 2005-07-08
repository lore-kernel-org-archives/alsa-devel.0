From: fons adriaensen <fons.adriaensen@skynet.be>
Subject: Re: [Jackit-devel] Reading alsa midi-data inside the jack client process thread
Date: Fri, 8 Jul 2005 19:34:17 +0200
Message-ID: <20050708173417.GA4959@linux-1>
References: <21780.212.169.96.218.1120819000.squirrel@webmail.uio.no> <20050708114237.GA7127@bth05w.ABSp.alcatel.be> <26283.212.169.96.218.1120825827.squirrel@webmail.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <26283.212.169.96.218.1120825827.squirrel@webmail.uio.no>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no>" <k.s.matheussen@notam02.no>
Cc: Alfons Adriaensen <fons.adriaensen@alcatel.be>, jackit-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 08, 2005 at 02:30:27PM +0200, Kjetil Svalastog Matheussen <k.s.matheussen@notam02.no> wrote:

> if (snd_seq_event_input_pending (seq,1)) {
>   while(snd_seq_event_input(seq,&event);
> 
> which I think should do the same... Guess I just have to read the source. :-)

OOPS, I didn't see the 'while' when commenting on this.
AFAICT it will do the same as my code, if you set the seq
to non-blocking mode. 

Happy coding !

-- 
FA




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
