From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v6 1/3] clk: x86: Add Atom PMC platform
 clocks
Date: Wed, 4 Jan 2017 18:54:42 -0600
Message-ID: <564d1f26-dd11-d237-7e63-87287a062c03@linux.intel.com>
References: <1481306510-7471-1-git-send-email-irina.tirdea@intel.com>
 <1481306510-7471-2-git-send-email-irina.tirdea@intel.com>
 <CAHp75Vdaw4yvTPP2JZc+ti-AVNsisRQ+WG=JxPQ1jv-r7DADQA@mail.gmail.com>
 <20161213232524.GQ5423@codeaurora.org>
 <32235fb3-0d54-211d-28f4-4655e4bc7812@linux.intel.com>
 <20161217013337.GW5423@codeaurora.org>
 <CAHp75Vdn_8_fCQzkG7CPrnDZzhC7WUpGM1cyvfNRz0u_sc7RKA@mail.gmail.com>
 <7f3d03dc-24fe-ec3f-4a3b-926c28f0ac86@linux.intel.com>
 <20161221230557.GK5423@codeaurora.org>
 <cd6044f5-6c79-b2d6-902d-52e27c217e78@linux.intel.com>
 <CAHp75VfJU3613euahjW-s92_XEz8hK70ZgRi53Lpo+2TWqPscA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAHp75VfJU3613euahjW-s92_XEz8hK70ZgRi53Lpo+2TWqPscA@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Len Brown <lenb@kernel.org>, Irina Tirdea <irina.tirdea@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michael Turquette <mturquette@baylibre.com>, "x86@kernel.org" <x86@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Mark Brown <broonie@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, platform-driver-x86@vger.kernel.org, linux-clk@vger.kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


>>>> this convention is suggested:
>>>>    PLT_CLK[2:0] - Camera
>>>>    PLT_CLK[3] - Audio Codec
>>>>    PLT_CLK[4] -
>>>>    PLT_CLK[5] - COMMs
> By the way, would I suggest to use same prefix as provider, i.e.
> pmc_atom_plt_clk_%d ?
I tried this suggestion and it doesn't work unfortunately. It looks like 
the struct clk_lookup_alloc is limited to 16 chars for the connector_id.
"pmc_a_plt_clk_" works but that's not really helping.
The suggestion would also require a patch on the audio side since the 
use of pmc_plt_clk_3 was already merged.
-> no change.
