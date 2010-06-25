From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: [PATCH] Two patches for Alsa-plugins (pulse)
Date: Fri, 25 Jun 2010 12:41:46 +0200
Message-ID: <4C2487EA.3090605@epost.diwic.se>
References: <4C22670D.8010104@epost.diwic.se> <s5h6319dj90.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp01.sth.basefarm.net (ch-smtp01.sth.basefarm.net
	[80.76.149.212]) by alsa0.perex.cz (Postfix) with ESMTP id 2F2D92455C
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 12:42:18 +0200 (CEST)
In-Reply-To: <s5h6319dj90.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2010-06-24 08:42, Takashi Iwai wrote:
> At Wed, 23 Jun 2010 21:57:01 +0200,
> David Henningsson wrote:
>>
>> These two patches are being used in Ubuntu Lucid (released this April)
>> and are working well enough to have people asking us to backport them to
>> Karmic. Today I got an email, asking for the upstream status of one of
>> these patches, since he wanted them in Fedora. If posting them here
>> isn't the correct way to upstream them, please tell me so.
>>
>> The first one (Fix invalid buffer pointer return value) fixes broken logic:
>>
>> This patch improves recovering from underruns, and prevents hangs inside
>> snd_pcm_write* and snd_pcm_read* due to snd_pcm_avail* returning too
>> low values. It especially helps low latency situations.
> 
> This one looks OK.  Applied now.

Thanks!

>> The second one (Do not report underruns to the ALSA layer) is more a
>> change of behavior, which could be questioned. The arguments for
>> removing that code are these:
>>
>>  * If pulseaudio gets an underrun, the normal way to end that underrun
>> is to feed it with more buffers. This is different from the ALSA way of
>> dealing with underruns, which requires hardware buffer pointers to be reset.
>>  * In addition, underrun signals are delivered asynchronously from
>> pulseaudio. This means that there might be more buffers on the way to
>> pulseaudio when the underrun is reported, making the underrun obsolete.
>> Unfortunately, there is currently no known way to determine whether this
>> is the case or not.
> 
> I think this helps for normal use-cases, so it'd be good to apply.
> But, I prefer having a runtime option for such a behavior change
> (although the default value can be the new behavior).
> 
> Care to add it?

Sure, I can do that - it sounds like a good idea to have it configurable.
Just so I understand you right, exactly how do you expect the user /
application to configure it?

// David
