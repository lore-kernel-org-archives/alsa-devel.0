From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: External PCM plugin SDK
Date: Fri, 11 Feb 2005 13:15:19 +0100
Message-ID: <1108124119.18099.23.camel@pegasus>
References: <s5hd5vau4c3.wl@alsa2.suse.de>
	 <1107958458.13863.43.camel@pegasus> <s5hvf91stls.wl@alsa2.suse.de>
	 <1107959869.13863.62.camel@pegasus> <s5hoeetsqua.wl@alsa2.suse.de>
	 <1107970036.13863.77.camel@pegasus> <s5hfz05skp2.wl@alsa2.suse.de>
	 <1107971323.13863.90.camel@pegasus> <s5hy8dwr5ue.wl@alsa2.suse.de>
	 <1108038565.15974.20.camel@pegasus> <s5h7jlg1fyf.wl@alsa2.suse.de>
	 <1108057507.15974.97.camel@pegasus> <s5h1xbo1ey9.wl@alsa2.suse.de>
	 <1108058761.15974.107.camel@pegasus> <s5hwttgz36p.wl@alsa2.suse.de>
	 <s5hvf90z2qr.wl@alsa2.suse.de> <1108062270.15974.117.camel@pegasus>
	 <s5hll9vz7z9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hll9vz7z9.wl@alsa2.suse.de>
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

> > > ... and doesn't work as it is, unfortunately :-<
> > > 
> > > dlcose() is called after snd_pcm_close().
> > > We may need to build object caches in alsa-lib.
> > > This will improve the perfomance eventually, too.
> > 
> > questions is what will break if you change it. The only official plugin
> > is the Jack plugin, right? So be bad and change this stuff and then fix
> > the plugins.
> 
> The compatibility will be kept, I think.  Only the plugins with a
> keep-alive flag are excluded from dlclose, and the objects are reused
> at the next open.

but I think we still should implement something like init() and exit()
of the objects. Otherwise it would not be possible to handle this in a
correct way and we will get memory leaks and unclosed descriptors.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
