From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: External PCM plugin SDK
Date: Thu, 10 Feb 2005 19:06:01 +0100
Message-ID: <1108058761.15974.107.camel@pegasus>
References: <s5hd5vau4c3.wl@alsa2.suse.de>
	 <1107958458.13863.43.camel@pegasus> <s5hvf91stls.wl@alsa2.suse.de>
	 <1107959869.13863.62.camel@pegasus> <s5hoeetsqua.wl@alsa2.suse.de>
	 <1107970036.13863.77.camel@pegasus> <s5hfz05skp2.wl@alsa2.suse.de>
	 <1107971323.13863.90.camel@pegasus> <s5hy8dwr5ue.wl@alsa2.suse.de>
	 <1108038565.15974.20.camel@pegasus> <s5h7jlg1fyf.wl@alsa2.suse.de>
	 <1108057507.15974.97.camel@pegasus>  <s5h1xbo1ey9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5h1xbo1ey9.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> > > > > > Problem now is that XMMS closes the device and re-opens it when changing
> > > > > > the track and even when switching to its next track. This is problematic
> > > > > > when using Bluetooth, because I need to keep the underlaying connection
> > > > > > alive. Any idea?
> > > > > 
> > > > > Yeah, that's bad behavior of xmms.
> > > > > I'll try a hack later...
> > > > 
> > > > Another way is that I implement somekind of keep alive mechanism inside
> > > > the plugin, but what I have seen so far is that it is directly unloaded
> > > > when it is no longer used. So the 1:1 mapping of open/close is not a
> > > > good thing and maybe there should be some keep alive and reset inside
> > > > the ALSA library to help here out.
> > > 
> > > The delayed close in the plugin is of course good to have.
> > > My only concern is that the code would be complicated to handle
> > > races.
> > 
> > actually I see a lifetime race inside the plugin if I try to handle it
> > by myself. When the close() callback is called, I must free all of my
> > allocated resources, because the shared object will be unloaded, right?
> 
> Yes, the close callback should clean up everything since there is no
> distinction between close and unload, so far.

if the ALSA core is not handling the XMMS behaviour for us, I really
need something to distinguish between close and unload.

What do you think about doing it like with kernel modules? Means we add
an init and an exit entry point inside the plugin. The rest is done via
callbacks. With this we should be able to register a PCM and also the
mixer controls for it within the same plugin.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
