From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: mpu401_pnp
Date: Mon, 07 Feb 2005 20:23:24 +0100
Message-ID: <4207C02C.2060602@free.fr>
References: <Pine.HPX.4.33n.0502071640410.3379-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from postfix4-2.free.fr (postfix4-2.free.fr [213.228.0.176])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BADF322E
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2005 20:23:30 +0100 (MET)
In-Reply-To: <Pine.HPX.4.33n.0502071640410.3379-100000@studcom.urz.uni-halle.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
Clemens Ladisch wrote:
> matthieu castet wrote:
> 
>>Ok, I found a bug in your patch : when you call pnp_register_driver, you
>>should check that it is >= 0. If not you shouldn't call
>>pnp_unregister_driver.
> 
> 
> I just copied this from the other ALSA PnP drivers.  It seems those
> have all the same bug.
$grep -rI pnp_register_driver /usr/src/linux/sound/
/usr/src/linux/sound/oss/opl3sa2.c: 
pnp_register_driver(&opl3sa2_driver);
/usr/src/linux/sound/oss/awe_wave.c:    ret = 
pnp_register_driver(&awe_pnp_driver);
/usr/src/linux/sound/oss/cs4232.c: 
(pnp_register_driver(&cs4232_driver) > 0)
/usr/src/linux/sound/oss/cs4232.c:      if 
(pnp_register_driver(&cs4232_driver) > 0)
/usr/src/linux/sound/drivers/mpu401/mpu401.c:   if ((err = 
pnp_register_driver(&snd_mpu401_pnp_driver)) >= 0) {

only old oss driver seem to use it, the other alsa driver use 
pnp_register_card_driver that seem only provide >= 0 res


Matthieu


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
