From: Andreas Mohr <andi@lisas.de>
Subject: Re: Bugs on aspire one A150
Date: Sat, 22 Nov 2008 20:43:59 +0100
Message-ID: <20081122194359.GA29278@rhlx01.hs-esslingen.de>
References: <s5h3ai11dpt.wl%tiwai@suse.de>
	<20081109151323.GA18705@rhlx01.hs-esslingen.de>
	<s5h7i7c916e.wl%tiwai@suse.de>
	<20081109200929.GA29333@rhlx01.hs-esslingen.de>
	<s5hiqqtkxqr.wl%tiwai@suse.de> <491B0D38.1050207@gmail.com>
	<20081112180519.GA21919@rhlx01.hs-esslingen.de>
	<491DBDEA.9010104@gmail.com> <492856C2.8000707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id ECDAA2438B
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 20:44:00 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <492856C2.8000707@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel@vger.kernel.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Nov 22, 2008 at 09:00:18PM +0200, Maxim Levitsky wrote:
> Maxim Levitsky wrote:
>> 1) The dc offset isn't present on aspire one, really is a circuit 
>> design bug I guess 2) Internal mic works perfectly on aspire one, can 
>> reproduce the strange behaver at all,
>> Probably this was mixer bug.
> Finally, I found how to reproduce that bug,
> I mean to get normal volume on internal mic, I have to increase volume
> only on left or right channel.
>
> So, this happens always, and _only_ when recording _mono_ sound from internal
> mic.
>
> Since hardware doesn't support hardware mono input, tested with -D hw:0
> I suspect this to be alsa-lib bug, any ideas?
> Happens with arecord -D plughw:0 -c1 .

Wow, nice analysis!
I had already intended to report that you're #2 who told me that Mic does work
(and I was starting to feel weird since I'm the only one who cannot
get it to work!)
Given your analysis, things start to make a lot more sense now.

That probably means that Ekiga Wizard uses mono input (since it does not work
for me), whereas many other apps use stereo input as (natively!) supported
by this hardware setup?

--> alsa lib bug sounds like a good guess.

Thanks,

Andreas Mohr
