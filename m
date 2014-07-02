From: "Brandon Yates" <Brandon.Yates@adaptivedigital.com>
Subject: Re: PCM Plugin Channel question
Date: Wed, 2 Jul 2014 09:25:40 -0400
Message-ID: <B02206F4ACA2904A8270028316B8DAFF01149F05@mercury.corp.adaptivedigital.com>
References: <B02206F4ACA2904A8270028316B8DAFF011CC286@mercury.corp.adaptivedigital.com>
 <53B3804E.7010804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta12.messagelabs.com (mail1.bemta12.messagelabs.com
 [216.82.251.1]) by alsa0.perex.cz (Postfix) with ESMTP id B71D0264F0F
 for <alsa-devel@alsa-project.org>; Wed,  2 Jul 2014 15:25:42 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <53B3804E.7010804@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Alex -  thanks. That was helpful. One follow up question.

> if you use the areas-related parameters correctly, the plugin will
also work with planar or complex layouts.


I am not sure if I'm using snd_pcm_channel_area_t correctly. I don't
really understand all the fields.  For 1 channel setup I stole the
following function from the speex plugin 

static inline void *area_addr(const snd_pcm_channel_area_t *area,
			      snd_pcm_uframes_t offset)
{
	unsigned int bitofs = area->first + area->step * offset;
	return (char *) area->addr + bitofs / 8;
}

This works for 1 channel but I don't understand how I would use area for
interleaved data.  My thoughts are just take the returned address from
area_addr then use a for loop separating out odd and even shorts.   Is
there a better way?



Will consider your points about PulseAudio too.  This plugin is
targeting embedded arm-linux systems so I'm not totally sure if Pulse
would even be used.



-----Original Message-----
From: Alexander E. Patrakov [mailto:patrakov@gmail.com] 
Sent: Tuesday, July 01, 2014 11:45 PM
To: Brandon Yates
Cc: ALSA Development Mailing List
Subject: Re: [alsa-devel] PCM Plugin Channel question

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
