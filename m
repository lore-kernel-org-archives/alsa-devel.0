From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3] ALSA: tascam: improve loop condition
 to filling MIDI bytes in transaction
Date: Sun, 18 Oct 2015 21:13:08 +0900
Message-ID: <56238CD4.30900@sakamocchi.jp>
References: <1445162538-12293-1-git-send-email-o-takashi@sakamocchi.jp>
 <1445162538-12293-3-git-send-email-o-takashi@sakamocchi.jp>
 <s5ha8rgbi7r.wl-tiwai@suse.de> <562379B5.309@sakamocchi.jp>
 <s5h7fmkbd4r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id E24D2261583
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 14:13:16 +0200 (CEST)
In-Reply-To: <s5h7fmkbd4r.wl-tiwai@suse.de>
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

On Oct 18 2015 21:00, Takashi Iwai wrote:
> On Sun, 18 Oct 2015 12:51:33 +0200,
> Takashi Sakamoto wrote:
>>
>> On Oct 18 2015 19:10, Takashi Iwai wrote:
>>> On Sun, 18 Oct 2015 12:02:17 +0200,
>>> Takashi Sakamoto wrote:
>>>>
>>>> It includes meaningless condition. This commit improve it.
>>>>
>>>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>>>> ---
>>>>  sound/firewire/tascam/tascam-transaction.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/sound/firewire/tascam/tascam-transaction.c b/sound/firewire/tascam/tascam-transaction.c
>>>> index 7fcee81..4ffaa8a 100644
>>>> --- a/sound/firewire/tascam/tascam-transaction.c
>>>> +++ b/sound/firewire/tascam/tascam-transaction.c
>>>> @@ -74,7 +74,7 @@ static int fill_message(struct snd_rawmidi_substream *substream, u8 *buf)
>>>>  	/* On exclusive message. */
>>>>  	if (tscm->on_sysex[port]) {
>>>>  		/* Seek the end of exclusives. */
>>>> -		for (i = 1; i < 4 || i < len; ++i) {
>>>> +		for (i = 1; i < len + 1; ++i) {
>>>
>>> This doesn't look like an improvement...
>>> The fix should be rather like:
>>> 		for (i = 1; i < 4 && i < len; ++i) {
>>
>> The 'len' variable is assigned to the return value of
>> snd_rawmidi_transmit_peek(). The third argument to call this function is
>> 3, thus the value of this variable equals to or is less than 3.
>>
>> The aim of this loop is to find EOX (end of exclusive) byte in retrieved
>> bytes, then break the loop.The index goes from 1 to the end of retrieved
>> bytes. Thus, 'i < 4 || i < len' is not so proper, here.
> 
> Then the patch description is incorrect.  You actually fix something
> that was a buggy behavior.

It's not so buggy behaviour because the loop continue to seek the buffer
till its end (4th byte), always. But this is against my intention to
stop the seek in the end of retrieved byte.

Anyway, the code is not good.

> Overall, the code is confusing because the real data buffer begins at
> offset 1 and len doesn't mean the size of the values written to buf[].
> Maybe it's better to be like:
> 	char *msg = buf + 1;
> 
> and use msg[x] instead of buf[1+x].  Then len really corresponds to
> the size of msg[].

That's a good idea. OK, I'll post the revised version, later.


Thanks

Takashi Sakamoto
