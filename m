From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 07/15] ALSA: oxfw: Add support for AV/C
 stream	format command to get/set supported stream formation
Date: Mon, 08 Dec 2014 09:51:56 +0900
Message-ID: <5484F62C.2010807@sakamocchi.jp>
References: <1417958348-30333-1-git-send-email-o-takashi@sakamocchi.jp>
 <1417958348-30333-8-git-send-email-o-takashi@sakamocchi.jp>
 <5484CE49.6090105@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9880E26069D
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 01:51:59 +0100 (CET)
In-Reply-To: <5484CE49.6090105@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Dec 6 2014 07:01, Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> +++ b/sound/firewire/oxfw/oxfw-command.c
>> +int avc_stream_set_format(struct fw_unit *unit, enum avc_general_plug_dir dir,
>> +			  unsigned int pid, u8 *format, unsigned int len)
>> +{
>> +	buf[0] = 0x00;		/* CONTROL */
>> +	buf[1] = 0xff;		/* UNIT */
>> +	buf[2] = 0xbf;		/* EXTENDED STREAM FORMAT INFORMATION */
>> +	buf[3] = 0xc0;		/* SINGLE subfunction */
>> +	buf[4] = dir;		/* Plug Direction */
>> +	buf[5] = 0x00;		/* UNIT */
>> +	buf[6] = 0x00;		/* PCR (Isochronous Plug) */
>> +	buf[7] = 0xff & pid;	/* Plug ID */
>> +	buf[8] = 0xff;		/* Padding */
>> +	buf[9] = 0xff;		/* Support status in response */
>> +	memcpy(buf + 10, format, len);
>> +
>> +	/* do transaction and check buf[1-7] are the same against command */
>> +	err = fcp_avc_transaction(unit, buf, len + 10, buf, len + 10,
>> +				  BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) |
>> +				  BIT(6) | BIT(7) | BIT(8));
> 
> The comment says 1-7, the code says 1-8.

Oops, indeed.

I correct it in my next patchset with the other correction, in a few days.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
