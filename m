From: Trent Piepho <tpiepho@gmail.com>
Subject: Re: [PATCH] ASoC: wm8804: Allow fine-grained control
 of the PLL generation
Date: Thu, 9 Jan 2014 09:14:07 -0800
Message-ID: <CA+7tXijibZKUoeqeqpvOhgJg17OgpYR2Kv5S17TFdAKvaCjt3g@mail.gmail.com>
References: <alpine.DEB.2.02.1401082231260.4025@parallels-Parallels-Virtual-Platform>
 <20140109142745.GB6110@opensource.wolfsonmicro.com>
 <9DF5D0F7-F5A7-4705-8ACB-286B49D668C1@matuschek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f176.google.com (mail-ie0-f176.google.com
 [209.85.223.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 5308A261AC4
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 18:14:09 +0100 (CET)
Received: by mail-ie0-f176.google.com with SMTP id at1so3872106iec.35
 for <alsa-devel@alsa-project.org>; Thu, 09 Jan 2014 09:14:08 -0800 (PST)
In-Reply-To: <9DF5D0F7-F5A7-4705-8ACB-286B49D668C1@matuschek.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Matuschek <daniel@matuschek.net>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Dimitris.Papastamos@wolfsonmicro.com, Takashi Iwai <tiwai@suse.de>, devicetree-discuss@lists.ozlabs.org, patches@opensource.wolfsonmicro.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 9, 2014 at 7:29 AM, Daniel Matuschek <daniel@matuschek.net> wrote:
> On 09.01.2014, at 15:27, Charles Keepax <ckeepax@opensource.wolfsonmicro.com> wrote:
>
>> On Wed, Jan 08, 2014 at 10:36:53PM +0100, Daniel Matuschek wrote:
>>> Signed-off-by: Daniel Matuschek <daniel@matuschek.net>
>>>
>>
>> <snip>
>>
>>>                      pll_div->freqmode = post_table[i].freqmode;
>>> -                    pll_div->mclkdiv = post_table[i].mclkdiv;
>>> -                    target *= post_table[i].div;
>>> -                    break;
>>> +                    if ((mclk_div == WM8804_MCLKDIV_DONTCARE) ||
>>> +                        ((post_table[i].mclkdiv == 1) &&
>>> +                            (mclk_div == WM8804_MCLKDIV_1)) ||
>>> +                        ((post_table[i].mclkdiv == 0) &&
>>> +                            (mclk_div == WM8804_MCLKDIV_0))) {
>>
>> Would probably be nicer to update the post_table to use the new
>> defines and directly compare.

How about giving the defines better names?  Like WM8804_MCLKDIV_256x
for 0.  Assuming that's the value for 256x, I can't actually tell.
Which is why the define name could be better.

>> This does feel like a slight abuse of pll_id, it feels to me that
>> using the set_clkdiv callback would be a little more natural from
>> a user perspective.
>
> Good idea, I will move it to set_clkdiv.

Why does it need to be an option?  If 256x is better, then why not
always use it?  Maybe the code to select the divisor should be better?

If we look at the post_table:
static struct {
        unsigned int div;
        unsigned int freqmode;
        unsigned int mclkdiv;
} post_table[] = {
        {  2,  0, 0 },
        {  4,  0, 1 },
        {  4,  1, 0 },
        {  8,  1, 1 },
        {  8,  2, 0 },
        { 16,  2, 1 },
        { 12,  3, 0 },
        { 24,  3, 1 }
};

The code loops through that in order to find the first div that when
multiplied by the target rate gives 90-100 MHz.  So if the first div=4
in the table doesn't work, why would the second 4 work?  It looks like
it's just doing unnecessary tries to re-reject the same divisor
reached by different freqmode & mclkdiv combinations.

Since it stops at the first divisor that works, won't it always use
mclkdiv=1?  If mclkdiv=0 is better, why not just list those first/only
in the table so they get used?

BTW,
        if ((K % 10) >= 5)
                K += 5;
        K /= 10;

Worst Division With Rounding Ever.  And don't even get me started on
the base 10 fixed point on a binary computer.
