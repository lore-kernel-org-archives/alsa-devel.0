From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK plugin] jack: Do not Xrun the ALSA buffer
Date: Tue, 13 Mar 2018 09:34:41 +0100
Message-ID: <1520930084-17449-1-git-send-email-twischer@de.adit-jv.com>
References: <1520007674-14618-4-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 1CA9A2670F8
 for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2018 09:35:15 +0100 (CET)
In-Reply-To: <1520007674-14618-4-git-send-email-twischer@de.adit-jv.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hello Takashi,

Now I have compiled and tested the patchies successfully.
Some minor adaption where required.
I have incorporated all your findings.


> Please try to format the text a bit nicer.  These line breaks appear
> like you're writing a poem :)i

Done.


> You don't need to put inline unless it's really mandatory.

Done.


> Hm, this whole stuff would fit better in ioplug code itself instead of
> open-coding in each plugin.  Maybe providing a new helper function?

I am providing a new helper function called snd_pcm_ioplug_hw_avail()
and I am reusing internally already existing functions.


> Ditto.  Basically the whole procedure here is some common pattern, so
> it wouldn't be too bad to have it in ioplug side.

I have provided a new area copy function which takes care about the buffer wrap around.
This function is called snd_pcm_areas_copy_wrap().
This reduces the complexity of the JACK IO plug a lot.
I have also compared the new implementation with other ALSA IO plugins.
I could not found more simuilarities because not all plugins are creating a snd_pcm_channel_area_t for the DMA/HW buffer.
Therefore functions like snd_pcm_areas_silence() and snd_pcm_areas_copy() cannot be used.
For example the pulse IO plug is also not using snd_pcm_channel_area_t for the pulse buffer.

I hope you are fine with these changes, now.
If not it would be great if you could give me a feedback in time.

Best regards

Timo
