From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 42/44] bebob/firewire-lib: Add a quirk of wrong dbc in
	empty packet for M-Audio special Firewire series
Date: Sun, 23 Mar 2014 11:16:58 +0900
Message-ID: <532E441A.7060302@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-43-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1395400229-22957-43-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

I realize this patch includes a bug to cause wrong detection of packet 
discontinuity.

> @@ -745,6 +745,8 @@ static void handle_in_packet(struct amdtp_stream *s,
>
>   	/* Check data block counter continuity */
>   	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
> +	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC))
> +		data_block_counter = s->data_block_counter;
>   	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
>   		lost = data_block_counter != s->data_block_counter;
>   	} else {

These lines should be:

 > +	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
 > +         s->data_block_counter != UINT_MAX)
 > +		data_block_counter = s->data_block_counter;


When CIP_SKIP_INIT_DBC_CHECK is enabled, initial value of 
s->data_block_counter is set to UINT_MAX. An intention of this is to 
skip detecting discontinuity for a first packet [31/44].

This initial value has a bad effect when CIP_EMPTY_HAS_WRONG_DBC is enabled.

A first packet is an empty packet. When this packet is handled, 
data_block_counter is set to initial value of s->data_block_counter 
(UINT_MAX). Later, s->data_block_counter is set to 0xff with bitmask in 
below lines.

         if (s->flags & CIP_DBC_IS_END_EVENT)
                 s->data_block_counter = data_block_counter;
         else
                 s->data_block_counter =
                                 (data_block_counter + data_blocks) & 0xff;

When a packet with data blocks is handled later, s->data_block_counter 
is 0xff, not UINT_MAX. This causes discontinuity detection because this 
packet has 0x00 in itx dbc in below lines.

         if (lost && s->data_block_counter != UINT_MAX) {
                 dev_info(&s->unit->device,
                          "Detect discontinuity of CIP: %02X %02X\n",
                          s->data_block_counter, data_block_counter);

See this log:
[ 2933.102892] 01020000 9002FFFF 02
[ 2933.102894] 01020000 9002FFFF 02
[ 2933.102896] 01020000 9002FFFF 02
[ 2933.102899] 01020000 9002FFFF 02
[ 2933.102901] 01020000 9002FFFF 02
[ 2933.102903] 01020000 9002FFFF 02
[ 2933.104871] 01110000 900258B5 8A
[ 2933.104877] snd-bebob fw1.0: Detect discontinuity of CIP: FF 00

I'm sorry to post a patch including a bug.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
