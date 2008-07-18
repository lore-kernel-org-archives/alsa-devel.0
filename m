From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [boot crash,
 bisected] in 9f240a55 "ALSA: opti93x: use cs4231 lib"
Date: Fri, 18 Jul 2008 14:36:09 +0200
Message-ID: <48808E39.4060404@keyaccess.nl>
References: <Pine.LNX.4.61.0807141105150.7676@tm8103-a.perex-int.cz>	<20080717170657.GA14593@elte.hu>	<s5h3am8jqvy.wl%tiwai@suse.de>	<487F9B9B.2010905@keyaccess.nl>	<487F9FA1.7020101@keyaccess.nl>	<48806017.1040307@keyaccess.nl>
	<20080718142849.f11ce4c8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A77724471
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 14:34:10 +0200 (CEST)
In-Reply-To: <20080718142849.f11ce4c8.krzysztof.h1@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: ALSA development <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 18-07-08 14:28, Krzysztof Helt wrote:

> On Fri, 18 Jul 2008 11:19:19 +0200
> Rene Herman <rene.herman@keyaccess.nl> wrote:
> 
>> On 17-07-08 21:38, Rene Herman wrote:
>>
>>> On 17-07-08 21:20, Rene Herman wrote:
>>>
>>>> On 17-07-08 20:40, Takashi Iwai wrote:
>>>>
>>>>> Could you try the patch below?
>> This bug was uncovered by !CONFIG_PNP and we had trouble in this driver 
>> due to that before so was rewriting the init to be a generic multi-card 
>> ALSA init but, actually, not much point.
>>
> 
> The bug was introduced by the patch as it used (tried to free) the codec pointer
> before it was assigned any value. It happened only if the card was missing and
> I didn't test the driver on such a configuration. My mistake. The CONFIG_PNP
> setting makes no difference.

Yes it does. Note how the ISA match method fails due to "if (isapnp)" 
with CONFIG_PNP and isapnp being initialized to 1. I did test without 
the hardware but didn't see it fail due to that.

>> In fact, in the meantime I'll look at splitting 92x and 93x again. It's 
>> much better now that Krzysztof made it use the generic library code but 
>> I still hate this driver. It's also poking at ports without being told 
>> something is there by either system or user.
>>
> 
> Please hold your axe until Monday. The last patch (not posted yet) from the 
> unification of the WSS library series removes some ifdefs in this driver.
> This may (or may not) change your view on splitting the driver.

Will do.

Rene.
