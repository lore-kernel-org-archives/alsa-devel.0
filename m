From: Dirk Jagdmann <doj@cubic.org>
Subject: Re: Alsa support for Realtek ALC850
Date: Mon, 18 Apr 2005 21:16:39 -0800
Message-ID: <42649437.3080003@cubic.org>
References: <Pine.HPX.4.33n.0504181746170.5619-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0504181746170.5619-100000@studcom.urz.uni-halle.de>
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

> The ICH5 southbridge does not support 8-channel streams.  However, it

My manual says it's an ICH5R. The board is pretty new. The datasheet for 
the ALC850 codec claims it can do 8 channel sound. Thus I have just made 
a check (under windows) by playing back an 8 channel wav. All eight 
channels are clearly present on the 4 stereo 3.5mm (onboard jacks). 
Further the S/PDIF connector is the same as the first two channels 
(front l/r). So I conclude I have a true 8 channel codec.

> However, it might be possible that the chip needs some configuration
> bit to be set that the driver doesn't yet know about.

I say yes.

So, how can I help in supporting this chip.

Website for ALC850: 
http://www.realtek.com.tw/products/products1-2.aspx?modelid=2003101

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
