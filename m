From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH] ASoC:nau8825: automatic LRCK and BCLK
 divide in master mode
Date: Tue, 7 Feb 2017 10:24:37 +0800
Message-ID: <58992FE5.6020001@nuvoton.com>
References: <1486021010-32340-1-git-send-email-KCHSU0@nuvoton.com>
 <20170203115757.q2ku7xzymqcx3yq2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AFB1D26686E
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 03:24:42 +0100 (CET)
In-Reply-To: <20170203115757.q2ku7xzymqcx3yq2@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: WTLI@nuvoton.com, YHCHuang@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,
On 2/3/2017 7:57 PM, Mark Brown wrote:
> On Thu, Feb 02, 2017 at 03:36:50PM +0800, John Hsu wrote:
>
>
>> Provide the automatic configurable LRC and BCLK divide. The bit clock rate
>> can be chosen by userspace. The driver will make configurations of LRCK
>> and BCLK automatically when playback or capture in master mode.
>>
>
> As far as I can tell this only provides manual selection from userspace,
> I can't see the code for automatic selection.  I'd not expect to see any
> userspace control of something like this, if there is an override I'd
> expect it to come from the machine driver, and as I've previously said
> I'd definitely expect automatic selection to be the default like it is
> with other CODEC drivers.
>

I see. Maybe I can get the bit clock and frame sync information when
hardware parameter. According to the information to make LRC and BCLK
divide confirguration.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
