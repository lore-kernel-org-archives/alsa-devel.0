From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH v3 4/5] ASoC: tda998x: adjust the audio hw
	parameters from EDID
Date: Wed, 05 Feb 2014 14:31:09 +0100
Message-ID: <52F23D1D.7040804@metafoo.de>
References: <cover.1391274627.git.moinejf@free.fr>
	<1b15025671d9099863a3091346536e45891e4a26.1391274628.git.moinejf@free.fr>
	<20140204180625.GM22609@sirena.org.uk>
	<20140205101134.4591e5c3@armhf> <52F2021A.9020804@metafoo.de>
	<20140205111814.GF22609@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20140205111814.GF22609@sirena.org.uk>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 02/05/2014 12:18 PM, Mark Brown wrote:
> On Wed, Feb 05, 2014 at 10:19:22AM +0100, Lars-Peter Clausen wrote:
[..]
>> Bonus points for making this a generic helper function that takes a
>> runtime and a EDID and then applies the EDID constraints on the
>> runtime.
>
> ...as previously requested.  I know there was some discusion of broader
> moves to factor this stuff out but it'd still be good to keep it
> separated out even prior to a final non-EDID based solution so it's
> easier to refactor.

I think it will always be EDID (or ELD) based. As I understood it the 
re-factoring Takashi was talking about is related to how this data is passed 
from the graphics driver to the audio driver. The way things work right now 
in HDA land is that the graphics driver reads the EDID from the monitor, 
converts it to ELD and writes it to a special memory region in the graphics 
controller. This generates an interrupt in the audio driver and the audio 
driver reads the ELD from the hardware and sets up the constraints based on 
that. And I think that the plan is to change this to pass the EDID directly 
from the graphics driver to the audio driver without taking the detour 
through the hardware. This is what we'll need for embedded systems anyway. A 
system that allows to associate a sound driver with a specific HDMI port and 
status updates for that port, e.g. new EDID or cable connected/disconnected 
are passed from the graphics driver handling that port to the audio driver.

- Lars
