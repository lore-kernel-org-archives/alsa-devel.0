From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 3/3] Add handling CMP output connection
Date: Mon, 29 Apr 2013 13:18:18 +0900
Message-ID: <517DF48A.9000702@sakamocchi.jp>
References: <1367125189-377-1-git-send-email-o-takashi@sakamocchi.jp>
 <1367125189-377-4-git-send-email-o-takashi@sakamocchi.jp>
 <517D1B89.506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D0F32617B7
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 06:18:25 +0200 (CEST)
In-Reply-To: <517D1B89.506@ladisch.de>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks for your review. I arrange these issues to 5 items below.

cmp[PATCH 3/3]:
1. Calculating offset should be moved into a helper function because 
they are used twice.
OK. I push them into a helper function.

2. Comments should be start with capital letter in each sentenses.
OK. I rewrite it.

3. Use DIV_ROUND_UP macro instead of "for" loop.
OK. I rewrite with the macro.

4. This superfluous comment should say anything to be obvious about the 
code.
OK. I remove the comment.

5. In an oPCR, the payload field is changed only by the device.
OK. I misunderstand the specification. I check IEC 611883-1:2008 and I 
should follow the rules in "7.9 Plug control register modification 
rules". It menthions the fields which should be modified in the same 
compare_swap lock transaction and payload field is not included in it.

Then I have a question about handling payload field. In specification, 
"The payload field shall specify the maximum number of quadlets that may 
be transmitted in a single isochronous packet for this plug" but 
actually cheking this field seems to make no sense because there is no 
checking process in the procedure. I think I can do nothing for payload 
field.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp

(Apr 28 2013 21:52), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> To handle CMP output connection, this patch adds some macros, codes with
>> condition of direction and new functions. Once cmp_connection_init() is
>> executed with its direction, CMP input and output connection can be
>> handled by the same way.
>
>> +++ b/sound/firewire/cmp.c
>
>> +	if (c->direction == CMP_INPUT)
>> +		offset = CSR_REGISTER_BASE + CSR_IPCR(c->pcr_index);
>> +	else
>> +		offset = CSR_REGISTER_BASE + CSR_OPCR(c->pcr_index);
>
> This code is used twice and could be moved into a helper function.
>
>> +static int get_overhead_id(struct cmp_connection *c)
>
>> +	/*
>> +	 * apply "oPCR overhead ID encoding"
>> +	 * the encoding table can convert up to 512.
>> +	 * here the value over 512 is converted as the same way as 512.
>> +	 */
>
> 	/*
> 	 * Apply "oPCR overhead ID encoding":
> 	 * The encoding table can convert up to 512.
> 	 * Here any value over 512 is converted in the same way as 512.
> 	 */
>
>> +	for (id = 1; id < 16; id += 1) {
>> +		if (c->resources.bandwidth_overhead < (id << 5))
>> +			break;
>> +	}
>> +	if (id == 16)
>> +		id = 0;
>
> 	id = DIV_ROUND_UP(c->resources.bandwidth_overhead, 32);
> 	if (id >= 16)
> 		id = 0;
>
>> +static __be32 opcr_set_modify(struct cmp_connection *c, __be32 opcr)
>
>> +	/* generate speed and extended speed field value */
>
> This comment is superfluous; it does not tell anything non-obvious about
> the code.
>
>> +	/*
>> +	 * here zero is applied to payload field.
>> +	 * it means the maximum number of quadlets in an isochronous packet is
>> +	 * 1024 when spd is less than three, 1024 * 2 * xspd + 1 when spd is
>> +	 * equal to three. An arbitrary value can be set here but 0 is enough
>> +	 * for our purpose.
>> +	 */
>> +	opcr |= cpu_to_be32(0 << OPCR_PAYLOAD_SHIFT);
>
> In an oPCR, the payload field is changed only by the device.
>
>
> Regards,
> Clemens
