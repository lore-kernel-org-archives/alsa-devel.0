From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SB Live 24 Ext (was: [ALSA - driver 0000955]: CN-126
 - USB 5.1 Audio adapter)
Date: Fri, 4 Mar 2005 12:09:11 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503041206101.8579-100000@studcom.urz.uni-halle.de>
References: <1109930226.16108.11.camel@ghanima>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1109930226.16108.11.camel@ghanima>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fruhwirth Clemens <clemens@endorphin.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Fruhwirth Clemens wrote:
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bmaControls( 0)      0x03
>           Mute
>           Volume
>         bmaControls( 1)      0x00
>         bmaControls( 2)      0x00
>         bmaControls( 3)      0x00
>         bmaControls( 4)      0x00
>         bmaControls( 5)      0x00
>         bmaControls( 6)      0x00
>         ...
>         bDescriptorSubtype      6 (FEATURE_UNIT)
>         bmaControls( 0)      0x02
>           Volume
>         bmaControls( 1)      0x00
>         bmaControls( 2)      0x00
>
> Obviously, the feature units are used for volume control solely.

Yes, and there's only one volume control for all channels.

> I wonder, how the audio signal flow looks like..

The bTerminalID/bUnitID field identifies each unit.  Start at the
output terminals and go back through the bSourceID's.


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
