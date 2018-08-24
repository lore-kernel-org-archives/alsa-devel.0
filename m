From: Ryan Lee <RyanS.Lee@maximintegrated.com>
Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp
	software reset
Date: Fri, 24 Aug 2018 01:00:42 +0000
Message-ID: <BY2PR1101MB1126A78A4E53E96E892AEBAEE7360@BY2PR1101MB1126.namprd11.prod.outlook.com>
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
 <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
 <20180823095107.GA5207@sirena.org.uk> <20180824000807.GF53155@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0128.outbound.protection.outlook.com [104.47.36.128])
 by alsa0.perex.cz (Postfix) with ESMTP id 44C1B26773B
 for <alsa-devel@alsa-project.org>; Fri, 24 Aug 2018 03:00:47 +0200 (CEST)
In-Reply-To: <20180824000807.GF53155@dtor-ws>
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
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

>-----Original Message-----
>From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>Sent: Thursday, August 23, 2018 5:08 PM
>To: Mark Brown <broonie@kernel.org>
>Cc: Ryan Lee <RyanS.Lee@maximintegrated.com>; Liam Girdwood
><lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
><tiwai@suse.com>; Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>;
>alsa-devel@alsa-project.org; lkml <linux-kernel@vger.kernel.org>;
>ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp software
>reset
>
>EXTERNAL EMAIL
>
>
>
>On Thu, Aug 23, 2018 at 10:51:07AM +0100, Mark Brown wrote:
>> On Wed, Aug 22, 2018 at 05:31:04PM -0700, Dmitry Torokhov wrote:
>> > On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee
><ryans.lee@maximintegrated.com> wrote:
>> > > +       mdelay(10);
>>
>> > Is it really necessary for the CPU to spin for 10msec here?
>> > usleep_range() would be better solution.
>>
>> Or msleep() for that matter, it's not going ot be the end of the world
>> if we delay a bit too long.
>
>Frankly, I'd rather we did not introduce extra delays. I do not know if we use
>this part, but on ChromeOS we are interested in shaving as much from the boot
>time as possible and 10 msecs here and 10 msecs there do add up.

Thanks for all your feedback.
Let me apply usleep_range() or msleep() instead of using mdelay().

>
>Thanks.
>
>--
>Dmitry
