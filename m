From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: Using specific code for midi/gameport instead of
 generic one.
Date: Wed, 09 Feb 2005 15:17:57 +0100
Message-ID: <420A1B95.9050602@free.fr>
References: <Pine.HPX.4.33n.0502071626560.3379-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.HPX.4.33n.0502071626560.3379-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Clemens Ladisch wrote:
> matthieu castet wrote:
> 
>>Anyway, we should check if the midi device is found by pnp for these
>>chips. If it is the case, what happen if mpu401 module is load before
>>the via module ?
> 
> 
> The I/O ports and the interrupt would already have been taken by the
> mpu401 module.  However, the MPU-401 interrupt is usually assumed to
> be an unsharable ISA interrupt, so this would prevent the AC'97
> controller driver from being loaded.
> 
> Are there really any VT686 boards that have PnP information for the
> MPU-401?

I don't know...

Matthieu



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
