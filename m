From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Mon, 02 Dec 2013 07:15:08 -0800
Message-ID: <529CA3FC.1040301@gmail.com>
References: <529BF843.6000608@gmail.com>
 <20131202095948.GA2886@tamtam.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 75EE3261AA5
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 16:15:18 +0100 (CET)
Received: by mail-pd0-f176.google.com with SMTP id w10so18188046pde.21
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 07:15:17 -0800 (PST)
In-Reply-To: <20131202095948.GA2886@tamtam.fritz.box>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

On 12/02/2013 01:59 AM, Daniel Mack wrote:
>> split up into stereo substreams.  I.e. the first two channels are
>> found in hw:x,0,0 and the last two channels are in hw:x,0,1.
>
> That's right, but I don't see a problem with that. Why was jack having
> trouble using the two interfaces?

Jack has always opened only one PCM device... which is the Right Thing 
for most recording sound cards (e.g. ice1712, hammerfall, etc.). This is 
the first "pro-sumer" device I've ever seen with multiple substream devices.

> After all, the streams are guaranteed
> to be synchronous, as they share the same clock in hardware.

TBH, the whole substream concept is lost on me.  Where does this 
guarantee come from?  From the substream concept or from intimate 
knowledge of this device?  (I.e. how would JACK know about the clock 
guarantee?)

...and is the the substream concept (in ALSA) trying to solve?

>> Ideally, substream 0 would support 1, 2, or 4 channels (for both
>> playback and capture).  When substream 0 is using more than 2
>> channels, then substream 1 would return EBUSY when in use.
>>
>> So... would it be possible to do this in the caiaq driver?
>
> Technically yes, but changing that would mean breakage for all other
> users, and making it configurable would result in yet another moving
> part which makes things even more complex.

How would this cause breakage?  Users that use 2 stereo substreams could 
still work normally.

But, FULL ACK on the moving parts.  That would indeed make the driver a 
little gross on the inside.

-gabe
