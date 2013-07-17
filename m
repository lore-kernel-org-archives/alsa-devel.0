From: Daniel Mack <zonque@gmail.com>
Subject: Re: Connecting two Codecs to the same CPU DAI
Date: Wed, 17 Jul 2013 11:16:22 +0200
Message-ID: <51E660E6.4010902@gmail.com>
References: <51E55925.5080208@gmail.com>
 <20130716162043.GS22506@sirena.org.uk> <51E575E3.3040409@gmail.com>
 <20130716165708.GT22506@sirena.org.uk> <51E57DD5.5040307@gmail.com>
 <20130716174703.GW22506@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f44.google.com (mail-ee0-f44.google.com [74.125.83.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 932B426513F
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 11:16:11 +0200 (CEST)
Received: by mail-ee0-f44.google.com with SMTP id c13so907759eek.31
 for <alsa-devel@alsa-project.org>; Wed, 17 Jul 2013 02:16:11 -0700 (PDT)
In-Reply-To: <20130716174703.GW22506@sirena.org.uk>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 16.07.2013 19:47, Mark Brown wrote:
> On Tue, Jul 16, 2013 at 07:07:33PM +0200, Daniel Mack wrote:
>> On 16.07.2013 18:57, Mark Brown wrote:
> 
>>>>> No, no feature here.  Off the top of my head I'd suggest soc-pcm plus a
>>>>> virtual DAI for the second link.
> 
>>>> That would still require userspace to open and configure both
>>>> subdevices, right?
> 
>>> Shouldn't.
> 
>> How so? As each link exposes its own PCM subdevice, how would codec of
>> link #1 get a hw_params call if an application just opens PCM subdevice
>> #0 for playback? This is the case I want to address.
> 
> Half the point of soc-pcm is to decouple the streams seen by the
> application layer from the DAIs that the driver sees so I'd expect us to
> be able to map a single application layer/memory stream onto multiple
> CODEC DAIs.  One front end connected to two back ends.

You're talking about DPCM, right? Unfortunately, there is no active user
of this in mainline, and no documentation either. I'll try and find out
how this is supposed to work first ...

Maybe Liam has some explanation ready?

>> By naive approach atm would be to just add .codec_names,
>> .codec_dai_names and .codec_of_node to snd_soc_dai_link, and make their
>> use mutually exclusive to the existing ones. That way, we don't need to
>> touch any existing user.
> 
> May as well bite the bullet and do the refactoring, it should be
> automatable.  There's also the fun of handling what happens when you
> want to stream from one CODEC to another but I think that's second
> stage...

Looking deeper into this, I'm not sure whether each of those codec
instances inside one snd_soc_dai_link should have it own runtime, of if
they should rather share one. The latter isn't straight-forward, as
current users simply access the codec from their callbacks as
rtd->codec_dai. However, open-coding routines to access the correct
codec from these callbacks is not nice at all either. Hmm.

Let's see if DPCM can help here.


Daniel
