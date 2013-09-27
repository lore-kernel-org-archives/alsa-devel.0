From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Can't get capturing from RME Hammerfall MADI card
 to work: sound loops & silcence
Date: Fri, 27 Sep 2013 09:43:08 +0200
Message-ID: <5245370C.5060408@ladisch.de>
References: <CANYi0v7OD_AFC9-jFeH4MGLZQGsPX91S5NdjqDsmZ_9pOR0hPg@mail.gmail.com>
 <CAGqxWvJQPFd_v_iN0eyVG1qCCUxeYpcOP0YU961Gn2JGdN3RgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CE58C26500D
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 09:43:11 +0200 (CEST)
In-Reply-To: <CAGqxWvJQPFd_v_iN0eyVG1qCCUxeYpcOP0YU961Gn2JGdN3RgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bruce <brucep@netspace.net.au>, Niels Laukens <niels.laukens@innovatie.vrt.be>, alsa-devel@alsa-project.org, Andrew Martin <vk3oe@bigpond.com>, Adrian Knoth <adi@drcomp.erfurt.thur.de>
List-Id: alsa-devel@alsa-project.org

bruce wrote:
> On 27 Sep 2013 16:09, "Niels Laukens" wrote:
>> I've also tried a related test with `arecord`, with similar but different
>> results:
>>
>> * The audio was also interspersed with silence
>>
>> * The capture duration did not match the requested '-d' option: the
>> recording was a factor of 2 shorter than requested.
>
> Similar issues here, but can add it all seems to work absolutely fine with
> alsa 1.0.15, but fails with 1.0.18+.

This sound like some change in the driver introduced a bug.


Regards,
Clmeens
