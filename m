From: Mark Salyzyn <salyzyn@android.com>
Subject: Re: [PATCH v2] ALSA: seq: resize buffer for overflow
Date: Mon, 9 Oct 2017 07:51:40 -0700
Message-ID: <aed0990f-1180-9585-85ab-d547668f9e7c@android.com>
References: <20171006171731.88889-1-salyzyn@android.com>
 <s5htvzbnvo3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5htvzbnvo3.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, bunk@kernel.org, Jaroslav Kysela <perex@perex.cz>, bunk@stusta.de
List-Id: alsa-devel@alsa-project.org

On 10/07/2017 02:39 AM, Takashi Iwai wrote:
> I doubt it came from snd_midi_event_encode_byte().
> Judging from the call trace below, the event originated from the OSS
> sequencer write, i.e. it received an OSS event packet, and it was
> delivered again to another OSS sequencer port back via dummy client.
>
> If so, it should have received some EV_SYSEX packet, and it was
> processed via snd_seq_oss_synth_sysex(), and the encoded event was
> delivered.
>
> Now the question is how it triggers this Oops.  I couldn't find any
> obvious cause, but one thing I noticed is a possible race when writing
> to OSS sequencer concurrently.  Something wrong might happen.

Concurrent writing, thanks, I will switch gears and see if that 
represents the replication path!
> BTW, about your patch is buggy regarding the call kmalloc() with
> GFP_KERNEL inside spinlock.

<urrrrk> yup, withdraw this patch, and please erase it from my permanent 
record ;->

Thanks for the review, it was immensely helpful!

-- Mark
