From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v4 00/11] ASoC: fsl_ssi: Clean up - coding
	style level
Date: Wed, 20 Dec 2017 12:40:37 +0100
Message-ID: <4c727cc2-2338-4e99-df09-a088a72cfd61@invoxia.com>
References: <1513565530-33957-1-git-send-email-nicoleotsuka@gmail.com>
 <4e69ef31-3aa6-66ea-331b-8a7472a66a15@tabi.org>
 <CAG5mAdxsWmHfCc=vFkO+Wmi8m0c_9t7B6BTUBGVOmPoGOQrsyg@mail.gmail.com>
 <20171218230220.GA16161@Asurada-Nvidia>
 <CAG5mAdzPuUo8SkJ_AqrgrouLWash4tge4YG7EMrdCTv9=K5FOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id AB923266E78
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 12:40:41 +0100 (CET)
Received: by mail-wm0-f44.google.com with SMTP id 64so9130313wme.3
 for <alsa-devel@alsa-project.org>; Wed, 20 Dec 2017 03:40:41 -0800 (PST)
In-Reply-To: <CAG5mAdzPuUo8SkJ_AqrgrouLWash4tge4YG7EMrdCTv9=K5FOQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, lukma@denx.de, Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org



On 19/12/2017 01:25, Caleb Crome wrote:
> On Mon, Dec 18, 2017 at 3:02 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>> On Mon, Dec 18, 2017 at 02:19:08PM -0800, Caleb Crome wrote:
>>
>>>> Acked-by: Timur Tabi <timur@tabi.org>
>> --- To Mark ---
>>
>> Mark, can you still take these changes first? Since this failed
>> test that Caleb reported here is already existing on the top of
>> the mainline tree, I would like to treat this mail as a separate
>> bug report and fix it with a separate patch.
>>
>> Besides, this series of changes don't change any function flow.
>>
>> Thank you
>>
> Sorry!  I should have created a separate thread for this subject.  My
> comments have *nothing* to do with this patch set, except they are
> about the same source files.
>
>> --- To Caleb ---
>>
>>> I'm re-setting up my loopback test to try to verify these most recent changes.
>> I really appreciate your verification and help.
> Of course!  I have this wandboard permanently set up for this
> verification test, so that I can easily repeat whenever I touch our
> kernel.
>
> It's a dead-simple hardware mod just to connect TX to RX.
>
>>> warn:   11a0 11a1 1160 11a3 11a4 11a5 11a6 11a7
>>> warn: Valid frame after 1 invalid frames
>>> warn:   11c0 11c1 11c2 11c3 11c4 11c5 11c6 11c7
>>> warn: first invalid frame while expecting frame 0x00a0
>>> warn:   13e7 1400 1401 1402 1403 1404 1405 1404
>>> warn:   1407 1420 1421 1422 1423 1424 1425 1426
>>> warn:   1427 1440 1441 1442 1443 1444 1445 1484
>>> warn:   1447 1460 1461 1462 1463 1464 1465 1466
>>>
>>> Those last 4 lines are the channel slips -- the least significant
>>> nibble should be the channel number:  i.e. should go 0, 1, 2, 3, 4, 5,
>>> 6, 7.
>>>
>>> Ugh, so it's basically quite broken again -- before these patches.
>> I remember Arnaud reviewed one of my changes back to September.
>> So I suppose the test should be fine at that time -- so a change
>> being merged recently might have impacted the test result.
>
> It's certainly possible that I'm doing something wrong again -- it
> wouldn't be the first time :-)

Hi All,

Sorry but I will be busy until mid January, I could help testing and 
fixing broken multi channel after.
Anyway, I don't see specific issues with Nicolin patches.
We can take time to fix what was broken before this patch set... after.

Arnaud

>
>>> I guess I need to go backwards in time and see what rev re-broke it.
>>> I don't really have time to dig too deep on this again.
>>>
>>> I'd be happy to provide the hardware to anybody that can diagnose and
>>> debug this more quickly than I can.  I'm very inefficient at kernel
>>> drivers I think.   My day job is acoustical and electrical
>>> engineering.
>>>
>>> Here's what the hardware looks like for anybody that's interested.
>>> Just a single wire loopback on the wandboard header.
>> I would definitely like to take the hardware to debug it as long
>> as you are willing to provide me. Can you send me a private mail
>> to discuss about it?
> Absolutely.
> -Caleb
>
>
>> Thanks
>> Nicolin
