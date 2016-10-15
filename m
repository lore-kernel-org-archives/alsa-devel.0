From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: struct snd_soc_codec_driver nested and duplicated
 fields
Date: Sat, 15 Oct 2016 12:23:32 +0200
Message-ID: <4ec846ed-acb8-5dda-fa0b-8e452ba88725@metafoo.de>
References: <CAPNHxoH1kFGwXhPhDTg5s1Y4mbJFsPbjkjR7RT+Aq7AvmFdWnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A757265DB7
 for <alsa-devel@alsa-project.org>; Sat, 15 Oct 2016 12:23:33 +0200 (CEST)
In-Reply-To: <CAPNHxoH1kFGwXhPhDTg5s1Y4mbJFsPbjkjR7RT+Aq7AvmFdWnw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian N <cnegris01@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/13/2016 04:06 PM, Christian N wrote:
> Hi
> 
> I'm tryng to understand serveral links between asoc structures to
> avoid bad codec/machine driver implementation (TEF663x for iMX6).
> 
> I saw that several structures have pointer to structures which one
> could have pointer to the first one, and serveral fields are
> duplicated.
> 
> Some examples
> 
> snd_soc_codec_driver->probe
> snd_soc_codec_driver->snd_soc_dapm_widget
> 
> but
> 
> snd_soc_codec_driver->snd_soc_component_driver->probe (duplicated?)
> snd_soc_codec_driver->snd_soc_component_driver->snd_soc_dapm_widget
> (duplicated?)
> 
> and
>  snd_soc_codec_driver->snd_soc_component_driver->snd_soc_dapm_widget->snd_soc_dapm_context->
> snd_soc_component (hey is recursive???!!!!!)
> 
> I would like figure out why several fields are duplicated in
> structures that could be nested.
> Is a compatibility issue?

Yes. ASoC is a framework that has grown over the years. In the past there
was no common base between different types of components. Later on struct
snd_soc_component was introduced as a common base. Some of the things
handled by snd_soc_component and snd_soc_component_diver were already
handled by the other structs, so there is a bit of duplication. We are
slowly phasing this duplication out, but this takes time and it is not
always as straight forward as just moving things from one struct to the
other as it does not solve the "real problems", but just causes code churn,
which pollutes the commit history. We have a tiny bit of compatibility code
in the core that is executed when a component and fixes the pointers up
depending on which are used and this works quite well. As I said eventually
it will go away, but there are some more complicated issues that need to be
addressed first.

And the current state is already pretty good, you should have seen it before
the cleanups, it was a lot more convoluted.

Some of the duplicated fields are also for usability. E.g. the
snd_soc_codec_driver probe callback takes a snd_soc_codec struct whereas the
snd_soc_component_driver probe callback takes a snd_soc_component. If you
are writing a codec driver you typically want to work on a snd_soc_codec, so
having the specialized avoids having to manually cast from snd_soc_component
to snd_soc_codec in each and every driver and reduces the amount of
boilerplate code.

Some of the backpointers you see are necessary and it's normal to have them,
e.g. in parent child relationships of objects, you typically have a pointer
from the parent to the children and from each child a pointer back to the
parent. In the case of snd_soc_dapm_context the snd_soc_component pointer
contains the component that should be used for IO.
