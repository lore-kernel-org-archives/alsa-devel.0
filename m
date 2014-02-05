From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw
	parameters from EDID
Date: Wed, 05 Feb 2014 19:21:23 +0100
Message-ID: <52F28123.1080102@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr>
	<1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
	<20140204180625.GM22609@sirena.org.uk>
	<20140205101134.4591e5c3@armhf> <52F2021A.9020804@metafoo.de>
	<20140205190732.5617f200@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140205190732.5617f200@armhf>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 02/05/2014 07:07 PM, Jean-Francois Moine wrote:
> On Wed, 05 Feb 2014 10:19:22 +0100
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>>> So, in the CODEC, I don't see how I could update the parameters
>>> dictated by the EDID otherwise in changing the DAI driver parameters.
>>>
>>
>> The startup function is the right place. But instead of modifying the DAI
>> use snd_pcm_hw_constraint_mask64(), snd_pcm_hw_constraint_list(), etc. to
>> setup the additional constraints that come from the EDID.
>
> It is more complicated, but it works. Nevertheless, I have 2 problems:
>
> - snd_pcm_hw_constraint_list() keeps a pointer to the list, so, it
>    cannot be in the stack. It fix this with static struct and rate array.
>

Right. If the struct is modified though it should be per device and not 
global. I think the best way to implement this is to make the array static 
and specify a mask for the constraint based on the EDID. E.g.

static unsigned int hdmi_rates[] = {
	32000,
	44100,
	48000,
	88200,
	96000,
	176400,
	192000,
};

rate_mask = 0;

while (...) {
	...
	rate_mask |= 1 << sad[1];
}

rate_constraints->list = hdmi_rates;
rate_constraints->count = ARRAY_SIZE(hdmi_rates);
rate_constraints->mask = rate_mask;

> - snd_pcm_hw_constraint_mask64() is not exported.
>    Is there an other way to set constraints on the formats/sample widths?

I think that's a bug. Both snd_pcm_hw_constraint_mask() and 
snd_pcm_hw_constraint_mask64() should be exported. Can you send a patch?

- Lars
