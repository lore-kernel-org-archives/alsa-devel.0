From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: Re: [RFC] add bus driver model support for ad hoc
	AC97 drivers
Date: Fri, 04 Mar 2005 16:26:05 +0000
Message-ID: <1109953565.28156.1712.camel@cearnarfon>
References: <Pine.LNX.4.61.0501261051150.16341@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0501261051150.16341@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: nico@cam.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-26 at 16:26, Nicolas Pitre wrote:
> I would like to know what people think of the following patch.  It 
> allows for a codec on an AC97 bus to be shared with other drivers which 
> are completely unrelated to audio.  It registers a new bus type, and 
> whenever a codec instance is created then a device for it is also 
> registered with the driver model using that bus type.  This allows, for 
> example, to use the extra features of the UCB1400 like the touchscreen 
> interface and the additional GPIOs and ADCs available on that chip for 
> battery monitoring.  I have a working UCB1400 touchscreen driver here 
> that simply registers with the driver model happily working alongside 
> with audio features using this.
> 


Any chance this patch can make it into CVS ?
I have a couple of AC97 control based audio and touch drivers that now
use it for AC97 access.

Thanks

Liam



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
