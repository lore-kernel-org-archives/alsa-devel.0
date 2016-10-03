From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/5] ASoC: tas571x: fix missing bias save
 level
Date: Mon, 3 Oct 2016 21:13:37 +0200
Message-ID: <4b73304e-b3f1-e2ec-e8ac-d273aece9f11@metafoo.de>
References: <1475505650-8572-1-git-send-email-brain@jikos.cz>
 <1475505650-8572-2-git-send-email-brain@jikos.cz>
 <505a8248-dcc6-ee31-b381-72c661d1b373@metafoo.de>
 <429a96e7-1eb4-9d30-9b38-ea7d8c95ffd3@jikos.cz>
 <0e94e2d2-0cab-d82f-05ac-afd2c4d81253@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id A98EB266D04
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 21:13:43 +0200 (CEST)
In-Reply-To: <0e94e2d2-0cab-d82f-05ac-afd2c4d81253@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: brain@jikos.cz, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/03/2016 09:11 PM, Lars-Peter Clausen wrote:
> On 10/03/2016 09:00 PM, Petr Kulhavy wrote:
>>
>> On 03/10/16 19:09, Lars-Peter Clausen wrote:
>>> On 10/03/2016 04:40 PM, Petr Kulhavy wrote:
>>>> The tas571x_set_bias_level() was not saving the new bias level to
>>>> codec->dapm.bias_level. This had the effect that bias was switching between
>>>> standby and off levels and never entered the on level.
>>>>
>>>> This fix saves the bias level before returning from the function.
>>>>
>>> This is done by the ASoC core after the function completes, so this should
>>> not be necessary.
>> Hi Lars,
>>
>> since what kernel version is it handled by the ASoC core?
>> I've been testing it on a 4.1 based iMX kernel and there the bias levels
> 
> Since v4.2. This is the commit:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=fa880775ab0d5a8d540972f7b6800fad1af16b75

Sorry, wrong ID, this one is it:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=f4bf8d770b58862c2af9d17adc2fee05bef8f2c0
