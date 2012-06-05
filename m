From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: Confusion about Playback/Capture, CODEC/CODEC links,
 and snd_soc_dapm_link_dai_widgets()
Date: Tue, 05 Jun 2012 15:17:15 -0600
Message-ID: <4FCE775B.7020901@wwwdotorg.org>
References: <4FC7F576.30101@wwwdotorg.org> <4FCE6B0F.6080106@wwwdotorg.org>
	<20120605204758.GA8486@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A40D4246EB
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2012 23:17:19 +0200 (CEST)
In-Reply-To: <20120605204758.GA8486@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 06/05/2012 02:48 PM, Mark Brown wrote:
> On Tue, Jun 05, 2012 at 02:24:47PM -0600, Stephen Warren wrote:
> 
>> Initially, I thought that snd_soc_dapm_new_dai_widgets() could just
>> return if the DAI already had widgets, but that doesn't work, since the
>> widgets were created for the wrong DAPM context - the I2S1 DAP DAI's
>> rather than the I2S CODEC's.
> 
>> Perhaps instead of blindly probing the CPU DAI, soc_probe_dai_link()
>> should check whether that DAI is part of a CODEC, and instead of calling
>> try_module_get() and snd_soc_dapm_new_dai_widgets(), it should just call
>> soc_probe_codec() on the parent CODEC (guarded by whether the CODEC was
>> already probed). Does that sound right? I'm attempting to make that work
>> now, in case it's right.
> 
> No, we should just probe CODECs sensibly before we do any of the DAIs
> instead of trying to guess what we're doing in the middle of handling
> the DAI links.  Your changes will be making the logic even more
> complicated here, it should be getting simpler - the reason this blew up
> for you is that the probe logic is already far too baroque.  Given the
> data we have it'll boil down to similar checks bit it'll be in a clear,
> comprehensible CODEC probe step rather than intertwined with other
> stuff.  This will also mean that aux_devs make more sense.

OK, that's actually what my inclination was, but I wasn't sure about
changing all the probing in such a radical way, so I didn't mention it.

So, should the logic be something like this early-ish in
snd_soc_instantiate_card():

for every dai link:
    if cpu side is a codec and it isn't probed
        probe it
    if codec side isn't probed
        probe it
something similar for aux devs
something similar for platforms?

And modify soc_probe_dai_link() to only probe DAIs, never anything else.

Is the following loop still required:

> 	/* early DAI link probe */
> 	for (order = SND_SOC_COMP_ORDER_FIRST; order <= SND_SOC_COMP_ORDER_LAST;
> 			order++) {

I'm not sure what the probe ordering stuff is achieving, and whether
it's really intended for just CPU DAIs, just all DAIs, just CODECS,
everything...
