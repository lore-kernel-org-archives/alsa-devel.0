From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: Alsa Driver Scarlett
Date: Thu, 18 Sep 2014 18:20:51 +0200
Message-ID: <541B0663.9070306@googlemail.com>
References: <54148F1B.2010608@gmail.com> <20140916152227.53556d96@sampi>
 <20140916134925.GE17677@x1-orm> <20140916161002.714e7667@sampi>
 <541AD01B.30101@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f54.google.com (mail-la0-f54.google.com
 [209.85.215.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 115F3265536
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 18:21:00 +0200 (CEST)
Received: by mail-la0-f54.google.com with SMTP id ge10so1441746lab.41
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 09:21:00 -0700 (PDT)
In-Reply-To: <541AD01B.30101@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Johannes Kroll <j-kroll@gmx.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 18/09/14 14:29, David Henningsson wrote:
> Hi Tobias,
>
> I believe you are the author of the repository at 
> https://github.com/smilingthax/alsa-driver_scarlett.

Yes, I am.

> Your Scarlett driver is reported to be working fine, and there are 
> some requests (see below) to get the driver into mainline Linux. Is 
> this something you would be interested in helping out with?

I'm all for including the driver into mainline, but I do not have any time
to go through N iterations of a patch to get it there.

I *might* be able to do a initial cleaned up version against tiwai's 
for-next in the next few days, if that helps.

Other than that, I will happily (try to) answer questions about the code.

   Tobias


> Regards,
>   David
>
> On 2014-09-16 16:10, Johannes Kroll wrote:
>> On Tue, 16 Sep 2014 15:49:25 +0200
>> Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de> wrote:
>>
>>> Am Dienstag, den 16. September 2014 um 15:22:27 Uhr (+0200) schrieb 
>>> Johannes Kroll:
>>>>
>>>> I guess I'll need to find the time to port the patch to a recent 
>>>> kernel
>>>> when I upgrade, unless someone else does it first.
>>>
>>> The patch still works on our recent kernels (we are on debian testing
>>> with a 3.14-2 kernel), atm there is no porting necessary. I can also
>>> confirm that the driver has no known issues on our systems (we use a
>>> couple of Scarlett 18i20 in different configurations). It would be
>>> great, though if the patch could get integrated into alsa. At the
>>> moment it is quite painful for our students with linux laptops as they
>>> have to reapply the patch on every upgrade.
>>
>> Oh, I see. I'm all for integrating this patch into mainline. But I have
>> never done such a thing, so I don't know how much effort it would be. I
>> guess it would be a simple thing to do for a routine Alsa developer.
>> Anyone? :]
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
