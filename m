From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: endianness problems in fireworks/bebob_maudio
Date: Mon, 08 Dec 2014 18:08:27 +0900
Message-ID: <54856A8B.7090600@sakamocchi.jp>
References: <5484C572.7040606@ladisch.de> <5484E69E.1000009@sakamocchi.jp>
 <54855CA5.5070307@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D33E260445
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 10:08:30 +0100 (CET)
In-Reply-To: <54855CA5.5070307@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Dec 08 2014 17:09, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> For my information, Would you tell me the way to generate these sparse
>> report?
>
> make C=1 CF=-D__CHECK_ENDIAN__

I always check with 'make C=2' without the 'CF' flag.
Firewire drivers handle big-endian data, so the flag is nice.

Thanks


Takashi Sakamoto
o-takashi@sakamocchi.jp
