From: Daniel Mack <daniel@zonque.org>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Mon, 02 Dec 2013 17:00:13 +0100
Message-ID: <529CAE8D.6020003@zonque.org>
References: <529BF843.6000608@gmail.com>
 <20131202095948.GA2886@tamtam.fritz.box> <529CA3FC.1040301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 2955A261AB2
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 17:00:16 +0100 (CET)
In-Reply-To: <529CA3FC.1040301@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

On 12/02/2013 04:15 PM, Gabriel M. Beddingfield wrote:
> On 12/02/2013 01:59 AM, Daniel Mack wrote:

> Jack has always opened only one PCM device... which is the Right Thing 
> for most recording sound cards (e.g. ice1712, hammerfall, etc.). This is 
> the first "pro-sumer" device I've ever seen with multiple substream devices.

I was also uncertain when I wrote the driver which way is better. But
given that there are ways in ALSA to synchronously start separate
streams, I eventually went the stereo pairs way.

>> After all, the streams are guaranteed
>> to be synchronous, as they share the same clock in hardware.
> 
> TBH, the whole substream concept is lost on me.  Where does this 
> guarantee come from?  From the substream concept or from intimate 
> knowledge of this device? 

Both :)

> (I.e. how would JACK know about the clock 
> guarantee?)

snd_pcm_info_get_sync() should return the same clock id for both
interfaces in that case. But I must admit I haven't tried this in awhile.

>> Technically yes, but changing that would mean breakage for all other
>> users, and making it configurable would result in yet another moving
>> part which makes things even more complex.
> 
> How would this cause breakage?  Users that use 2 stereo substreams could 
> still work normally.

Yes, unless you opened the first subdevice with more than 2 channels.
Then an existing user for the second stream breaks. IOW: the possible
configuration and usage for subdevice 1 changes depending on that of
subdevice 0.

> But, FULL ACK on the moving parts.  That would indeed make the driver a 
> little gross on the inside.

What are your results with the multi plugin? Is that something you can
live with?


Daniel
