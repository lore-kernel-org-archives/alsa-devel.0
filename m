From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/8] [RFC] new driver for Echo Audio's
 Fireworks based devices
Date: Sat, 08 Jun 2013 11:29:40 +0200
Message-ID: <51B2F984.60706@ladisch.de>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
 <51AC7B6C.7000108@ladisch.de> <51B1CF0A.6020402@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 8736F26169D
 for <alsa-devel@alsa-project.org>; Sat,  8 Jun 2013 11:29:47 +0200 (CEST)
In-Reply-To: <51B1CF0A.6020402@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Actually Fireworks supports severarl clock source, "Internal", "SYT
> Match", "Word", "S/PDIF", "ADAT1", "ADAT2". Then there is two options,
> one is for SYT match and another is for the others.
>
> SYT match:
> PC is a clock master to transmit SYT in CIP. So receive stream require
> transmit stream in advance.
>
> The others:
> Device is a clock master and PC should generate SYT for transmit
> stream from SYT in receive stream.
>
>> (and, of course, the capture packets must be used to determine
>> when to send packets).
>
> To achieve this, we need to change calculate_syt() or add new function
> to amdtp.c. I think it's enough to generate outgoing SYT from incoming
> SYT with TRANSFER_DELAY (479.17 micro seconds).

We want the playback stream to behave like the capture stream, and the
SYT is interpreted relative to the frame in which the packet is actually
transferred, so what the driver has to do is this:
1) compute the offset between the frame where the capture packet was
   received and its SYT;
2) compute the frame where the playback packet will be sent (i.e., add
   the queue length to the current frame);
3) add the offset to that frame.

The SYT field wraps around after 2 ms, so the corresponding capture/
playback SYT values will be identical only if the queue length is
a multiple of 2 ms.


But there is another thing: the driver has to choose whether a packet to
send contains SYT_INTERVAL samples or is a NO-DATA packet.

In SYT Match mode, the driver just checks whether enough samples are
available for that frame.

In the other modes, the driver must copy the packet type from the
capture stream, i.e., when it receives a NO-DATA packet, it submits
a NO-DATA packet, and when it receives a data packet, it submits a data
packet.  This implies that the queueing of playback packets happens not
in the playback packet completion callback, but in the *capture* packet
completion callback.

> But I have no idea when playback starts. Do you have any idea?

Playback packets can be submitted only when we already have a running
capture stream with its packet completion callbacks.  (This is similar
to starting playback in the SYT Match case, where the driver submits
a bunch of skip packets so that the playback packet completion
callbacks arrive with the correct timing.)


Regards,
Clemens
