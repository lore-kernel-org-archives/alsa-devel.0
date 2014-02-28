From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 09/39] firewire-lib: Add sort function for
 transmitted packet
Date: Fri, 28 Feb 2014 23:31:51 +0900
Message-ID: <53109DD7.9060702@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-10-git-send-email-o-takashi@sakamocchi.jp>
 <s5h8usvn3ik.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 3CDCE26510C
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 15:31:55 +0100 (CET)
In-Reply-To: <s5h8usvn3ik.wl%tiwai@suse.de>
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

Iwai-san,

Thanks for your reviewing.

(Feb 28 2014 15:40), Takashi Iwai wrote:
>> +#define SWAP(tbl, m, n) \
>> +	t = tbl[n].id; \
>> +	tbl[n].id = tbl[m].id; \
>> +	tbl[m].id = t; \
>> +	t = tbl[n].dbc; \
>> +	tbl[n].dbc = tbl[m].dbc; \
>> +	tbl[m].dbc = t; \
>> +	t = tbl[n].payload_size; \
>> +	tbl[n].payload_size = tbl[m].payload_size; \
>> +	tbl[m].payload_size = t;
>
> Why swap() macro can't be used instead?

Because I didn't know the macro... I confirm it in kernel.h. Thank you.

>> +static void packet_sort(struct sort_table *tbl, unsigned int len)
>> +{
>> +	unsigned int i, j, k, t;
>> +
>> +	i = 0;
>> +	do {
>> +		for (j = i + 1; j < len; j++) {
>> +			if (((tbl[i].dbc > tbl[j].dbc) &&
>> +			     (tbl[i].dbc - tbl[j].dbc < DBC_THRESHOLD))) {
>> +				SWAP(tbl, i, j);
>> +			} else if ((tbl[j].dbc > tbl[i].dbc) &&
>> +				   (tbl[j].dbc - tbl[i].dbc >
>> +							DBC_THRESHOLD)) {
>> +				for (k = i; k > 0; k--) {
>> +					if ((tbl[k].dbc > tbl[j].dbc) ||
>> +					    (tbl[j].dbc - tbl[k].dbc >
>> +							DBC_THRESHOLD)) {
>> +						SWAP(tbl, j, k);
>> +					}
>> +					break;
>> +				}
>> +			}
>> +			break;
>> +		}
>> +		i = j;
>> +	} while (i < len);
>> +}
>
> You can use the standard sort() function (available in linux/sort.h).

According to /lib/sort.c, it's for heap sort.

Currently I think I cannot write this algorism as heap sort because data 
consist of cyclic numbers, A simple example is:
[4, 5, 0, 2, 1, 3, 4, 0, 5, 1, 3, 2, 4, 0, 1, 5]
After sorting, this sequence of number should be:
[4, 5, 0, 1, 2, 3, 4, 5, 0, 1, 2, 3, 4, 5, 0, 1]

And we need to use stable sort algorism because there are successive 
elements with the same value.

If you want to see actual example, please see [PATCH 21/39]. A sequence 
of the last four bytes in 'CIP header 1' is data to be sort.

>> +	/* for sorting transmitted packets */
>> +	if (s->direction == AMDTP_IN_STREAM) {
>> +		s->remain_packets = 0;
>> +		s->sort_table = kzalloc(sizeof(struct sort_table) *
>> +					QUEUE_LENGTH, GFP_KERNEL);
>> +		if (s->sort_table == NULL)
>> +			return -ENOMEM;
>> +		s->left_packets = kzalloc(amdtp_stream_get_max_payload(s) *
>> +					  QUEUE_LENGTH / 4, GFP_KERNEL);
>
> NULL check missing?

OK. I forgot it.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
