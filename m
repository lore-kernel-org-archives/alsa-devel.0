From: Lori Hikichi <lori.hikichi@broadcom.com>
Subject: Re: [PATCH 2/9] ASoC: cygnus: Update bindings for audio clock changes
Date: Tue, 15 Aug 2017 12:29:44 -0700
Message-ID: <d7e7144b-26c7-b96a-663d-03744bb60c36@broadcom.com>
References: <1502748417-26417-1-git-send-email-lori.hikichi@broadcom.com>
 <1502748417-26417-3-git-send-email-lori.hikichi@broadcom.com>
 <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170815171424.whcy4mftex6sgzgj@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 8/15/2017 10:14 AM, Mark Brown wrote:
> On Mon, Aug 14, 2017 at 03:06:50PM -0700, Lori Hikichi wrote:
>> Allow each audio port to select which clock (if any) it wants to use.
> Why is this in DT for the port and not either using standard clock
> bindings to configure the clock tree or allowing the machine driver to
> pick?
The previous version of the driver essentially had a clock mapping
that could not be changed. This is fine for 99% of our use cases. 
If we need to change the mapping, then we need to modify the audio
port's clock mux. Creating a clock for these muxes was going to be messy.
There is a mux per audio port and the registers used to program the
muxes are staggered throughout the io space used by the audio driver.
Additionally, these registers have bits that are controlled by the
audio driver. Had I used syscon to access these registers this would
have resulted in a very fragmented io space, complicating the audio
drivers access this space.
I have put the mux assignment in DT because the assignment is a
static property and did not need run time programmability from the
machine driver.

Lori.
