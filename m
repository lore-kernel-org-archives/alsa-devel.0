From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: External PCM plugin SDK
Date: Thu, 10 Feb 2005 13:29:25 +0100
Message-ID: <1108038565.15974.20.camel@pegasus>
References: <s5hd5vau4c3.wl@alsa2.suse.de>
	 <1107958458.13863.43.camel@pegasus> <s5hvf91stls.wl@alsa2.suse.de>
	 <1107959869.13863.62.camel@pegasus> <s5hoeetsqua.wl@alsa2.suse.de>
	 <1107970036.13863.77.camel@pegasus> <s5hfz05skp2.wl@alsa2.suse.de>
	 <1107971323.13863.90.camel@pegasus>  <s5hy8dwr5ue.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hy8dwr5ue.wl@alsa2.suse.de>
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

> > > > and I need full duplex IO and volume control inside the same plugin for
> > > > the headset/handsfree support.
> > > 
> > > Hmm, the share of volume control stuff between PCM and control plugins
> > > might be a bit tough.
> > 
> > the problem is that the headsets can report back volume changes. We will
> > see this for the high quality headphones also some day, because the
> > audio and video remote stuff for Bluetooth is already specified.
> > 
> > I will start without reacting to the volume control. We will see how
> > this works out.
>  
> If so, running a daemon might be possibly easier than doing concurrent
> access?

actually I see the headsets and also the headphones as virtual software
soundcards and so a plugin for them should deal with the PCM stream and
also the mixer settings. My idea is to make it transparent for the end
user. Once they configured their device in .asoundrc they never have to
worry about it again.

Maybe we can have a second entry point in the shared object. One is for
the PCM and the other one for the mixer settings.

> > Leaving IOPLUG_HW_BUFFERS_BYTES out and only setting the period stuff
> > makes it working with the XMMS from CVS.
> 
> Good to hear :)

I checked BMP from CVS now and this is also working.

> > Problem now is that XMMS closes the device and re-opens it when changing
> > the track and even when switching to its next track. This is problematic
> > when using Bluetooth, because I need to keep the underlaying connection
> > alive. Any idea?
> 
> Yeah, that's bad behavior of xmms.
> I'll try a hack later...

Another way is that I implement somekind of keep alive mechanism inside
the plugin, but what I have seen so far is that it is directly unloaded
when it is no longer used. So the 1:1 mapping of open/close is not a
good thing and maybe there should be some keep alive and reset inside
the ALSA library to help here out.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
