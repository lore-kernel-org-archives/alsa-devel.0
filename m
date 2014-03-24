From: Euan de Kock <euan@dekock.net>
Subject: Re: [FFADO-devel] [PATCH 42/44] bebob/firewire-lib: Add a quirk of
	wrong dbc in empty packet for M-Audio special Firewire series
Date: Mon, 24 Mar 2014 09:41:18 +0800
Message-ID: <ebf27c28-64aa-4f13-8e6e-4112c6bb79e9@email.android.com>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-43-git-send-email-o-takashi@sakamocchi.jp>
	<532E441A.7060302@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2443392122110440469=="
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <532E441A.7060302@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, clemens@ladisch.de
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

--===============2443392122110440469==
Content-Type: multipart/alternative;
	boundary="----AJCCVC0A5SQT6LW3YO2V4QTO5SD2F5"
Content-Transfer-Encoding: 8bit

------AJCCVC0A5SQT6LW3YO2V4QTO5SD2F5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain;
 charset=UTF-8

Thanks for the update. This bit me last night, and I just commented out the check to keep working.

I'll try and retest it tonight with this version. (On a Echo Audiofire Pre8 with firmware  < 5)

Regards,

Euan deKock.

On 23 March 2014 10:16:58 AM AWST, Takashi Sakamoto <o-takashi@sakamocchi.jp> wrote:
>I realize this patch includes a bug to cause wrong detection of packet 
>discontinuity.
>
>> @@ -745,6 +745,8 @@ static void handle_in_packet(struct amdtp_stream
>*s,
>>
>>   	/* Check data block counter continuity */
>>   	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
>> +	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC))
>> +		data_block_counter = s->data_block_counter;
>>   	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
>>   		lost = data_block_counter != s->data_block_counter;
>>   	} else {
>
>These lines should be:
>
> > +	if (data_blocks == 0 && (s->flags & CIP_EMPTY_HAS_WRONG_DBC) &&
> > +         s->data_block_counter != UINT_MAX)
> > +		data_block_counter = s->data_block_counter;
>
>
>When CIP_SKIP_INIT_DBC_CHECK is enabled, initial value of 
>s->data_block_counter is set to UINT_MAX. An intention of this is to 
>skip detecting discontinuity for a first packet [31/44].
>
>This initial value has a bad effect when CIP_EMPTY_HAS_WRONG_DBC is
>enabled.
>
>A first packet is an empty packet. When this packet is handled, 
>data_block_counter is set to initial value of s->data_block_counter 
>(UINT_MAX). Later, s->data_block_counter is set to 0xff with bitmask in
>
>below lines.
>
>         if (s->flags & CIP_DBC_IS_END_EVENT)
>                 s->data_block_counter = data_block_counter;
>         else
>                 s->data_block_counter =
>                             (data_block_counter + data_blocks) & 0xff;
>
>When a packet with data blocks is handled later, s->data_block_counter 
>is 0xff, not UINT_MAX. This causes discontinuity detection because this
>
>packet has 0x00 in itx dbc in below lines.
>
>         if (lost && s->data_block_counter != UINT_MAX) {
>                 dev_info(&s->unit->device,
>                          "Detect discontinuity of CIP: %02X %02X\n",
>                          s->data_block_counter, data_block_counter);
>
>See this log:
>[ 2933.102892] 01020000 9002FFFF 02
>[ 2933.102894] 01020000 9002FFFF 02
>[ 2933.102896] 01020000 9002FFFF 02
>[ 2933.102899] 01020000 9002FFFF 02
>[ 2933.102901] 01020000 9002FFFF 02
>[ 2933.102903] 01020000 9002FFFF 02
>[ 2933.104871] 01110000 900258B5 8A
>[ 2933.104877] snd-bebob fw1.0: Detect discontinuity of CIP: FF 00
>
>I'm sorry to post a patch including a bug.
>
>
>Regards
>
>Takashi Sakamoto
>o-takashi@sakamocchi.jp
>
>
>------------------------------------------------------------------------------
>Learn Graph Databases - Download FREE O'Reilly Book
>"Graph Databases" is the definitive new guide to graph databases and
>their
>applications. Written by three acclaimed leaders in the field,
>this first edition is now available. Download your free book today!
>http://p.sf.net/sfu/13534_NeoTech
>_______________________________________________
>FFADO-devel mailing list
>FFADO-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/ffado-devel

------AJCCVC0A5SQT6LW3YO2V4QTO5SD2F5
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head></head><body>Thanks for the update. This bit me last night, and I just commented out the check to keep working.<br>
<br>
I&#39;ll try and retest it tonight with this version. (On a Echo Audiofire Pre8 with firmware  &lt; 5)<br>
<br>
Regards,<br>
<br>
Euan deKock.<br><br><div class="gmail_quote">On 23 March 2014 10:16:58 AM AWST, Takashi Sakamoto &lt;o-takashi@sakamocchi.jp&gt; wrote:<blockquote class="gmail_quote" style="margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre class="k9mail">I realize this patch includes a bug to cause wrong detection of packet <br />discontinuity.<br /><br /><blockquote class="gmail_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> @@ -745,6 +745,8 @@ static void handle_in_packet(struct amdtp_stream *s,<br /><br />    /* Check data block counter continuity */<br />    data_block_counter = cip_header[0] &amp; AMDTP_DBC_MASK;<br /> + if (data_blocks == 0 &amp;&amp; (s-&gt;flags &amp; CIP_EMPTY_HAS_WRONG_DBC))<br /> +  data_block_counter = s-&gt;data_block_counter;<br />    if (!(s-&gt;flags &amp; CIP_DBC_IS_END_EVENT)) {<br />     lost = data_block_counter != s-&gt;data_block_counter;<br />    } else {<br /></blockquote><br />These lines should be:<br /><br /><blockquote class="gma
 il_quote" style="margin: 0pt 0pt 1ex 0.8ex; border-left: 1px solid #729fcf; padding-left: 1ex;"> + if (data_blocks == 0 &amp;&amp; (s-&gt;flags &amp; CIP_EMPTY_HAS_WRONG_DBC) &amp;&amp;<br /> +    
    s-&gt;data_block_counter != UINT_MAX)<br /> +  data_block_counter = s-&gt;data_block_counter;<br /></blockquote><br /><br />When CIP_SKIP_INIT_DBC_CHECK is enabled, initial value of <br />s-&gt;data_block_counter is set to UINT_MAX. An intention of this is to <br />skip detecting discontinuity for a first packet [31/44].<br /><br />This initial value has a bad effect when CIP_EMPTY_HAS_WRONG_DBC is enabled.<br /><br />A first packet is an empty packet. When this packet is handled, <br />data_block_counter is set to initial value of s-&gt;data_block_counter <br />(UINT_MAX). Later, s-&gt;data_block_counter is set to 0xff with bitmask in <br />below lines.<br /><br />         if (s-&gt;flags &amp; CIP_DBC_IS_END_EVENT)<br />                 s-&gt;data_block_counter = data_block_counter;<
 br />         else<br />                 s-&gt;data_block_counter =<br />                                 (data_block_counter + data_blocks) &amp; 0xff;<br /><br />When a packet with data blocks is
handled later, s-&gt;data_block_counter <br />is 0xff, not UINT_MAX. This causes discontinuity detection because this <br />packet has 0x00 in itx dbc in below lines.<br /><br />         if (lost &amp;&amp; s-&gt;data_block_counter != UINT_MAX) {<br />                 dev_info(&amp;s-&gt;unit-&gt;device,<br />                          "Detect discontinuity of CIP: %02X %02X\n",<br />                          s-&gt;data_block_counter, data_block_counter);<br /><br />See this log:<br />[ 2933.102892] 01020000 9002FFFF 02<br />[ 2933.102894] 01020000 9002FFFF 02<br />[ 2933.102896] 01020000 9002FFFF 02<br />[ 2933.102899] 01020000 9002FFFF 02<br />[ 2933.102901] 01020000 9002FFFF 02<br />[ 2933.102903] 01020000 9002FFFF 02<br />[ 2933.104871] 01110000 900258B5 8A<br />[ 2933.104877] snd-bebob
  fw1.0: Detect discontinuity of CIP: FF 00<br /><br />I'm sorry to post a patch including a bug.<br /><br /><br />Regards<br /><br />Takashi Sakamoto<br />o-takashi@sakamocchi.jp<br /><br /><br
/><hr /><br />Learn Graph Databases - Download FREE O'Reilly Book<br />"Graph Databases" is the definitive new guide to graph databases and their<br />applications. Written by three acclaimed leaders in the field,<br />this first edition is now available. Download your free book today!<br /><a href="http://p.sf.net/sfu/13534_NeoTech">http://p.sf.net/sfu/13534_NeoTech</a><br /><hr /><br />FFADO-devel mailing list<br />FFADO-devel@lists.sourceforge.net<br /><a href="https://lists.sourceforge.net/lists/listinfo/ffado-devel">https://lists.sourceforge.net/lists/listinfo/ffado-devel</a><br /></pre></blockquote></div></body></html>
------AJCCVC0A5SQT6LW3YO2V4QTO5SD2F5--



--===============2443392122110440469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
--===============2443392122110440469==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2443392122110440469==--
