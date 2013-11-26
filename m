From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 03/17] firewire-lib: Add 'direction' member
 to 'amdtp_stream' structure
Date: Tue, 26 Nov 2013 19:01:51 +0900
Message-ID: <5294718F.6050103@sakamocchi.jp>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-4-git-send-email-o-takashi@sakamocchi.jp>
 <52936C4C.9030800@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp302.phy.lolipop.jp (smtp302.phy.lolipop.jp [210.157.22.85])
 by alsa0.perex.cz (Postfix) with ESMTP id 3132A260844
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 11:01:54 +0100 (CET)
In-Reply-To: <52936C4C.9030800@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

(Nov 26 2013 00:27), Clemens Ladisch wrote:
>> +enum amdtp_stream_direction {
>> +	AMDTP_RECEIVE_STREAM = 0,
>> +	AMDTP_TRANSMIT_STREAM
>> +};
>
> We have two FireWire nodes, the PC and the audio device.  Both streams
> are transmitted by a node and received by a node, so these names does
> not actually specify a direction.
>
> The DMA API uses names like DMA_FROM/TO_DEVICE for this.  Alternatively,
> you could use something like PLAYBACK/CAPTURE.

OK. This is related to patch 04. How is to use 'in/out' like this?

enum amdtp_stream_direction {
	AMDTP_IN_STREAM,
	AMDTP_OUT_STREAM
};

#define IN_PACKET_HEADER_SIZE	4
#define OUT_PACKET_HEADER_SIZE	0

Here I choice 'in/out' because of characters.

Thank you.


Takashi Sakamoto
o-takashi@sakamocchi.jp
