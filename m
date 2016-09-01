From: lin-alsa@noblejury.com
Subject: Re: CIP Discontinuity with snd-firewire-digi00x
Date: Wed, 31 Aug 2016 19:52:24 -0500 (EST)
Message-ID: <alpine.LNX.2.20.1608311949210.31059@localhost.localdomain>
References: <alpine.LNX.2.20.1606041726460.13950@anticlack.com>
 <57535D26.2080105@sakamocchi.jp>
 <alpine.LNX.2.20.1606041805260.17774@anticlack.com>
 <5753736F.6010902@sakamocchi.jp>
 <alpine.LNX.2.20.1606050916120.23467@anticlack.com>
 <5754AD09.3080807@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from noblejury.com (noblejury.com [45.33.77.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D02F267411
 for <alsa-devel@alsa-project.org>; Thu,  1 Sep 2016 02:52:39 +0200 (CEST)
In-Reply-To: <5754AD09.3080807@sakamocchi.jp>
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

TZAG,

This issue went away for a while, sorry for the radio silence. I'm now 
running 4.4.17-rt25-1-rt-lts. I believe that the relevant driver was 
merged into mainline since then. I've had a little more time to do some 
debugging, and I've discovered that the mixer connected light goes on
and off a few times before turning off and requiring a hard reboot.

Best,

Lin

On Mon, 6 Jun 2016, Takashi Sakamoto wrote:

> Hi,
>
> On Jun 5 2016 23:22, lin-alsa@noblejury.com wrote:
>>  I know I compiled it from your git repo at one point in the past, and I
>>  think that is the version being used (I'm on a lts kernel).
>
> OK. We should check the point in the past.
>
> Please get git-hash of HEAD in your local repository duplicated from my 
> remote repository, like:
> $ cd your-local-repository
> $ git show HEAD
> $ commit xxxx....
>
> As a next step, I'd like to update your build so that we can use the new 
> feature (tracepoints) recently added to snd-firewire-lib in Linux 4.7-rc1. I 
> maintain my remote repository for backporting to Linux 3.10 or later and you 
> could install the latest feature in your 3.18 kernel.
>
>
> Regards
>
> Takashi Sakamoto
>
