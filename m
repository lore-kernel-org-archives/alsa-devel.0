From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Delay channel X by one sample
Date: Fri, 25 Mar 2005 14:05:41 +0000
Message-ID: <42441AB5.7030005@superbug.co.uk>
References: <4243FFFC.9040907@ybb.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <4243FFFC.9040907@ybb.ne.jp>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Edson Pereira <ewp_jp@ybb.ne.jp>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Edson Pereira wrote:
> 
> Greetings,
> 
> I am in the process of implementing a small software defined radio 
> receiver using the PCM2903 codec and have a question for the 
> alsa-developers.
> 
> The ALSA USB-Audio interface is working very well. The audio quality of 
> the chip is quite good, but the chip has a bug! The audio stream of one 
> channel is delayed by one sample in respect to the other channel. This 
> is drastic for the mentioned application since the phase correlation 
> between channels is critical. I have contacted Burr Brown technical 
> support and they have acknowledged the problem. The error is in the FIFO 
> addressing hardware and is present in the ADC as well in the DAC (but in 
> reversed channels).
> 
> The problem is quite easy to get around in the application, but this 
> prevents the hardware interface being used with other programs (testing 
> software for example). My question is: Where in the system software 
> chain could a work around be implemented? In the ALSA snd-usb-audio? Or 
> is there any other more appropriate place?
> 
> Thanks and best regards,
> 
> -- Edson
> 

I think adding this "delay channel X by one sample" feature would be a 
nice feature to add to alsa-lib. We are going to need it in order to 
support 96khz SPDIF out on the Audigy 2 cards via the P16V chip.
So, if other cards also need it, it would be good to add.

James



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
