From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH 2/2] ASoC: simple-card: Add support for
 samplerate and samplewidth constraints
Date: Wed, 4 Mar 2015 09:56:24 +0200
Message-ID: <54F6BAA8.2010803@ti.com>
References: <cover.1425303942.git.jsarha@ti.com>
 <9d01aa0d0bf48d8b41d5086a7e6c9ec08c2b9c48.1425303942.git.jsarha@ti.com>
 <54F4C0F2.8000201@metafoo.de> <54F5884A.1090702@ti.com>
 <20150303113041.GM21293@sirena.org.uk> <54F5A25F.6090904@ti.com>
 <20150303153431.GA21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 05BFB264ED3
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2015 08:56:30 +0100 (CET)
In-Reply-To: <20150303153431.GA21293@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com
List-Id: alsa-devel@alsa-project.org

On 03/03/2015 05:34 PM, Mark Brown wrote:
> On Tue, Mar 03, 2015 at 02:00:31PM +0200, Jyri Sarha wrote:
>> On 03/03/2015 01:30 PM, Mark Brown wrote:
>
>>> ...this is more the point.  Perhaps the constraints language needs
>>> improvement here?
>
>> Improving constraint functionality would certainly help, however the way
>> that code works is beyond my understanding and I do not believe such an
>> improvement would be coming from anybody else any time soon either.
>
> It's probably worth putting together a description of the constraint and
> asking people like Takashi who understand the code - ideally it'd be
> easy to implement but I suspect you're right about timescales.
>

Now that Lars-Peter pointed me to the right direction, it seems there is 
a proper way to deal with issue after all.

>>> The trouble with this sort of interface is that it's a quick and dirty
>>> way for people to bodge around things rather than actually fixing them
>>> properly.  Of course sometimes fixing things properly is really hard and
>>> that means we want a temporary bodge but having to put them in DT is
>>> really unfortunate.
>
>> I agree with that. However, the simple-card binding goes already now quite a
>> bit beyond just describing the hardware. The binding for instance decides
>> the configuration that is going to be used over the dai-link. These
>> constraints could be seen as an extension to that configuration.
>
>> I am wondering if there would be some better way to select the dai-link
>> configuration than writing it to DT or creating a custom machine driver for
>> each setup.
>

Continuing this tought. I wonder if it would be better to introduce a 
new compatible match for each new card, with some clever way to manage 
the accumulating matches in the code, and hard code DAI-link 
configurations for each match. This way the old configurations would not 
be carved to stone in the old dtbs.

>> But about this patch. Should I just give it up, or would you be willing to
>> apply it if I improve the description more and add a warning against using
>> these properties to work around driver bugs to the binding document?
>
> I'm not totally against the idea so it's worth continuing.  Just not
> happy either but computer.
>
> It just occurred to me that we may be able to sidestep the issue by
> calling them "suggested rates/widths" so the implementation can ignore
> them later.  That's a *tiny* bit gross but does sidestep the ABI issues.
>

As there is a proper way to deal with this, I'll look into that first. 
However, if there still is a need for these properties I am happy to 
finish the patch.

Best regards,
Jyri
