From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: External PCM plugin SDK
Date: Wed, 09 Feb 2005 15:37:49 +0100
Message-ID: <1107959869.13863.62.camel@pegasus>
References: <s5hd5vau4c3.wl@alsa2.suse.de>
	 <1107958458.13863.43.camel@pegasus>  <s5hvf91stls.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hvf91stls.wl@alsa2.suse.de>
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

> > > I now commited a patch to add the external PCM plugin SDK to
> > > alsa-lib.  This allows you to create ALSA PCM plugin outside the
> > > alsa-lib tree.  It's still a draft version, and currently only the I/O
> > > plugin (e.g. for implementation of user-space driver) is provided.
> > > The filter-type plugin SDK (e.g. for effects) and the control plugin
> > > SDK will follow later.
> > > 
> > > No documentation yet.  Look at the code :)
> > > 
> > > Example I/O plugins are found in alsa-plugins tree.  So far, two
> > > plugins, OSS and JACK plugins.  The former one is the plugin to
> > > emulate ALSA API with the OSS driver.  The latter is almost identical
> > > with the one in alsa-lib/src/pcm/ext.
> > > 
> > > I think this SDK can be used for better implementaion of BT-SCO and
> > > FireWire.
> > 
> > I wrote a quick and dirty prototype using SBC over RFCOMM for now.
> 
> Wow.

it is putting the PCM data into the SBC encoder and then sending it to
the RFCOMM socket. This is not the standard for high quality audio over
Bluetooth, but my Aiptek headphone supports this stuff. For now this is
easier than dealing with A2DP and AVDTP.

The SCO support for the headsets is another story.

> >  It is
> > working with aplay and the alsaplayer, but not with xmms or beep. Are
> > there any known problem with these ALSA plugins?
> 
> Which xmms/bmp are you using?
> I fixed ALSA plugins of xmms and bmp recently, so it might have been
> fixed.  For testing, you can try the one in SUSE's rpms from STABLE.

The XMMS is version 1.2.10 and BMP is version 0.9.7. In what versions
are the ALSA plugins fixed. I will build it from source.

> Do you have buffer or period size constraints?

Oh yes, that is the point where I am not sure what I am doing. The SBC
is a codec like MP3 and actually I have no idea what are the best values
here. These are software soundcards.

> > We also talked about making these IO plugins visible when ALSA is
> > listing its hardware devices. Is this possible now?
> 
> No, it's still in planning.
> We'll need to define a usable API first...

What about a flags variable in snd_pcm_ioplug for activating it. This is
generic and for me this is enough, because both Bluetooth IO plugins are
virtual soundcards and they should always be listed. Or maybe list IO
plugins in general.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
