From: John Hsu <KCHSU0@nuvoton.com>
Subject: Re: [PATCH 2/2] ASoC: nau8825: provide clock divide
 for codec mater mode
Date: Tue, 3 Jan 2017 11:04:50 +0800
Message-ID: <586B14D2.5080503@nuvoton.com>
References: <1482223627-23547-1-git-send-email-KCHSU0@nuvoton.com>
 <1482223627-23547-2-git-send-email-KCHSU0@nuvoton.com>
 <20161231185701.4ebiu7zvmbldfdjd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 58082266CC5
 for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2017 04:04:55 +0100 (CET)
In-Reply-To: <20161231185701.4ebiu7zvmbldfdjd@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 WTLi <WTLI@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

On 1/1/2017 2:57 AM, Mark Brown wrote:
> On Tue, Dec 20, 2016 at 04:47:07PM +0800, John Hsu wrote:
>
>> Provide the LRC and BCLK divide. The clock divide needs configuration
>> properly when codec in master mode.
>>
>
> Why is the driver not able to configure these automatically, most
> devices manage to do that OK?  Typically systems are fine with the
> obvious divisions down from the root clock, the driver should at least
> offer that as a default rather than requiring all machine drivers to
> duplicate the divisor selection code.
>

The system clock of codec is always 256FS. Therefore, the driver can
make it automatically. If the codec is as master, the driver needs to
divide the system clock to output the BCLK and FS. But there are too
many combinations between BCLK and FS. The BCLK maybe is 32FS, 64FS,
128FS, etc. The driver needs machine information to do the division.
Thus, I think the best way is to make decision by machine driver.



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
