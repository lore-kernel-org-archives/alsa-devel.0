From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Different codecs for playback and capture?
Date: Wed, 03 Jun 2015 16:26:07 +0200
Message-ID: <556F0E7F.80802@metafoo.de>
References: <alpine.DEB.2.02.1506031045380.22011@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 88AE62606B7
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2015 16:26:09 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1506031045380.22011@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/03/2015 01:06 PM, Ricard Wanderlof wrote:
>
> Hi,
>
> I'm developing a machine driver for a system where we have two different
> codecs for input and output, connected to the same I2S interface. Normally
> a machine driver specifies which codec the I2S interface is connected to,
> but in this case there should really be two different ones, one for record
> and one for playback. I'm working on how to put this together, and just
> thought I'd try and get some input before going too far down the wrong
> track. The options I see are:
>
> 1. Specify two different codecs in the machine driver. Since one can
> specify several dai_links this would seem to be doable, however, I'm not
> sure ALSA can handle two codecs sharing a single CPU DAI in this way?
>
> 2. Use two separate machine drivers, one for each codec? Again, sharing a
> single CPU DAI would seem to be an issue here?
>
> 3. Write a special codec driver that is a merge between the two codecs,
> one for input and one for output. Seems like a bit of a hack, but should
> be possible.
>
> Any spontaneous thoughts?

Hi,

There has been support for multiple CODECs on the same DAI link for a while 
now. Have a look at 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=88bd870f02dff5c9445286e185f21873f25a977f.

Instead of setting the codec_name/codec_dai_name fields in the dai_link 
create a snd_soc_link_component array with a entry for each of the CODECs 
and assign that to the codecs field in the DAI link.

I'm not too sure how well it works if one CODEC is playback only and the 
other is capture only and there might be some issues. But this is the way to 
go and if there are problems fix them.

- Lars
