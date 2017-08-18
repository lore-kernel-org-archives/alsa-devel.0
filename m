From: ThomasJF <tsepp2001@t-online.de>
Subject: Re: non-blocking mode example
Date: Fri, 18 Aug 2017 13:41:11 +0200
Message-ID: <ff2dff4b-e1a5-23ec-fb8b-5f4b3d172e4a@t-online.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
 <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
 <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
 <693e0d31-9b74-3ccf-e4a5-aac3b94ee4da@ladisch.de>
 <2a3cecc4-730c-208b-0674-68bbbe5d72d4@t-online.de>
 <f811f743-3433-2b1a-f932-677290d5d562@ladisch.de>
 <a0bfdc84-d5d3-3d0f-7113-ad95440e9f3d@t-online.de>
 <c2b0d797-0cb4-6592-5a2f-f7661b0871fb@ladisch.de>
 <c57a7ec3-a69b-342e-759c-049a98abc14a@t-online.de>
 <e19ddc02-4098-2036-1959-8ec82cd4e31e@t-online.de>
 <a4c8de7b-4ebd-ad71-722d-5e40260f9512@ladisch.de>
 <e1b1e328-d961-714d-c4cc-66786bd763d9@t-online.de>
 <5a7c7b85-6116-6807-8e18-649840551c82@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D86E266943
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 13:41:20 +0200 (CEST)
Received: from fwd06.aul.t-online.de (fwd06.aul.t-online.de [172.20.26.150])
 by mailout06.t-online.de (Postfix) with SMTP id 7BE2741CC55F
 for <alsa-devel@alsa-project.org>; Fri, 18 Aug 2017 13:41:20 +0200 (CEST)
In-Reply-To: <5a7c7b85-6116-6807-8e18-649840551c82@ladisch.de>
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

Thank you Clemens,

but while the stream is running the snd_pcm_poll_descriptors_count 
couldn't change - or...?
Then it should be inside the loop.

Regards
Thomas



Am 18.08.2017 um 12:37 schrieb Clemens Ladisch:
> ThomasJF wrote:
>> I could change the code (attached a short part)
> This mailing list does not have attachments.
>
>> After stop, the stream stops and everything looks good(?), but with this message from snd_pcm_writei:
>> -77 (-EBADFD)
> You cannot write to a device in the stopped state. This is to be expected
>
>
> And you must actually use the return value of snd_pcm_poll_descriptors_count()
> (there are device types with more than one fd), and you must not look at the
> returned event flags except with snd_pcm_poll_descriptors_revents().
>
>
> Regards,
> Clemens
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
