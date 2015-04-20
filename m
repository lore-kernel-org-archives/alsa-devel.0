From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: Support Dell headset mode for ALC288
Date: Mon, 20 Apr 2015 15:12:59 -0500
Message-ID: <55355DCB.8010300@dell.com>
References: <6FAB7C47BCF00940BB0999A99BE3547A17A0C909@RTITMBSV09.realtek.com.tw>
 <s5hoan4xdxi.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0D1AB@RTITMBSV09.realtek.com.tw>
 <s5hsicb6pbc.wl-tiwai@suse.de>
 <6FAB7C47BCF00940BB0999A99BE3547A17A0D1D7@RTITMBSV09.realtek.com.tw>
 <s5hmw2jnejt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ausc60ps301.us.dell.com (ausc60ps301.us.dell.com
 [143.166.148.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 6CDDD260595
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 22:13:09 +0200 (CEST)
In-Reply-To: <s5hmw2jnejt.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "(alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>, Kailang <kailang@realtek.com>
List-Id: alsa-devel@alsa-project.org


On 04/08/2015 04:40 AM, Takashi Iwai wrote:
> At Wed, 8 Apr 2015 08:08:47 +0000,
> Kailang wrote:
> OK, I applied this with rephrasing the changelog mentioning ALC286,
> too.
>
> Since this one and Dell patch are relative large changes, I queued
> them to for-next branch instead of for-linus, i.e. the merge to Linus
> tree will be postponed to 4.1-rc1.
>
>
> thanks,
>
> Takashi
>
>
Takashi,

It's a bit unfortunate that these are landing in 4.1 rather than 4.0.  4.1 they actually won't be very useful in the default kernel due to this patch landing:
https://github.com/torvalds/linux/commit/b1ef2972586577e0ca9675254ee141f65a8824e5

With 4.1 the XPS 13 will run in I2S audio mode.

Is there any chance at backporting these to @stable?  Some of the distros (Ubuntu and Fedora) are already backporting this into some of their kernel versions, but I think this should benefit the community at large if the other distributions that tracked @stable could pick this up too.

Thanks,
