From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: Re: sigmadsp: adau1701: Version mismatch while loading
 firmware in 3.18.3
Date: Wed, 28 Jan 2015 17:01:42 +0100
Message-ID: <54C907E6.9080805@gmail.com>
References: <54C8E881.60106@gmail.com> <54C8EB7A.7010901@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id A3D3D261AC3
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:01:45 +0100 (CET)
Received: by mail-wg0-f45.google.com with SMTP id x12so21446158wgg.4
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 08:01:44 -0800 (PST)
In-Reply-To: <54C8EB7A.7010901@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 28.01.2015 15:00, Lars-Peter Clausen wrote:
> On 01/28/2015 02:47 PM, Pascal Huerst wrote:
>> Hello Lars-Peter,
>>
>> i followed the instructions on:
>>
>> http://wiki.analog.com/resources/tools-software/linux-software/sigmadsp_genfirmware
>>
>>
>> and built the firmware from my xml-file. But when the driver loads, I
>> always get:
>>
>> adau1701 2-0034: Failed to load firmware: Invalid version 2. Supported
>> firmware versions: 1
>> adau1701 2-0034: Failed to load firmware
>> adau1701 2-0034: ASoC: can't set adau1701 hw params: -22
>>
>> I have been using that .xml/.bin file in 3.14.13 for some time, but now
>> in 3.18.3 I always get the version mismatch from above.
> 
> Hi,
> 
> Are you sure that the you were previously using a v2 firmware file? v2
> was not supported until recently and loading it with the v1 loader would
> just result in garbage being written to the device.

I have been using the firmware file for more than a year without any
problems on 3.14.23, so I assume it is v1. I don't know why the driver
tells me it's v2, however. Maybe my tree is messed up.

If I port adau1701.{c,h} and sigmadsp.{c,h} from 3.14.23 to 3.18.3, it
works. I think I have to look deeper into that...

> The patch[1] that adds support for v2 is pretty standalone and you
> should be able to backport it to v3.18.

If I cherry-pick that in, the message is gone, but still, I don't have
no output.

> [1]
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/sound/soc/codecs/sigmadsp.c?id=a35daac77a0397d4f23b642d3dc0684682e56cc5
