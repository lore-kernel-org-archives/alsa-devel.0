From: Tyler Yeomans <tyeo098@gmail.com>
Subject: Re: Intel Baytrail Linux Audio
Date: Thu, 23 Jul 2015 11:24:55 -0400
Message-ID: <55B10747.5000101@gmail.com>
References: <559C3F4A.5030307@gmail.com> <20150708033604.GM11002@localhost>
 <20150708102308.91b7258f243e354b1365a47e@ao2.it> <559D3411.6060306@gmail.com>
 <20150708182132.db38656fb4ccc2e38e41aba0@ao2.it> <559D5091.9020802@gmail.com>
 <20150708221745.f72dcbec9c96eb86ce0cbfc2@ao2.it> <559EC436.30900@gmail.com>
 <20150710040623.GY836@localhost> <55A3F027.9010006@gmail.com>
 <20150714084755.GA5086@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f50.google.com (mail-qg0-f50.google.com
 [209.85.192.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 27EED261A8C
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 17:23:13 +0200 (CEST)
Received: by qgeu79 with SMTP id u79so63428589qge.1
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2015 08:23:12 -0700 (PDT)
In-Reply-To: <20150714084755.GA5086@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@ao2.it>, Nicolas George <george@nsup.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nikula,
 Jarkko" <jarkko.nikula@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello Vinod,

Sorry to bother again, is there any update or anything else I can try here?

Thanks,

Tyler

On 07/14/2015 04:47 AM, Vinod Koul wrote:
> On Mon, Jul 13, 2015 at 01:06:47PM -0400, Tyler Yeomans wrote:
>> Vinod,
>>
>> Have you received my last message?
>> The device was originally installed with 8.1, but I have since
>> erased it in favor of Ubuntu.
>>
>> Is there anything I can be trying in the meantime?
>>
>> Thanks-
>>
>> Tyler
>>
>> On 07/10/2015 12:06 AM, Vinod Koul wrote:
>>> On Thu, Jul 09, 2015 at 02:57:58PM -0400, Tyler Yeomans wrote:
>>>> Antonio/Vinod,
>>>>
>>>> I have made the change in the sst-acpi.c file for the atom specific boards.
>>>> I've attached the dmesg output here with dynamic debug enabled.
>>>>
>>>> To clarify-
>>>>
>>>> snd-intel-sst-core is loaded
>>>> FE-BE fix has been applied
>>>> I'm using the ssp0 firmware.
>>>>
>>>> Interrupts are still 0
>>>>
>>>> Still no sound.
> Thanks,
>
> I think the interrupt routing is not right, so am trying ti get answers for
> this, stay tuned :)
>
