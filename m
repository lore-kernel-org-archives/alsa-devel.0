From: GitHub issues - opened <github@alsa-project.org>
Subject: Help with extplug transfer callback
Date: Tue, 13 Nov 2018 16:21:11 +0100 (CET)
Message-ID: <20181113152111.493EF267A9B@alsa0.perex.cz>
References: <1542122469370882034-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id BF3132678F7
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 16:21:09 +0100 (CET)
In-Reply-To: <1542122469370882034-webhooks-bot@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-lib issue #2 was opened from dchabot:

I've tried posting the following at alsa-users mailing list, but keep getting hit with "awaiting moderator approval" (I am registered to the list).

I'm trying to create an extplug and having trouble deciphering how the source and destination buffer reading/writing is supposed to be done in the transfer callback. My goal is to create an extplug that takes a stereo data stream, divides that into 6 or 8 output streams, and applies FIR filters to each output stream.

With the code I currently have (https://github.com/dchabot/extplug), trying to play a 1kHz tone results in a garbled, noisy mess. There is a tone in there, but it is a mess.

I started from the skeleton code here - http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_external_plugins.html. Note that the snd_pcm_extplug_create call here should be passing the "slave" variable, not "conf". That tripped me up for the better part of an hour.

I based my initial transfer callback (snd_pcm_extplug_callback_t.transfer member) on that found in the speex plugin. Initially I didn't notice that speex operated with single in/out channels, so you can imagine how that went.

Looking at another example of an extplug (https://github.com/dpapavas/alsaloudness), I noted that I should be iterating over each channel for src_areas and dst_areas. I just cannot see how this should be done properly. Is documentation for this critical step missing or simply hard to find. Seems kinda important to know how buffer operations should be done...

At this point, all I want to do is copy input channels to output channels. I'm grappling with the fact that this is more complicated than I initially thought, or perhaps more difficult than it should be.

My transfer callback currently looks like this:

```
/* copied from pcm-plugins/speex/pcm-speex.c */
static inline void* area_addr(const snd_pcm_channel_area_t *area, snd_pcm_uframes_t offset)
{
    unsigned int bitofs = area->first + area->step * offset;
    return (char *) area->addr + bitofs / 8;
}

static snd_pcm_sframes_t
transfer_callback(snd_pcm_extplug_t *ext, const snd_pcm_channel_area_t *dst_areas,
                             snd_pcm_uframes_t dst_offset, const snd_pcm_channel_area_t *src_areas,
                             snd_pcm_uframes_t src_offset, snd_pcm_uframes_t size)
{
    int C = ext->channels;
    short *src, *dst;
    for(int i = 0; i < C; i++) {
        src = area_addr(&src_areas[i], src_offset);
        dst = area_addr(&dst_areas[i], dst_offset);
        memcpy(dst, src, size);
    }
    return size;
}
```
Need a little help please.

Issue URL     : https://github.com/alsa-project/alsa-lib/issues/2
Repository URL: https://github.com/alsa-project/alsa-lib
