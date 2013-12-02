From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Mon, 02 Dec 2013 08:14:46 -0800
Message-ID: <529CB1F6.7070607@gmail.com>
References: <529BF843.6000608@gmail.com>
 <20131202095948.GA2886@tamtam.fritz.box> <529CA3FC.1040301@gmail.com>
 <529CAE8D.6020003@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 762C2261B35
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 17:14:49 +0100 (CET)
Received: by mail-pb0-f50.google.com with SMTP id rr13so19103160pbb.23
 for <alsa-devel@alsa-project.org>; Mon, 02 Dec 2013 08:14:48 -0800 (PST)
In-Reply-To: <529CAE8D.6020003@zonque.org>
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

On 12/02/2013 08:00 AM, Daniel Mack wrote:
>> TBH, the whole substream concept is lost on me.  Where does this
>> guarantee come from?  From the substream concept or from intimate
>> knowledge of this device?
>
> Both :)
>
>> (I.e. how would JACK know about the clock
>> guarantee?)
>
> snd_pcm_info_get_sync() should return the same clock id for both
> interfaces in that case. But I must admit I haven't tried this in awhile.

Thanks!  I'll have to play around with that.

>> But, FULL ACK on the moving parts.  That would indeed make the driver a
>> little gross on the inside.
>
> What are your results with the multi plugin? Is that something you can
> live with?

I don't actually have one of these devices and the end-user I was 
helping is happy now, AFAIK.

But solving this required editing asoundrc files (ugh) and casting 
several magic spells.  Would be nice if it "just works."

Anyway, perhaps the solution is to get JACK to recognize the extra 
substreams.

-gabriel
