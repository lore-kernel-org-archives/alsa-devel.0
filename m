From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: External PCM plugin SDK
Date: Sat, 12 Feb 2005 03:18:27 +0100
Message-ID: <1108174707.8001.7.camel@pegasus>
References: <s5hd5vau4c3.wl@alsa2.suse.de>
	 <1107958458.13863.43.camel@pegasus> <s5hvf91stls.wl@alsa2.suse.de>
	 <1107959869.13863.62.camel@pegasus> <s5hoeetsqua.wl@alsa2.suse.de>
	 <1107970036.13863.77.camel@pegasus> <s5hfz05skp2.wl@alsa2.suse.de>
	 <1107971323.13863.90.camel@pegasus> <s5hy8dwr5ue.wl@alsa2.suse.de>
	 <1108038565.15974.20.camel@pegasus> <s5h7jlg1fyf.wl@alsa2.suse.de>
	 <1108057507.15974.97.camel@pegasus> <s5h1xbo1ey9.wl@alsa2.suse.de>
	 <1108058761.15974.107.camel@pegasus> <s5hwttgz36p.wl@alsa2.suse.de>
	 <s5hvf90z2qr.wl@alsa2.suse.de> <1108062270.15974.117.camel@pegasus>
	 <s5hll9vz7z9.wl@alsa2.suse.de> <1108124119.18099.23.camel@pegasus>
	 <s5hbrarz0n1.wl@alsa2.suse.de>  <s5h1xbnhuti.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5h1xbnhuti.wl@alsa2.suse.de>
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

> > > but I think we still should implement something like init() and exit()
> > > of the objects. Otherwise it would not be possible to handle this in a
> > > correct way and we will get memory leaks and unclosed descriptors.
> > 
> > We can add the clean up of cached plugin objects (i.e. calling
> > dlclose) in the existing snd_config_update_free_global().  This
> > function is supposed to be used for clean up of config tree cache.
> > 
> > Each plugin with the keep-alive flag can have functions with
> > __attribute__((constructor)) and __attribute__((destructor)) for the
> > purpose above.
> 
> The below is a test patch to add the dlobj cache.
> 
> It adds a new mode flag to pcm open mode, SND_PCM_KEEP_ALIVE.
> In xmms, change the call of snd_pcm_open() like:
> 
> 	snd_pcm_open(...., SND_PCM_NONBLOCK | SND_PCM_KEEP_ALIVE);
> 
> and the dl object will remain alive until
> snd_config_update_free_global() is called explicitly.
> 
> If the plugin needs always keep-alive, a bit more change is needed.

I personal think that the object caching should be transparent for the
applications, but I don't have the insides into the ALSA library. If it
is too hard then this might be a good solution.

However I won't have enough time to test this in detail for the next two
weeks, but the pcm_a2dp plugin is committed to the BlueZ CVS and maybe
some others want to give it a try.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
