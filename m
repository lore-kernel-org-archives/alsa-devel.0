From: Pierre-Louis Bossart <pierre-louis.bossart-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rt5640: add master clock handling for
 rt5640
Date: Wed, 24 Feb 2016 10:10:05 -0600
Message-ID: <56CDD5DD.6040006@linux.intel.com>
References: <1456190782-18865-1-git-send-email-sugar.zhang@rock-chips.com>
 <56CC719C.1090901@linux.intel.com> <2199435.lA9iTvxnKV@phil>
 <20160224033259.GL18327@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160224033259.GL18327-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 2/23/16 9:32 PM, Mark Brown wrote:
> On Wed, Feb 24, 2016 at 12:08:31AM +0100, Heiko Stuebner wrote:
>> Am Dienstag, 23. Februar 2016, 08:50:04 schrieb Pierre-Louis
>> Bossart:
>
>>> This patch assumes that the information on mclk comes from
>>> DeviceTree. The mclk may also be enabled/disabled in the machine
>>> driver with an explicit transition to use an internal clock when
>>> the codec is not used. I hope this patch doesn't preclude such
>>> usages or there will be a conflict with the patches we are about
>>> to upstream for Baytrail/cht devices.
>
>> As you can see, the clock property itself is optional and the
>> clk_get below acts accordingly of also continuing if the clock is
>> not present. So it won't affect any users doing it otherwise.
>
> That said we really do need x86 to transition to use the clock API
> in order to integrate with external devices, where the machine driver
> does manage clocks we want that to move to being done using the clock
> API rather than custom APIs.

For Baytrail audio we have a single platform clock that can be turned
on/off and set to 19.2 MHz or 25 MHz. No other controls are available,
no multipliers or complicated dependencies on other clocks, parents or 
children and no other users for this clock but the audio subsystem.
I looked at the clock framework and couldn't figure out how it would 
simply map the hardware so for now the use of the MCLK is only enabled 
with an on/off or set-rate(19.2|25) custom API. I am not an expert here 
so if this clock framework becomes a requirement to upstream code I 
would appreciate any pointers to do the right thing. I really couldn't 
find a simple example with 'Put your code here' comments to use this 
framework.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
