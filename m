From: Mario Kicherer <dev@kicherer.org>
Subject: Re: [PATCH v2] MIDI driver for Behringer BCD2000 USB
 device
Date: Thu, 06 Feb 2014 17:07:36 +0100
Message-ID: <52F3B348.5060907@kicherer.org>
References: <1391631059-6840-1-git-send-email-dev@kicherer.org>
 <52F2BBF7.6050802@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 6952F2651E7
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2014 17:07:41 +0100 (CET)
In-Reply-To: <52F2BBF7.6050802@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Thanks, applied most fixes. Further points:

On 05.02.2014 23:32, Daniel Mack wrote:
> Mostly due to:
>
> ERROR: DOS line endings
>
> Did you send the patch using git send-email?

Yes, I only get the two warnings as Takashi. I also moved the
strings in one line as he suggested.

>> +struct bcd2000 {
>> +	struct usb_device *dev;
>> +	struct snd_card *card;
>> +	struct usb_interface *intf;
>> +	int card_index;
>> +	struct snd_pcm *pcm;
>
> Unused?
>
>> +	struct list_head midi_list;
>> +	spinlock_t lock;
>
> Unused?
>
>> +	struct mutex mutex;
>
> That one's also kinda unused (see below)

You're right. The original module had multiple interfaces. Removed.

>> +static DEFINE_MUTEX(devices_mutex);
>> +static unsigned int devices_used;
>> +static struct usb_driver bcd2000_driver;
>> +
>> +
>> +
>> +
>> +
>
> Kill excessive newlines here.

Okay, removed. I find little gaps useful to separate logical parts.

> You could add something like this:
>
> #ifdef CONFIG_SND_DEBUG
> static void bcd2000_midi_hex_dump(const char *prefix,
> 				  const unsigned char *buf, int len)
> {
> 	print_hex_dump(KERN_DEBUG, prefix,
> 		       DUMP_PREFIX_NONE, 16, 1, buf, len, false);
> }
> #else
> static inline void bcd2000_midi_hex_dump(const char *prefix,
> 				  const unsigned char *buf, int len) {}
> #endif
>
> And then just call the function from various places. That would safe you
> the module parameter, the condition check, and an indentation level.

Hm, I removed the CONFIG_ part as the module parameter would allow
me and possible users to debug things spontaneously. But I can use our
approach if you think it would be better nonetheless?

>> +		/* safety check */
>> +		if (bcd2k->midi_cmd_offset + tocopy < BUFSIZE &&
>> +				buf_offset + tocopy < len) {
>> +			memcpy(&bcd2k->midi_cmd_buf[bcd2k->midi_cmd_offset],
>> +				&buf[buf_offset], tocopy);
>> +		} else {
>> +			snd_printk(KERN_ERR PREFIX "access violation in %s\n",
>> +					__func__);
>
> You want to drop the entire packet here, right?

Hm, I'm not sure. A "return" after the snd_printk would do, right?

Thank you very much!
Mario
