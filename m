From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: External PCM plugin SDK
Date: Wed, 09 Feb 2005 18:48:43 +0100
Message-ID: <1107971323.13863.90.camel@pegasus>
References: <s5hd5vau4c3.wl@alsa2.suse.de>
	 <1107958458.13863.43.camel@pegasus> <s5hvf91stls.wl@alsa2.suse.de>
	 <1107959869.13863.62.camel@pegasus> <s5hoeetsqua.wl@alsa2.suse.de>
	 <1107970036.13863.77.camel@pegasus>  <s5hfz05skp2.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hfz05skp2.wl@alsa2.suse.de>
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

> > and I need full duplex IO and volume control inside the same plugin for
> > the headset/handsfree support.
> 
> Hmm, the share of volume control stuff between PCM and control plugins
> might be a bit tough.

the problem is that the headsets can report back volume changes. We will
see this for the high quality headphones also some day, because the
audio and video remote stuff for Bluetooth is already specified.

I will start without reacting to the volume control. We will see how
this works out.

> > > You don't have to set them if the hardware has no restriction.
> > > Usually, the period size defines the interrupt period.  In the case of
> > > user-space driver, it corresponds to the expected poll period, etc.
> > 
> > I can skip IOPLUG_HW_PERIOD_BYTES and IOPLUG_HW_PERIODS, but I must set
> > IOPLUG_HW_BUFFER_BYTES, because otherwise it segfaults even with aplay.
> 
> OK, then use snd_pcm_ioplug_set_param_minmax() with some sane values.

Leaving IOPLUG_HW_BUFFERS_BYTES out and only setting the period stuff
makes it working with the XMMS from CVS.

Problem now is that XMMS closes the device and re-opens it when changing
the track and even when switching to its next track. This is problematic
when using Bluetooth, because I need to keep the underlaying connection
alive. Any idea?

> > Let's take an unsigned long to handle more than 32 flags ;)
> 
> Well, I'd like to keep 32bit.
> 
> Nowadays no one knows whether the exported struct is shared between
> 32bit and 64bit environment.  Once if we have to implement a 32bit
> wrapper, the difference of long is simply a pain.

Fine with me.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
