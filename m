From: Gorm David Lai <lai@daimi.au.dk>
Subject: Re: problems with rme digi96/8
Date: 06 Jun 2003 12:10:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054894258.2057.53.camel@duff>
References: <1054808252.7022.8.camel@duff>  <20030605190335.GB493@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030605190335.GB493@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I just thought of something new. It seems as if the hardware buffer on
the card gets filled up, but is never emptied anywhere.

The reason is that in the beginning everything seems to go fine, but
then I suddenly get the following error:

ALSA lib pcm_hw.c:466:(snd_pcm_hw_prepare) SNDRV_PCM_IOCTL_PREPARE
failed: Device or resource busy

This also happens on the soundblaster card, but there I can see that I
am still sometimes allowed to pass samples to the card, which makes the
sound play fine. On the rme digi96/8 card however, after this error
first happens, no more samples are allowed to be written.

Any idea on how to get the card to play the samples in the buffer? (if
this is indeed the error).

/Gorm


On Thu, 2003-06-05 at 21:03, Martin Langer wrote:
> On Thu, Jun 05, 2003 at 12:17:32PM +0200, Gorm David Lai wrote:
> > Hi, I really hope somebody can help me.
> > 
> > We have recently bought a RME Digi96/8 card. This connects via adat to a
> > mixing console.
> > I have implemented the code in the ALSA 0.9.0 HOWTO for playback. This
> > works fine on a sound blaster card in stereo.
> > However with the digi96/8 card the mixing console does not get any
> > input. The mixing console syncs fine on the adat connection, it just
> > does not seem to get any sound input.
> > 
> > Any help, would be greatly appreciated as I am getting desperate.
> > 
> 
> ADAT isn't well tested, so everything is possible. But a look to wiki page
> on http://opensrc.org/alsa/index.php?page=rme96 looks not so bad.
> 
> Are you using plughw:0,1 or hw:0,1? What's your alsa version? 
> 
> 
> martin
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
> thread debugger on the planet. Designed with thread debugging features
> you've never dreamed of, try TotalView 6 free at www.etnus.com.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
