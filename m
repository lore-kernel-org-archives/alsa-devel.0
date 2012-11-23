From: Daniel Mack <zonque@gmail.com>
Subject: Re: Underrun on Jade controller...
Date: Fri, 23 Nov 2012 14:48:28 +0100
Message-ID: <50AF7EAC.3090603@gmail.com>
References: <1353665116.15462.YahooMailNeo@web120405.mail.ne1.yahoo.com>
 <50AF4B3E.9050003@gmail.com>
 <1353666946.95213.YahooMailNeo@web120406.mail.ne1.yahoo.com>
 <50AF527C.8000108@gmail.com>
 <1353675262.71605.YahooMailNeo@web120405.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A48E260319
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 14:48:32 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so3670906bkc.38
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 05:48:31 -0800 (PST)
In-Reply-To: <1353675262.71605.YahooMailNeo@web120405.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 23.11.2012 13:54, Sandulescu Bogdan wrote:
>> On 23.11.2012 11:35, Sandulescu Bogdan wrote:
>> >
>> > Daniel Mack <zonque <at> gmail.com> writes:
>> >>
>> >> Without providing any code, I guess nobody on this list will be able to
>> >> help you.
>> >>
>> >> Daniel
>> >>
>> >
>> >
>> > OK. Here is the essential part of my code - settings and write to ALSA:
>>
>> It's not about the userspace code in the first place but the kernel part.
>>
>> I guess you are based on a BSP kernel that the vendor of the
>> chip/module/board you are using provides. For whatever reason, this
>> vendor has decided to not push its code to the mainline kernel but keep
>> changes in a private repository.
>>
>> While this is a common approach, your vendor is the only instance in the
>> game that is in charge of supporting you here. The community can't, as
>> the code has not been shared for discussion and integration in mainline.
>>
>> Daniel
>>
>>
> 
> Hello Daniel,
> 
> Thank you for your answer. Initially I thought I should share my app, as
> every information I got regarding underruns was that the application is
> not feeding data fast enough - hence I thought it was my application's
> fault.
> 
> Considering your precise answer, I will try to get support directly from
> the module vendor.

... and make them push their changes to mainline already, as this is
your only option to keep up-to-date with all the continously added new
features in mainline. Rebasing vendor patches has always caused major
headache an much more work on the long run.


Daniel
