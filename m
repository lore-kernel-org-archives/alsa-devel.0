From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How to proper handle surround sound setups
Date: Wed, 21 Feb 2007 09:01:24 +0100
Message-ID: <1172044884.19834.1175710235@webmail.messagingengine.com>
References: <1171975258.10279.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1171975258.10279.48.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "Christian F.K. Schaller" <christian@fluendo.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Christian F.K. Schaller wrote:
> We have a long discussion today in the GStreamer community about how to
> correctly handle surround sound setups.
> 
> The ideal solution we are looking for is a situation where the user do
> not need to configure anything, things just work in an optimal fashion
> depending on their hardware. We are not sure however what exactly is the
> status of a lot of things both in theory and in practice. So I am
> sending out this email to you.
> 
> GStreamer currently queries the alsadevice for its capabilities and
> tries to negotiate an optimal path through its playback pipeline with a
> little quality loss as possible.
> 
> This means that if the soundcard reports supporting surround sound and
> you are playing a multichannel file then GStreamer will output surround
> sound by default in most cases.
> 
> The discussion started as it seems my ICH4 laptop mistakenly reporting
> supporting surround sound on the PCM device, while its only supports
> surround sound indirectly through its s/pdif output(is this a known
> bug?).

Many laptops do weird things with their sound chips.  It's possible that
yours has a 5.1-capable codec, but has not connected all outputs.

> I thus started arguing that we should default to stereo due to this and
> only do surround sound if the users selects it on the application level
> as even if the user truly has a surround capable system they don't
> necessarily have more than two stereo speakers connected.

Yes, that can be the case.

> The debate then turned to whether connected speakers connected can be
> autodetected or not. Some people reported that their Mac's and Vista
> systems did detect at least some speaker detection, but I was not able
> to clarify if the systems could actually tell you that you have for
> instance LF, center and LR + a woofer connected and so on.

Many modern AC'97 and HDA codecs could detect whether speakers are
connected (or if a shared jack is connected to a mic or a line-out), but
this is only usable with vendor-specific drivers because every
motherboard vendor uses different routings for the output and detection
pins.

ALSA currently dosn't bother to try to implement this.

> The other alternative we are looking at which might simplify things for
> us is to use the virtual devices which expose the different surround
> scenarios like using for instance:
> 
> defaults.pcm.surround51.device for surround51 output.

The device name for this is "surround51" (but it's better to use
"plug:surround51" because this virtual device doesn't have the sample
format converter that "default" has enabled by default).

> In this scenario we use the stereo device by default which would then
> only report back support for stereo and thus negotiate correctly to
> stereo with all elements.

ALSA's "default" device usually reports that it supports any number of
channels.

You should use "default" for stereo streams and "plug:surround51" for
surround streams.

> Users can then through the applications choose the 5.1 audio device at
> which point we would change to the 5.1 device like the one above. Our
> worry the by the playback autoplugger which as you know is rarely the
> casere though is what happens with stereo output as we of course do
> not want that upmixed.

Doesn't the part of GStreamer that chooses the device name know the
number of channels that the stream will have?


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
