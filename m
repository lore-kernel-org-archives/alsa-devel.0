From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Mon, 16 Mar 2015 22:24:37 +0900
Message-ID: <5506D995.1030004@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506C0D5.7000909@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 71F31260A5D
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 14:24:42 +0100 (CET)
In-Reply-To: <5506C0D5.7000909@zamaudio.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien@zamaudio.com>, clemens@ladisch.de, tiwai@suse.de, robin@gareus.org
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Damien,

On Mar 16 2015 20:39, Damien Zammit wrote:
> On 16/03/15 03:01, Takashi Sakamoto wrote:
>> Digi 002/003 family uses own way to multiplex PCM samples into data
>> blocks in CIP payload for received stream, thus AMDTP-conformant
>> implementation causes noisy sound.
>>
>> This commit applies double-oh-three algorism, which discovered by Robin
>> Gareus and Damien Zammit in 2012.
>>
>> As long as I tested, this patch still has disorder that:
>>  * 1st PCM channel still causes noise in 2nd PCM channel.
>>  * At 88.2/96.0kHz, any PCM channels still causes noise in the other PCM
>>    channels.
> 
> Can you please double check, I dont think snd_dg00x_protocol_write_s32()
> is even being called because amdtp.c needs a small change to prevent
> overriding the transmit_samples function pointer.

This line overwrites the default callback function with driver-specific
function every time to start streams, thus the driver-specific function
is used for out-stream.

On Mar 16 2015 01:01, Takashi Sakamoto wrote:
> diff --git a/sound/firewire/digi00x/digi00x-stream.c b/sound/firewire/digi00x/digi00x-stream.c
> index 410b971..bc4c88c 100644
> --- a/sound/firewire/digi00x/digi00x-stream.c
> +++ b/sound/firewire/digi00x/digi00x-stream.c
> @@ -204,6 +204,8 @@ static int keep_resources(struct snd_dg00x *dg00x, unsigned int rate)
>  	dg00x->rx_stream.midi_position = 0;
>  	dg00x->tx_stream.midi_position = 0;
>  
> +	/* Apply doubleOhThree algorism. */
> +	dg00x->rx_stream.transfer_samples = snd_dg00x_protocol_write_s32;
>  	dg00x->rx_stream.transfer_midi = snd_dg00x_protocol_fill_midi;
>  	dg00x->tx_stream.transfer_midi = snd_dg00x_protocol_pull_midi;


Regards

Takashi Sakamoto
