From: Mario Kicherer <dev@kicherer.org>
Subject: Re: [PATCH v2] MIDI driver for Behringer BCD2000 USB
 device
Date: Thu, 06 Feb 2014 17:07:38 +0100
Message-ID: <52F3B34A.3090209@kicherer.org>
References: <1391631059-6840-1-git-send-email-dev@kicherer.org>
 <52F35430.8040502@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zeus06.de (www.zeus06.de [194.117.254.36])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B1C02651FC
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2014 17:07:41 +0100 (CET)
In-Reply-To: <52F35430.8040502@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06.02.2014 10:21, Clemens Ladisch wrote:
>> +config SND_USB_BCD2000
>> +	tristate "Behringer BCD2000 MIDI driver"
>> +	select SND_HWDEP
>
> Why HWDEP?

I admit, I copied this from the other modules (caiaq I believe). After
grepping the documentation, I'm not sure if I need this. Should I remove
it?

> There is no need to have "usb" in the module name if that is the only
> bus this device works with.

Okay, after looking at the other modules I thought that it is common to
use the "snd-usb" prefix. Should I remove it? I find it useful, e.g., to
recognize it in a "lsmod".

>> -obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/
>> +obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/ bcd2000/
>
> If there is only a single source file, just put it into misc/.
> If you plan to have multiple source files, then this file should have
> "_midi" in its name.

Okay, I thought that the code is short enough to put everything in one
file but I think with the audio part it would be best to split the file.
I can move it to misc/ or do you think an own subdirectory is okay to
avoid moving it in later versions?

>> +#include "../usbaudio.h"
>> +#include "../midi.h"
>
> Are these headers needed?

After cleaning up the code with Daniel, no, it's not needed anymore. 
Removed.


>> +static void bcd2000_midi_handle_input(struct bcd2000 *bcd2k,
>> +					const unsigned char *buf, int len)
>> +	/*
>> +	 * The MIDI packets the BCD2000 sends can be arbitrarily truncated or
>> +	 * concatenated. Therefore, this loop accumulates the bytes from the
>> +	 * input buffer until a full valid MIDI packet is in the MIDI command
>> +	 * buffer "midi_cmd_buf".
>> +	 */
>
> ALSA does not require full MIDI commands, and handles running status.

Oh, okay. So, should I just pass everything through to
snd_rawmidi_receive() ?

>> +static int bcd2000_midi_output_close(struct snd_rawmidi_substream *substream)
>> +{
>> +	struct bcd2000 *bcd2k = substream->rmidi->private_data;
>> +	if (bcd2k->midi_out_active) {
>> +		usb_free_urb(bcd2k->midi_out_urb);
>
> Why is this the right place to free the URB?

Good point, doesn't really make sense as it only allocated once. I'll
remove it.

>> +static void bcd2000_midi_output_done(struct urb *urb)
>> +{
>> ...
>> +	if (!bcd2k->midi_out_substream)
>> +		return;
>> +
>> +	bcd2000_midi_send(bcd2k, bcd2k->midi_out_substream);
>
> The midi_out_substream field gets modified asynchronously by the trigger
> callback; this might happen between these two statements.
>
> Assuming that setting a pointer is atomic, use ACCESS_ONCE.

You mean like this:

struct snd_rawmidi_substream * midi_out_substream;
midi_out_substream = ACCESS_ONCE(bcd2k->midi_out_substream);
if (!midi_out_substream)
	return;
bcd2000_midi_send(bcd2k, midi_out_substream);


>> +static void bcd2000_init_midi(struct bcd2000 *bcd2k)
>> +{
>> +	bcd2k->midi_in_urb = usb_alloc_urb(0, GFP_KERNEL);
>> +	bcd2k->midi_out_urb = usb_alloc_urb(0, GFP_KERNEL);
>
> Error checking.

Okay, I guess I should close everything I opened in this module before
or would a "return" suffice?

Thank you for your comments!
Mario
