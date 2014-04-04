From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 17/44] fireworks: Add transaction and some commands
Date: Fri, 04 Apr 2014 13:08:18 +0900
Message-ID: <533E3032.80406@sakamocchi.jp>
References: <1395400229-22957-1-git-send-email-o-takashi@sakamocchi.jp>
	<1395400229-22957-18-git-send-email-o-takashi@sakamocchi.jp>
	<533DC15B.8030103@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <533DC15B.8030103@ladisch.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Clemens,

(Apr 04 2014 05:15), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> +#define MEMORY_SPACE_EFW_RESPONSE	0xecc080000000
>> +/* this is for juju convinience? */
>> +#define MEMORY_SPACE_EFW_END		0xecc080000200
>
> A single write transaction cannot be larger than 0x200 bytes.

I realize I did not understand the effect of 'struct
fw_address_handler.length' correctly.

I've experienced 0x100 or 0x80 for this member made this module to fail
receiving response but 0x200 works good. I did guess this is due to juju
because I have a little knowledgement about it.

But actually the failure is due to the size of payload in response
transaction. The first transaction which this module executes is for
getting hardware info, like:

...
[  345.661702] firewire_ohci 0000:0c:06.0: AT spd 2 tl 1f, ffc1 -> ffc0,
ack_pending , BW req, ecc000000000 18,0
[  345.661808] firewire_ohci 0000:0c:06.0: AR spd 2 tl 1f, ffc0 -> ffc1,
ack_complete, W resp
[  345.661985] firewire_ohci 0000:0c:06.0: AR spd 2 tl 01, ffc0 -> ffc1,
ack_complete, BW req, ecc080000000 11c,0
...

The size of payload in response is 0x11c. So this module need greater
value than this size for the length member.

I don't know exact maximum size of content in response transaction. But
I think it's better to use the same value which firewire-lib uses for
its FCP functionality, because the transaction can be also delivered by
AV/C Vendor Specific command.


Thank you

Takashi Sakamoto
o-takashi@sakamocchi.jp


------------------------------------------------------------------------------
