From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Wed, 6 Dec 2017 10:06:34 -0600
Message-ID: <561a6ebd-c978-c52a-a13a-3300be9a58bb@ti.com>
References: <20171205181448.18513-1-afd@ti.com>
 <20171205181448.18513-2-afd@ti.com> <20171206123908.GB1827@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206123908.GB1827@finisterre>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 12/06/2017 06:39 AM, Mark Brown wrote:
> On Tue, Dec 05, 2017 at 12:14:46PM -0600, Andrew F. Davis wrote:
>> Platform ASoC drivers are a lot like ASoC CODEC drivers in that they
>> both are independent pieces of a sound device, or "machine". Platform
>> drivers should be free of CODEC specifics and visa-versa. Both are then
>> used by the the "machine" driver to form the complete sound device.
>> This forms a hierarchy that makes it natural to group platform drivers
>> into their own directory, much like we group CODEC drivers already.
> 
> This seems like a step backwards, and your current patch set only does
> this for the TI drivers anyway.  Currently we have things split up by IP
> holder, with machine drivers that have some platform specifics grouped
> together with the matching IP drivers that may also share some platform
> specific considerations.  This would group all the IP drivers together
> and separate them from the machine drivers they work in concert with for
> no obvious benefit.
> 

My current patches are an RFC with a couple examples, so I only moved
two TI platforms that I was familiar with, others would follow.

Your wording seems a bit inconsistent to me, what do you mean by "IP
drivers", CODEC or SoC internal IP? For clarity I'll try to use only the
three driver type labels: codec, platform, and machine. This is all in
Documentation/sound/soc/overview.rst which I'm sure you are familiar
with as you seem to have had a hand in writing it.

Anyway, I'm working under the assumption that we should try to enforce a
logical separation between component drivers: codec drivers should be
agnostic to what machine they are placed, platform drivers should do the
same and not make special arrangements to work with one machine in
particular. Machine drivers on the other hand will need to dig into
specifics of the codec and platform drivers that they use and connect.

With this in mind I do not see any reason not to have platform drivers
in a platforms/ directory just like we do with codecs/. In case there
was any confusion, I still want to keep the platform drivers' files all
grouped in directories by IP holder, just moved under this platforms/.

This has the benefit of reducing exactly what you are talking about,
platform drivers working in concert with machine drivers, instead of the
other way around.

This isn't only confusing to me, but other first time ASoC devs:
https://stackoverflow.com/questions/20110801/asoc-drivers-which-files-are-platform-machine-and-codec-drivers

even the answerer seems to assume there is a
sound/soc/platforms/, for the same reason we have sound/soc/codecs/.

> If you want to make a common directory for TI stuff do that, there's no
> need to mess up all the other platforms to do that though.
> 

Do you mean sounds/soc/ti/{platforms,machines}/ ? I could do this, but I
don't see how what I've done in my example patches has any effect on
other IP holders, they are free to migrate as the please.
