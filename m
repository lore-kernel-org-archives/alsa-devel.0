From: Floris Bos <bos@je-eigen-domein.nl>
Subject: Re: Fixing snd_pcm_indirect_playback_transfer to
 support rewinds?
Date: Tue, 2 Jan 2018 22:46:16 +0100
Message-ID: <cf70d779-833d-80bf-4906-f3e64ae3d95e@je-eigen-domein.nl>
References: <e8036085-44f7-d491-980a-efde3e9b46f4@je-eigen-domein.nl>
 <s5hzi5w9xr0.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.je-eigen-domein.nl (mx2.je-eigen-domein.nl [85.10.196.86])
 by alsa0.perex.cz (Postfix) with ESMTP id 776DC26719C
 for <alsa-devel@alsa-project.org>; Tue,  2 Jan 2018 22:46:20 +0100 (CET)
In-Reply-To: <s5hzi5w9xr0.wl-tiwai@suse.de>
Content-Language: en-GB
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

On 01/02/2018 02:49 PM, Takashi Iwai wrote:
>
>> It seems it is simply denying rewinds instead of making them work?
>> Isn't there any way to make them work, instead of disabling
>> functionality userspace seems to be expecting to have?
> The rewind can't work with the indirect PCM mode due to its nature.
> In the indirect PCM operation, the data has been already copied, thus
> you can't go back beyond the point.

Ah, didn't know it consumed all data right away inside the function.
The construct with sw_ready/hw_ready/hw_queue_size variables gave me the 
impression it could also only process a part and leave the rest for a 
next call.


BTW another thing that I noticed, is that it currently is only possible 
for a sound driver to report either success or failure from the ack 
callback.
While the userspace documentation seems to suggest that partial success 
-in which a lower number of frames than requested is rewinded- is also a 
possibility.

https://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.html#ga6c66040dbe01797379436fdf36268fec

==
Returns:
a positive number for actual displacement otherwise a negative error code
==



>
> In general, the application can't expect that rewind always works on
> such a device.  That said, it's rather a bug of PulseAudio, I'd say.
>
> Maybe an easy workaround would be to disable the timer-based mode on
> PA, e.g. by adding SNDRV_PCM_INFO_BATCH flag to the PCM stream, a
> patch like below.  You'd need a similar change for the downstream
> drivers.

Will have a look at that later when I have more time.



Yours sincerely,

Floris Bos
