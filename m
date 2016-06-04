From: lin-alsa@noblejury.com
Subject: Re: CIP Discontinuity with snd-firewire-digi00x
Date: Sat, 4 Jun 2016 18:09:59 -0500 (EST)
Message-ID: <alpine.LNX.2.20.1606041805260.17774@anticlack.com>
References: <alpine.LNX.2.20.1606041726460.13950@anticlack.com>
 <57535D26.2080105@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from click1.anticlack.com (noblejury.com [45.33.77.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F2732614A1
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 01:10:00 +0200 (CEST)
In-Reply-To: <57535D26.2080105@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: lin-alsa@noblejury.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Thank you for your quick reply! I greatly admire your code, and I was 
looking at your repo when I was setting this up :) The relavent dmesg 
lines (dmesg | grep fire) are here: http://ix.io/OQ2. I don't know if the 
first bit about the config rom has anything to do with this, but I hope it 
helps, and the hex pairs are in that log.

Re: the clock issue, I'm not actually using optical in, if that's what you 
mean. Please explain what you mean to me, I'm a bit confused as to your 
question.

Lin

On Sun, 5 Jun 2016, Takashi Sakamoto wrote:

> Hi,
>
> I've used the same unit for my development and test.
>
> On Jun 5 2016 07:30, lin-alsa@noblejury.com wrote:
>> Unfortunately, the mixer seems to desync or something after a few
>> minutes - hours. dmesg gives me `snd-firewire-digi00x fw1.0: Detect
>> discontinuity of CIP: XX XX` with XX XX replaced with various hex
>> pairs.
>
> The hex pairs is important in this log, too.
>
> On Jun 5 2016 07:30, lin-alsa@noblejury.com wrote:
>> so I don't think it's an external clock issue.
>
> Tell me the reason that you judge that quality of the external signal to
> optical interface as ADAT sync is enough good and realiable.
>
>
> Regards
>
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
