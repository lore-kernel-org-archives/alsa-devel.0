From: "Palacios, Hector" <Hector.Palacios@digi.com>
Subject: Re: [PATCH] ASoC: soc-pcm: always cancel any pending
 delayed stream shutdown
Date: Tue, 28 Oct 2014 17:42:18 +0000
Message-ID: <544FD578.7000205@digi.com>
References: <1413987293-21544-1-git-send-email-hector.palacios@digi.com>
 <20141022162802.GB2344@sirena.org.uk>
 <52F917CEA1B9C64C94833D53889D478C044B9B@dor-sms-xch01.digi.com>
 <CAOMZO5BjS9y0sCkT8wq_pdi7BgxB-5PMa8gCdAgs5=CfYP5K1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.4]) by alsa0.perex.cz (Postfix) with ESMTP id A6CF9265E22
 for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2014 18:42:24 +0100 (CET)
In-Reply-To: <CAOMZO5BjS9y0sCkT8wq_pdi7BgxB-5PMa8gCdAgs5=CfYP5K1A@mail.gmail.com>
Content-Language: en-US
Content-ID: <F8DC7D71247BFC4AA1FCDA04F276EFAC@digi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Fabio,

On 10/28/2014 04:23 PM, Fabio Estevam wrote:
> Hi Hector,
>
> On Wed, Oct 22, 2014 at 3:25 PM, Palacios, Hector <Hector.Palacios@digi.com>
> wrote:
>
>>> You're not saying what the problems are, just that they might be caused.
>>
>> Sorry, your right. When I do a recording 2 seconds after a previous playback, and
>> later play the recorded sound I hear 3 seconds of correct audio and then I
>> continue to hear good audio but mixed with noise and at a higher volume, as if
>> the codec had reseted certain parameters to some default values.
>
> Are you able to reproduce this problem on 3.18-rc?

Mark was right and I tracked the problem down to sgtl5000 driver's function 
power_vag_event() which is called by the scheduled work 5 seconds after a playback is 
finished.
Then I saw this was already fixed in commit f091f3f07328f75d20a2a5970d1f8b58d95fc990 
"ASoC: sgtl5000: prevent playback to be muted when terminating concurrent capture".

Thanks
--
Hector Palacios
