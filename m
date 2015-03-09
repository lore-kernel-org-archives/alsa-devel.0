From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: dice: fix wrong offsets for Dice
	interface
Date: Mon, 09 Mar 2015 22:11:48 +0900
Message-ID: <54FD9C14.1040103@sakamocchi.jp>
References: <1425201136-24461-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hegp9gi67.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 866A526060F
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 14:11:53 +0100 (CET)
In-Reply-To: <s5hegp9gi67.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mar 1 2015 18:50, Takashi Iwai wrote:
> At Sun,  1 Mar 2015 18:12:16 +0900,
> Takashi Sakamoto wrote:
>>
>> For received packet stream, the offset of 'RX_SEQ_START' locates after
>> the offset of 'RX_NUMBER_MIDI', although current macro and proc output
>> includes wrong offsets.
>>
>> Fortunately, this bug doesn't affect streaming functionality because
>> these macro is not used.
>>
>> This commit fixes these wrong macro and outputs.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> 
> Applied, thanks.
> 
> 
> Takashi

I realized this commit is completely wrong. These addresses were true
but I did mis-operations to confirm it. Would you please revert this commit?

Against my previous comment, 'RX_NUMBER_AUDIO' is used in
dice_read_mode_params(). This wrong patch causes mis-detection of
audio/midi data channels (usually RX_SEQ_START is zero, therefore the
number of audio data channel is detect zero, wrongly), thus Dice driver
becomes to work badly, sorry...


Regards

Takashi Sakamoto

>> ---
>>  sound/firewire/dice/dice-interface.h | 18 +++++++++---------
>>  sound/firewire/dice/dice-proc.c      |  4 ++--
>>  2 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/sound/firewire/dice/dice-interface.h b/sound/firewire/dice/dice-interface.h
>> index 27b044f..de7602b 100644
>> --- a/sound/firewire/dice/dice-interface.h
>> +++ b/sound/firewire/dice/dice-interface.h
>> @@ -299,23 +299,23 @@
>>  #define RX_ISOCHRONOUS			0x008
>>  
>>  /*
>> - * Index of first quadlet to be interpreted; read/write.  If > 0, that many
>> - * quadlets at the beginning of each data block will be ignored, and all the
>> - * audio and MIDI quadlets will follow.
>> - */
>> -#define RX_SEQ_START			0x00c
>> -
>> -/*
>>   * The number of audio channels; read-only.  There will be one quadlet per
>>   * channel.
>>   */
>> -#define RX_NUMBER_AUDIO			0x010
>> +#define RX_NUMBER_AUDIO			0x00c
>>  
>>  /*
>>   * The number of MIDI ports, 0-8; read-only.  If > 0, there will be one
>>   * additional quadlet in each data block, following the audio quadlets.
>>   */
>> -#define RX_NUMBER_MIDI			0x014
>> +#define RX_NUMBER_MIDI			0x010
>> +
>> +/*
>> + * Index of first quadlet to be interpreted; read/write.  If > 0, that many
>> + * quadlets at the beginning of each data block will be ignored, and all the
>> + * audio and MIDI quadlets will follow.
>> + */
>> +#define RX_SEQ_START			0x014
>>  
>>  /*
>>   * Names of all audio channels; read-only.  Quadlets are byte-swapped.  Names
>> diff --git a/sound/firewire/dice/dice-proc.c b/sound/firewire/dice/dice-proc.c
>> index f5c1d1b..ecfe20f 100644
>> --- a/sound/firewire/dice/dice-proc.c
>> +++ b/sound/firewire/dice/dice-proc.c
>> @@ -99,9 +99,9 @@ static void dice_proc_read(struct snd_info_entry *entry,
>>  		} tx;
>>  		struct {
>>  			u32 iso;
>> -			u32 seq_start;
>>  			u32 number_audio;
>>  			u32 number_midi;
>> +			u32 seq_start;
>>  			char names[RX_NAMES_SIZE];
>>  			u32 ac3_caps;
>>  			u32 ac3_enable;
>> @@ -204,10 +204,10 @@ static void dice_proc_read(struct snd_info_entry *entry,
>>  			break;
>>  		snd_iprintf(buffer, "rx %u:\n", stream);
>>  		snd_iprintf(buffer, "  iso channel: %d\n", (int)buf.rx.iso);
>> -		snd_iprintf(buffer, "  sequence start: %u\n", buf.rx.seq_start);
>>  		snd_iprintf(buffer, "  audio channels: %u\n",
>>  			    buf.rx.number_audio);
>>  		snd_iprintf(buffer, "  midi ports: %u\n", buf.rx.number_midi);
>> +		snd_iprintf(buffer, "  sequence start: %u\n", buf.rx.seq_start);
>>  		if (quadlets >= 68) {
>>  			dice_proc_fixup_string(buf.rx.names, RX_NAMES_SIZE);
>>  			snd_iprintf(buffer, "  names: %s\n", buf.rx.names);
>> -- 
>> 2.1.0
