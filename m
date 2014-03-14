From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 05/39] firewire-lib: Add support for AMDTP
 in-stream and PCM capture
Date: Fri, 14 Mar 2014 22:50:21 +0900
Message-ID: <5323091D.8070209@sakamocchi.jp>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-6-git-send-email-o-takashi@sakamocchi.jp>
 <531CD0FA.9090506@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp311.phy.lolipop.jp (smtp311.phy.lolipop.jp [210.157.22.79])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A957265310
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 14:50:27 +0100 (CET)
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

Clemens,

> In practice, this error means that a packet was dropped.  I guess this
> doesn't actually happen too often, but eventually, we should handle
> this either by inserting some samples or by stopping the stream.

I'm working for this and I realize Fireworks has some quirks.

(I guess that I had experienced this last year then remove codes to 
check it and forget it now...)

Well, in IEC 61883-1, the value of dbc field corresponds to the first 
data block in a packet. And the value of dbc in a first packet is zero. 
So it also means count of transmitted data blocks (described in IEC 
61883-6).

But for Fireworks, the value of dbc field corresponds to the end data 
block in a packet. See two samples below.

BeBoB - M-Audio Firewire Solo:
34 02040010 900234B2
02 02040018 9002FFFF
34 02040018 900248B2
34 02040020 900260B2
34 02040028 900274B2
02 02040030 9002FFFF
34 02040030 900288B2
34 02040038 9002A0B2
34 02040040 9002B4B2
02 02040048 9002FFFF
34 02040048 9002C8B2
34 02040050 9002E0B2
34 02040058 9002F4B2
02 02040060 9002FFFF
34 02040060 900208B2

Fireworks - AudioFire4(firmware 5.21):
Payload CIP0 CIP1
3A 00070028 9001C704
02 00070028 90FFFFFF
3A 00070030 9001E06E
3A 00070038 9001F5D8
3A 00070040 90010B42
02 00070040 90FFFFFF
3A 00070048 900124AC
3A 00070050 90013A16
02 00070050 90FFFFFF
3A 00070058 90015380
3A 00070060 900168EA
02 00070060 90FFFFFF
3A 00070068 90018254

Let us focus on the value of dbc in empty packet. In BeBoB, the value of 
dbc in packets following to empty packet is the same as the value in the 
empty packet. In Fireworks, the value of dbc in packets following to 
empty packet is not the same as the value in the empty packet, however 
the value of dbc in packets followed by empty packet is the same as the 
value in the empty packet. This means dbc corresponds to the end of data 
block in current packet. I can see this quirk on 
AudioFire4/AudioFirePre8 with firmware version 4.8-5.8, so I guess all 
of Fireworks have this quirk. (quirk 1)

Additionally, firmware version 5.5 seems to have a quirk to report fix 
value (0x08) for dbc interval in all sampling rates. I confirm this on 
AudioFire4 and AudioFirePre8, so I guess all of Fireworks with firmware 
version 5.5 have this quirk. (quirk 2)

Furthermore, Firmware named 'AudioFire9' seems to have a quirk to report 
fix value (0x11) for dbs in all sampling rates instead of actual value. 
I confirm this on AudioFirePre8 with firmware version 4.8-5.8. 
AudioFire8 (since July 2009) uses the same firmware so I guess this 
model has also this quirk. (quirk 3)

And as I mentioned before, BeBoB has a quirk not to increment dbc in 
initial state of transmitting. (quirk 4)

If firewire-lib has codes for these quirks, it can check dbc continuity.
So I'll to add some flags for these issue into 'struct amdtp_stream', like:
struct amdtp_stream {
...
	bool tx_dbc_is_end_event;	// for quirk 1
	unsigned int tx_dbc_interval;	// for quirk 2
	bool tx_dbs_is_wrong;		// for quirk 3
	bool skip_initial_tx_packets;	// for quirk 4
...
};

But 'struct amdtp_stream' has 'flag' member. Should I use this member 
instead of adding new members?


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
