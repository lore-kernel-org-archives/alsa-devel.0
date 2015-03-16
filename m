From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 11/11] ALSA: digi00x: apply double-oh-three
 algorism to multiplex PCM samples
Date: Tue, 17 Mar 2015 01:25:45 +0900
Message-ID: <55070409.8090107@sakamocchi.jp>
References: <1426435269-17059-1-git-send-email-o-takashi@sakamocchi.jp>
 <1426435269-17059-12-git-send-email-o-takashi@sakamocchi.jp>
 <5506E7EE.6060300@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 72D4126145B
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2015 17:25:48 +0100 (CET)
In-Reply-To: <5506E7EE.6060300@gareus.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robin Gareus <robin@gareus.org>
Cc: tiwai@suse.de, damien@zamaudio.com, clemens@ladisch.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Robin,

Thanks for your comment. I have a necessity to understand your algorithm
for better implementation.

On Mar 16 2015 23:25, Robin Gareus wrote:
>> +void snd_dg00x_protocol_write_s32(struct amdtp_stream *s,
>> +				  struct snd_pcm_substream *pcm,
>> +				  __be32 *buffer, unsigned int frames)
>> +{
>> +	struct snd_pcm_runtime *runtime = pcm->runtime;
>> +	unsigned int channels, remaining_frames, i, c;
>> +	const u32 *src;
>> +	static struct dot_state state;
> 
> There's no need to declare this as static. The state is per frame.
> 
>> +	channels = s->pcm_channels;
>> +	src = (void *)runtime->dma_area +
>> +			frames_to_bytes(runtime, s->pcm_buffer_pointer);
>> +	remaining_frames = runtime->buffer_size - s->pcm_buffer_pointer;
>> +
>> +	for (i = 0; i < frames; ++i) {
> 
> ..it is zeroed here, anyway:
> 
>> +		dot_state_reset(&state);

Here, I'm consider about the usage of kernel stack. But for this purpose
it may be better to use the stack because it's never nested calls.

>> +		for (c = 0; c < channels; ++c) {
>> +			buffer[s->pcm_positions[c]] =
>> +					cpu_to_be32((*src >> 8) | 0x40000000);
>> +			dot_encode_step(&state, &buffer[s->pcm_positions[c]]);
>> +			src++;
>> +		}
>> +
>> +		buffer += s->data_block_quadlets;
>> +		if (--remaining_frames == 0)
>> +			src = (void *)runtime->dma_area;
>> +	}
>> +}
> 
> 
> In any case, the algorithm to xor-encode the digidesign data is not yet
> 100% correct there. One will need to continue iterating after the last
> channel (feeding zero) until the state->carry (dot_scrt()) is 0x00.
> 
> The current code here only works only correctly for data on the first 4
> chanels (18 [total channels] - 14 [max xor-chain length]).

Hm. Actually, I can hear better sounds in 1/2 ch as long as I aplayback
to the first 4 ch. When 5 or later channels get PCM samples, I can hear
noisy sound in the 1 ch (maybe 2 or more).


This is an sample of CIP packet which Windows driver transmit to Digi
002 Rack, at 96.0 kHz. The first line shows CIP header. One of the other
line shows one data block.

I put 24 bit PCM samples into 7th Multi Bit Linear Audio (MBLA) data
channel (8th data channel). The other channels includes zero samples
except for MIDI conformant data channel (first data channel).

020B0090 9004E400
80000000 40005100 40003F00 40000000 40000000 40000000 40000000 4011C5E4
4000DB00 4000E400 40001C00
80000000 40002300 4000BD00 4000A200 40000E00 40006100 4000FF00 40116AFC
4000F500 40008B00 40007400
80000000 40005C00 40003300 40004D00 4000C200 4000DE00 4000E100 4011DDE1
4000E200 40001E00 40002100
80000000 4000BF00 40000000 40000000 40000000 40000000 40000000 4012DF19
40000000 40000000 40000000
80000000 40000000 40000000 40000000 40000000 40000000 40000000 40146531
4000FB00 40008400 40007C00
80000000 40005300 40003D00 40004200 4000CE00 4000D100 4000EF00 4015B003
40000000 40000000 40000000
80000000 40000000 40000000 40000000 40000000 40000000 40000000 40162CFB
4000B300 4000AD00 40000200
80000000 40006E00 4000F100 40008F00 40000000 40000000 40000000 4015C4F8
4000DC00 4000E300 40001D00
80000000 40002200 4000BE00 4000A100 40000F00 40000000 40000000 4014EC69
40001300 40002D00 4000B200
80000000 4000AE00 40000100 40006F00 40000000 40000000 40000000 40143EE8
40004100 4000CF00 40000000
80000000 40000000 40000000 40000000 40000000 40000000 40000000 401408D0
40006700 4000F900 40008600
80000000 40007A00 40005500 40003B00 40004400 4000CC00 4000D300 4014C0B6
40000000 40000000 40000000
80000000 40000000 40000000 40000000 40000000 40000000 40000000 40146A74
4000F500 40008B00 40007400
80000000 40005C00 40003300 40004D00 4000C200 4000DE00 4000E100 40148837
40007700 40005900 40003600
80000000 40004A00 4000C500 4000DB00 4000E400 40001C00 40002300 401414CA
40002C00 4000B300 4000AD00
80000000 40000200 40006E00 4000F100 40008F00 40000000 40000000 401493B0
40009D00 40009200 40009E00

We can see the data in 7th MBLA data channel influences data in next
data block (data block is represented as 'frame' in driver code). The
pattern is what you discovered. In my understanding, this is the lack of
my implementation.

Do you mean this issue?


Thanks

Takashi Sakamoto
