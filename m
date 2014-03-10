From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/39] firewire-lib: Add support for AMDTP
 in-stream and PCM capture
Date: Mon, 10 Mar 2014 12:55:59 +0900
Message-ID: <531D37CF.406@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-6-git-send-email-o-takashi@sakamocchi.jp>
 <531CD0FA.9090506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id DB1F1265607
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 04:56:05 +0100 (CET)
In-Reply-To: <531CD0FA.9090506@ladisch.de>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

(Mar 10 2014 05:37), Clemens Ladisch wrote:
> Please format the if/else branches in the same way.

Do you mean these codes should be like this?:
###
if (s->direction == AMDTP_OUT_STREAM) {
	if (s->dual_wire)
		s->transfer_samples = amdtp_write_s32_dualwire;
	else
		s->transfer_samples = amdtp_write_s32;
} else {
	if (s->dual_wire)
		s->transfer_samples = amdtp_read_s32_dualwire;
	else
		s->transfer_samples = amdtp_read_s32;
}
###

> (AMDTP_FDF_NO_DATA << CIP_FDF_SFC_SHIFT) would be a constant that could
> be computed at compile time.

It's nice, OK.

> In practice, this error means that a packet was dropped.

In theory, it's true.

But BeBoB based devices have a quirk related to this. (I forgot to 
mention about it.) Just after connecting, they transmit packets with 
0x00 for its DBC field.

Yamaha GO46:
[13803.762518] 00050000 9001ffff
[13803.762523] 00050000 9001ffff
[13803.762525] 00050000 9001ffff
[13803.762527] 00050000 9001ffff
...
[13804.737925] 00050000 90014a1d
[13804.737927] 00050008 90016387
[13804.737929] 00050010 9001ffff
...

 > I guess this doesn't actually happen too often, but eventually, we should
> handle this either by inserting some samples or by stopping the stream.

So if doing something for this state, we shouldn't stop streams (of 
cource, we can add a flag for BeBoB.) We should insert some zero PCM 
samples or zero MIDI messages.

But this idea forces PCM/MIDI functionality to work for these 
meaningless data. I think it's a waste of resources.


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
