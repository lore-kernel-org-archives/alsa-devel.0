From: Zenaan Harkness <zen@getsystems.com>
Subject: Re: Re: Playback stutters - Correction
Date: Wed, 20 Mar 2002 16:48:38 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020320164838.A32243@getsystems.com>
References: <20020320150503.A31328@getsystems.com> <200203200412.XAA07872@renoir.op.net> <20020320163214.A31970@getsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020320163214.A31970@getsystems.com>; from zen on Wed, Mar 20, 2002 at 04:32:15PM +1100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@Op.Net>
Cc: alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 20, 2002 at 04:32:15PM +1100, Zenaan Harkness wrote:
> On Tue, Mar 19, 2002 at 11:15:12PM -0500, Paul Davis wrote:
> > >I am getting the same with stock 2.4.18, DELL Inspiron laptop (Maestro
> > >3i), my test is:
> > >
> > >copy a cd image file from one partition to another, while trying to play
> > >an mp3 using mpg123.
> > >
> > >The mp3 skips all over the place.
> > 
> > since you almost certainly have IDE drivers, have you configured them
> > correctly using hdparm? these are source of considerable scheduling
> > latency, in ways that AFAIK are not improved by any of the "latency
> > reducing" patches available. don't ask me how to configure them - i
> > only use SCSI drives - but a quick google search should reveal
> > relevant advice.
> 
> thanks
> 
> hdparm improves the situation, but I still get some (minimal) skips now:
> 
> zen8100a:~# hdparm /dev/hda
> 
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  readahead    =  8 (on)
>  geometry     = 7296/255/63, sectors = 117210240, start = 0
>  busstate     =  1 (on)
> 
> 
> My current 'test':
>  - playing an mp3
>  - running make clean && make bzImage
>  - copying a cd image between two partitions
>  - loading up the odd application (eg. mozilla)
> 
> With hdparm settings I've tried:
>  - 2.4.18 + preempt + lockbreak
>  - 2.4.18 + lowlatency
>  - 2.4.19-pre3-ac3 + preempt
> 
> These seem to all give the same minimal skips with above activities.
> 
> No skips with only the kernel compile (not doing the large copy).

CORRECTION:
Just retested with full hdparm (added -u setting) settings on
2.4.19-pre3-ac+preempt, and no skipping with above activities. This
seems pretty good.

I could generate skips when switching from X to text console. Could not
generate skip when cycling virtual desktops within X (at high key repeat
rate). Again this seems pretty good.

thanks
zen

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
