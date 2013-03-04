From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH v4 2/2] ALSA: ASoC: davinci-mcasp: don't
	overwrite DIT settings
Date: Mon, 4 Mar 2013 12:09:44 +0100
Message-ID: <CAGm1_ku2QMQZrARTnHsbu_1pEm+Yza=KdzEjpSLC0kXJbzZRHw@mail.gmail.com>
References: <1362393266-5127-1-git-send-email-yegorslists@googlemail.com>
 <1362393266-5127-2-git-send-email-yegorslists@googlemail.com>
 <51347AE4.9040403@gmail.com>
 <CAGm1_kvHNVA9AjJSJdG001k=TLoKE=c1MahuWPb44+udPBf+yw@mail.gmail.com>
 <51347F32.2020809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FBC926506D
 for <alsa-devel@alsa-project.org>; Mon,  4 Mar 2013 12:10:05 +0100 (CET)
Received: by mail-bk0-f46.google.com with SMTP id j5so2354676bkw.19
 for <alsa-devel@alsa-project.org>; Mon, 04 Mar 2013 03:10:04 -0800 (PST)
In-Reply-To: <51347F32.2020809@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "Porter, Matt" <mporter@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 4, 2013 at 12:02 PM, Daniel Mack <zonque@gmail.com> wrote:
> On 04.03.2013 11:58, Yegor Yefremov wrote:
>> On Mon, Mar 4, 2013 at 11:43 AM, Daniel Mack <zonque@gmail.com> wrote:
>>> On 04.03.2013 11:34, yegorslists@googlemail.com wrote:
>>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>>
>>>> Channel size settings will be made at the end of
>>>> davinci_mcasp_hw_params() routine and thus overwrite frame
>>>> format settings made for DIT mode. This patch fixes this issue
>>>> by taking op_mode into account. Tested with official PSP 3.2
>>>> kernel and sii9022a HDMI transmitter.
>>>>
>>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> For both, wrt a survived regression test :)
>>>
>>> Tested-by: Daniel Mack <zonque@gmail.com>
>>
>> Thanks.
>>
>> How do you make the test? Is it "doesn't break compilation" test? Or
>> do you have S/PDIF capable device?
>
> No, I'm running the driver in IIS mode, with a codec attached to the I2S
> lines. All I can do for now is test that your patches do not break my
> environment. I can not test DIT.

O.K. I see. That is actually, what I wonted to know, if it doesn't break i2s.

Yegor
