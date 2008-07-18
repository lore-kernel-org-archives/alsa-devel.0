From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [boot crash,
	bisected] in 9f240a55 "ALSA: opti93x: use cs4231	lib"
Date: Fri, 18 Jul 2008 22:15:58 +0200
Message-ID: <20080718201558.GA24122@elte.hu>
References: <Pine.LNX.4.61.0807141105150.7676@tm8103-a.perex-int.cz>
	<20080717170657.GA14593@elte.hu> <s5h3am8jqvy.wl%tiwai@suse.de>
	<487F9B9B.2010905@keyaccess.nl> <487F9FA1.7020101@keyaccess.nl>
	<48806017.1040307@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	by alsa0.perex.cz (Postfix) with ESMTP id DBCAD2457B
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 22:16:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <48806017.1040307@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA development <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org


* Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 17-07-08 21:38, Rene Herman wrote:
>
>> On 17-07-08 21:20, Rene Herman wrote:
>>
>>> On 17-07-08 20:40, Takashi Iwai wrote:
>>>
>>>> Could you try the patch below?
>>>
>>> No, please hang on, it's much simpler. Above commit isn't actually  
>>> itself guilty. Have a patch ready, but am testing a bit.
>>
>> I retract that. Your patch should fix things.
>
> It does. Acked/Tested-by: Rene Herman <rene.herman@gmail.com>

box survived dozens of reboots so the fix from yesterday indeed did the 
trick.

thanks,

	Ingo
