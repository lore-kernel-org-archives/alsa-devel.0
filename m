From: Martin Schreiber <mse00000@gmail.com>
Subject: Re: [BUG] snd_pcm_drop() does not stop the PCM
 immediately
Date: Wed, 14 Mar 2018 16:50:48 +0100
Message-ID: <332672f7-eabb-73a2-9f76-d03e8c9c253c@gmail.com>
References: <32cead2b-d2fc-485f-70e9-e528bc2fe63e@gmail.com>
 <s5hvady8zbk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D80C626708E
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 16:50:51 +0100 (CET)
Received: by mail-wm0-f65.google.com with SMTP id w128so5031779wmw.0
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 08:50:51 -0700 (PDT)
In-Reply-To: <s5hvady8zbk.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/14/2018 04:13 PM, Takashi Iwai wrote:
> 
> It's a best-effort base stopping mechanism with dmix, so it's a sort
> of expected behavior, unfortunately.  Due to its nature of
> implementation, scratching off the existing data from the mixed buffer
> isn't so trivial for now.
> 
eSpeakNG has the workaround in pcaudiolib (see outcommented part):
"
int
alsa_object_flush(struct audio_object *object)
{
	struct alsa_object *self = to_alsa_object(object);
	if (self && self->handle){
		snd_pcm_drop(self->handle);
	}
/*
	if (!self) return 0;

	// Using snd_pcm_drop does not discard the audio, so reopen the device
	// to reset the sound buffer.
	if (self->is_open) {
		audio_object_close(object);
			//this crashes write operation in other thread!
		return audio_object_open(object, self->format, self->rate,
self->channels);
	}
*/
	return 0;
}

"
"
void
alsa_object_close(struct audio_object *object)
{
	struct alsa_object *self = to_alsa_object(object);

	if (self->handle) {
		snd_pcm_close(self->handle);
		self->handle = NULL;
		self->is_open = 1;
	}
}
"
Does snd_pcm_close() "scratching off the existing data from the mixed
buffer"? If yes, how could the workaround be made without letting crash
pending write operations in separate thread?

Thanks, Martin
