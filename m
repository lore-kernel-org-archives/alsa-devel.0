From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PCM Plugin Channel question
Date: Wed, 02 Jul 2014 09:45:18 +0600
Message-ID: <53B3804E.7010804@gmail.com>
References: <B02206F4ACA2904A8270028316B8DAFF011CC286@mercury.corp.adaptivedigital.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f49.google.com (mail-la0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FAC7262618
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 05:45:21 +0200 (CEST)
Received: by mail-la0-f49.google.com with SMTP id gf5so6594775lab.36
 for <alsa-devel@alsa-project.org>; Tue, 01 Jul 2014 20:45:20 -0700 (PDT)
In-Reply-To: <B02206F4ACA2904A8270028316B8DAFF011CC286@mercury.corp.adaptivedigital.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brandon Yates <Brandon.Yates@adaptivedigital.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

02.07.2014 04:59, Brandon Yates wrote:

> Hello, I have developed a pcm ext plugin that applies some processing
> to the audio stream in the transfer callback.

Yes, this is how extplug is supposed to be used.

> My plugin works for a mono (1 channel) stream. I'd now like to expand
> it to support stereo data in the form of 2 channels interleaved.  I
> can't find much information on how this works.  I have a couple
> questions that I'd greatly appreciate if anyone could help with.
>
> 1) Is there any way in the 'SND_PCM_PLUGIN_DEFINE_FUNC' function that
> I can determine if the user application has opened the stream with 1
> channel vs 2 channel?

There certainly is such information, but not directly in 
SND_PCM_PLUGIN_DEFINE_FUNC. The code should be placed in the init 
callback. The argument of that callback has a parameter of type 
snd_pcm_extplug_t*, and that structure has a "channels" field.

You can use https://gitorious.org/dtsenc/dtsenc/source/alsaplugin.c as a 
model (but it needs to be updated to support channel maps). All actual 
processing is done in the dcaenc_convert_s32 function which is called by 
the transfer callback.

>
> 2) I assume in the case of two channels my transfer function would
> need to: a)deinterleave the data from source so my processing routine
> can access it in a linear buffer and b) reinterleave the data before
> I copy it to destination.   Is this correct? Is there more to it or
> things I am overlooking?

This is more-or-less correct. Just be sure to use the areas-related 
parameters to do deinterleaving correctly, because they can describe not 
only a simple interleaved format.

> 3) For IO-plugin I see there is a `SND_PCM_IOPLUG_HW_ACCESS` value I
> could use to restrict the stream type to
> `SND_PCM_ACCESS_RW_INTERLEAVED`.  Does there exist a similar function
> for External PCM Plugin?

You just don't have to apply this restriction.

SND_PCM_ACCESS_MMAP_INTERLEAVED will also work without any effort on 
your side, due to your transfer function being called on 
snd_pcm_mmap_commit. And, if you use the areas-related parameters 
correctly, the plugin will also work with planar or complex layouts.

<troll>
But... why are you writing an ALSA plugin? This means that your code 
will not be usable with PulseAudio out of the box, because PulseAudio 
can talk to custom PCMs only through module-alsa-sink, which means there 
will be no jack detection and similar card-related features.

Both ALSA and PulseAudio can wrap LADSPA plugins. Write that. And 
PulseAudio knows how to use N copies of a mono plugin to process an 
N-channel stream, so you don't have to deal with that yourself.
</troll>

-- 
Alexander E. Patrakov
