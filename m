From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 0/5] Add platform clock for BayTrail platforms
Date: Sat, 21 Jan 2017 12:53:54 +0200
Message-ID: <CAHp75VeSYLHg0ugrYYsBhs=_wDD+0j1jkk0LvY4ws3qdbHkL8w@mail.gmail.com>
References: <1484690270-28425-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1484736630.2133.184.camel@linux.intel.com> <20170121000028.GG20800@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170121000028.GG20800@codeaurora.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, linux-clk@vger.kernel.org, "x86@kernel.org" <x86@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Irina Tirdea <irina.tirdea@intel.com>, Michael Turquette <mturquette@baylibre.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 21, 2017 at 2:00 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/18, Andy Shevchenko wrote:
>> On Tue, 2017-01-17 at 15:57 -0600, Pierre-Louis Bossart wrote:
>> > These patches specifically enable the audio MCLK required by Baytrail
>> > CR devices. It is the remaining part of a bigger set of patches
>> > (already merged in Mark Brown's tree) that enable sound for Baytrail
>> > CR
>> > devices (especially Asus T100TAF) [1]. They include the clock driver
>> > and clock enabling in the pmc_atom code (along with moving of the
>> > non-architectural pmc_atom driver code into drivers/platform/x86 as
>> > suggested by Thomas Gleixner [2]). This move includes a new header in
>> > include/linux/platform_data/x86/. While there is an agreement that the
>> > definitions for PMC clocks are not really platform data this location
>> > is seen as a good-enough compromise with an agreement between Darren
>> > Hart and Andy Shevchenko [3]
>> >
>> > [1] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-August/1
>> > 11704.html
>> > [2] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-October/
>> > 113936.html
>> > [3] http://mailman.alsa-project.org/pipermail/alsa-devel/2016-December
>> > /115892.html
>> >
>>
>> Stephen, I see no issues with the patches. If you want to push them
>> through your tree, take a tag from PDx86 subsystem point of view:
>
> Does PDx86 == platform device x86?

Yes.

> I can provide a stable branch
> in clk tree for platform tree, or platform x86 maintainer can ack
> the platform/x86 patches and I can take the whole batch through
> clk tree.

That's what I did. Do you need Darren's one?

>>
>> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko
