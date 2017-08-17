From: ThomasJF <tsepp2001@t-online.de>
Subject: Re: non-blocking mode example
Date: Thu, 17 Aug 2017 15:37:33 +0200
Message-ID: <a0bfdc84-d5d3-3d0f-7113-ad95440e9f3d@t-online.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
 <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
 <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
 <693e0d31-9b74-3ccf-e4a5-aac3b94ee4da@ladisch.de>
 <2a3cecc4-730c-208b-0674-68bbbe5d72d4@t-online.de>
 <f811f743-3433-2b1a-f932-677290d5d562@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 08903266998
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 15:37:40 +0200 (CEST)
Received: from fwd08.aul.t-online.de (fwd08.aul.t-online.de [172.20.26.151])
 by mailout12.t-online.de (Postfix) with SMTP id 5907D41C2F72
 for <alsa-devel@alsa-project.org>; Thu, 17 Aug 2017 15:37:40 +0200 (CEST)
In-Reply-To: <f811f743-3433-2b1a-f932-677290d5d562@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thank you again Clemens,

now it is working with poll and the two fds. Also pause, play and stop.

If it stops, the snd_pcm_wait in my loop returns a negative error code 
and the state changes to SND_PCM_STATE_SETUP, then it finishes and 
everything seems to be ok.

Anything to do here?

Best regards
Thomas



Am 15.08.2017 um 14:49 schrieb Clemens Ladisch:
> ThomasJF wrote:
>> Now I have a do-while loop with select.
> Better use poll(); select() is cumbersome with the ALSA's API.
>
>> To get the tcp-commands for stop/pause:
>>
>> 1.) Do I have to adapt the tcp-commands inside this loop or...
>>
>> 2.) Do I have to work with any poll descriptors (which?)
> These function allow to wait for multiple file descriptors to become
> ready.  So wait for all the fds from the ALSA device _and_ the fd of
> the socket.
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
