From: Mylene Josserand <mylene.josserand@free-electrons.com>
Subject: Re: [PATCH v3 1/5] ASoC: sun8i-codec: Remove analog "HP" widget
Date: Tue, 21 Mar 2017 10:00:03 +0100
Message-ID: <1e24d943-adc1-259a-a4e3-99e480796213@free-electrons.com>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-2-mylene.josserand@free-electrons.com>
 <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170320173903.fc2m4euobea3npyq@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, maxime.ripard@free-electrons.com, wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, thomas.petazzoni@free-electrons.com, alexandre.belloni@free-electrons.com
List-Id: alsa-devel@alsa-project.org

Mark,

On 20/03/2017 18:39, Mark Brown wrote:
> On Sat, Mar 18, 2017 at 08:55:05AM +0100, Mylène Josserand wrote:
>> The "HP" widget is already present and take part to
>> the analog part (sun8i-codec-analog).
>>
>> Remove it from the digital part as it is unnecessary.
>
> I know I said to send against Linus' tree but it turns out this actually
> conflicts with some of the existing fixes, please see my fixes/sunxi
> branch and resend against that.  Sorry for the hassle here.
>

It does not apply because my driver ("sun8i-codec") is, currently, not 
available in your fix/sunxi branch:

https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/tree/sound/soc/sunxi?h=fix/sunxi

Should I apply the patches (which add my driver) as "dependencies" and 
indicate it in my cover letter? Let me know what I should do.

Thank you for the help!

Best regards,

-- 
Mylène Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
