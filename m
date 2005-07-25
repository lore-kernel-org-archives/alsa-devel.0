From: Dino Puller <dino@e4a.it>
Subject: Re: Volume per voices
Date: Mon, 25 Jul 2005 16:49:14 +0200
Message-ID: <42E4FBEA.9030002@e4a.it>
References: <Pine.HPX.4.33n.0507251620540.23061-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507251620540.23061-100000@studcom.urz.uni-halle.de>
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

Clemens Ladisch wrote:

>Dino wrote:
>  
>
>>   i'm looking for setting a volume per voice(pcm stream) but it seems to be
>>impossible. I've found only a plugin to do it in software but i'd like to do it
>>in Hardware. Is it a feature not supported by alsa?
>>    
>>
>
>The Emu10k1 and VIA82xxx drivers have volume controls for each
>hardware PCM stream.  Most other hardware cannot do this.
>  
>
But with emu10k1 or via82xxx can i access to volume controls in a 
standard manner provided by alsa? If so is it only a lack of some 
drivers? How can i know if my device supports this volume control?

tnx,
    Dino Puller

>
>HTH
>Clemens
>
>
>
>-------------------------------------------------------
>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
>from IBM. Find simple to follow Roadmaps, straightforward articles,
>informative Webcasts and more! Get everything you need to get up to
>speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
