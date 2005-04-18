From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Alsa support for Realtek ALC850
Date: Mon, 18 Apr 2005 18:00:19 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0504181746170.5619-100000@studcom.urz.uni-halle.de>
References: <42638E68.9080400@cubic.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42638E68.9080400@cubic.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dirk Jagdmann <doj@cubic.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dirk Jagdmann wrote:
> I recently purchased an ASUS P4P800-E mainboard which features i865
> chipset with an Realtek ALC850 AC'97 Codec. This codec is recognized by
> the i8x0 drivers (I tested this with Alsa 1.0.8) as an 6 channel device.
> However this chip supports 8 channels, but this is not
> supported/recognized by Alsa currently. I had a quick look into the i8x0
> sources, but did not find the correct spot, where to patch the source to
> support 8 channels.

The ICH5 southbridge does not support 8-channel streams.  However, it
would be possible to combine the standard 6-channel device and the
SPDIF device into an 8-channel device, if the codec expects the last
two channels on the AC'97 slots usually used for SPDIF.

Put the following into your ~/.asoundrc file:

pcm.ch123456 {
	type hw
	card 0
	device 0
}

pcm.ch78 {
	type hw
	card 0
	device 4
}

pcm.eight {
	type plug
	slave.pcm {
		type multi
		slaves.a {
			pcm ch123456
			channels 6
		}
		slaves.b {
			pcm ch78
			channels 2
		}
		bindings [
			{ slave a channel 0 }
			{ slave a channel 1 }
			{ slave a channel 2 }
			{ slave a channel 3 }
			{ slave a channel 4 }
			{ slave a channel 5 }
			{ slave b channel 0 }
			{ slave b channel 1 }
		]
	}
}


However, it might be possible that the chip needs some configuration
bit to be set that the driver doesn't yet know about.


HTH
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
