From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM API questions
Date: Tue, 25 Jun 2002 03:12:18 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0206250310090.616-100000@pnote.perex-int.cz>
References: <200206242113.g5OLDAf25236@post2.fast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200206242113.g5OLDAf25236@post2.fast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: Joshua Haberman <joshua@haberman.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Jun 2002, Paul Davis wrote:

> >Maybe this is what the "default" device is intended for, but can it
> >accommodate more than one card?  I happen to have a sound card built into
> >my motherboard and another in a PCI slot -- how do I tell XMMS which one
> >to use?
> 
> an excellent context for the question. 
> 
> i want to extend the question just a little. it seems from watching a
> few friends who use windows audio apps that its conventional there to
> name audio output options after the physical hardware. so you see
> things like "Terratec XWP" and "Ensoniq PCM" and so forth. This is
> nice because its what a lot of users think in terms of.
> 
> in ALSA, we really don't see such naming at all. thats fine with me,
> but it leads me to wonder. the reason that the names are useful is
> that they don't move around when you change the install order for the
> modules (for example). so, the "Ensoniq PCM" is always the "Ensoniq
> PCM" whether its the first card or the second.
> 
> Now, AFAICT, Windows doesn't make it very easy to deal with multiple
> "Ensoniq PCM" devices whereas ALSA does. However, there does seem to
> be something "missing" when we present users with
> 
>    plughw:1,0
> 
> as the name of suitably flexible device for general purpose audio on
> the second card in the absence of a ~/.asoundrc file ....
> 
> So I'm left wondering what naming scheme to use to get a more flexible
> way of referring to cards *without* using an ~/.asoundrc
> file. Alternatively, how to autogenerate the file so that it provides
> nice names?

I think that you've forgot that we can identify hardware devices over the 
control interface. Look for snd_ctl_pcm_next_device() and snd_ctl_pcm_info()
functions. It's easy to use this information with combination of PCM names 
like 'hw:CARD,DEVICE,SUBDEVICE' and 'plughw:*'.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
