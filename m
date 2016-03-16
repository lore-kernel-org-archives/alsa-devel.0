From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ASoC: cs35l32: prevent unexpected parse
 result of device tree
Date: Wed, 16 Mar 2016 12:51:25 +0900
Message-ID: <56E8D83D.90304@sakamocchi.jp>
References: <1458043574-6078-1-git-send-email-o-takashi@sakamocchi.jp>
 <1458043574-6078-2-git-send-email-o-takashi@sakamocchi.jp>
 <20160315143035.GO2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 2AB12260524
 for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2016 04:51:29 +0100 (CET)
In-Reply-To: <20160315143035.GO2566@sirena.org.uk>
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
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mar 15 2016 23:30, Mark Brown wrote:
> On Tue, Mar 15, 2016 at 09:06:14PM +0900, Takashi Sakamoto wrote:
>> When device tree blob has no node properties requested by callers,
>> of_property_read_u32() returns minus value, then given argument is
>> not changed.
>
> This is probably fixed by a recent patch, please check with current code.

Aha, exactly. I should have sought mailing list archive.

http://mailman.alsa-project.org/pipermail/alsa-devel/2016-March/105419.html

> Please don't send cover latters for single patches, if they're needed
> they indicate that you need to improve the commit log for the change.

I used for this purpose. Anyway, OK.


Thanks

Takashi Sakamoto
