From: Dino Puller <dino@e4a.it>
Subject: Volume per voices [Feature Request]
Date: Tue, 26 Jul 2005 11:49:38 +0200
Message-ID: <42E60732.4090808@e4a.it>
References: <Pine.HPX.4.33n.0507251659070.23061-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507251659070.23061-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,
    i don't know if this is the right place to ask for a new feature, 
BTW here it is:
It's should be very useful to have a standard way/function to map volume 
per PCM stream. For now seems that only emu10k1 and via82xxx has a 
volume control for each PCM streams, probably because a lack on the 
others drivers. Where the HW/driver doesn't support this control, it's 
should be emulated via software.

Thanks,
    Dino Puller



Clemens Ladisch wrote:

>Dino Puller wrote:
>
>  
>
>>Clemens Ladisch wrote:
>>
>>    
>>
>>>The Emu10k1 and VIA82xxx drivers have volume controls for each
>>>hardware PCM stream.  Most other hardware cannot do this.
>>>      
>>>
>>But with emu10k1 or via82xxx can i access to volume controls in a
>>standard manner provided by alsa?
>>    
>>
>
>You can access them like any other mixer control.
>
>There is no ALSA function to map from a PCM stream to this control.
>
>  
>
>>How can i know if my device supports this volume control?
>>    
>>
>
>Check if you're running with these drivers.
>
>There should be a common API for all hardware/software mixing
>implementations, but currently there isn't.
>
>
>Regards,
>Clemens
>
>
>  
>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
