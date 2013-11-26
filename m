From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 06/17] firewire-lib: Add support for MIDI
 capture/playback
Date: Tue, 26 Nov 2013 14:02:13 +0100
Message-ID: <52949BD5.6010601@ladisch.de>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <1385186884-8259-7-git-send-email-o-takashi@sakamocchi.jp>
 <52936C6F.1030200@ladisch.de> <52948E38.4090601@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B1E9F265130
 for <alsa-devel@alsa-project.org>; Tue, 26 Nov 2013 14:02:15 +0100 (CET)
In-Reply-To: <52948E38.4090601@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> In my understanding of RP-027:
> 'MIDI data stream' is a data stream to/from each MIDI ports
> 'MPX-MIDI data channel' is a data channel for each 'MIDI data stream'
> 'MIDI comformant data channel' has multiplexed 8 'MPX-MIDI data channel's

Yes.

> So I should write:
>
> /*
>  * This module supports maximum 2 MIDI comformant data channels.

Are there devices that use more than one?

>  * Each MIDI comformant data channels include 8 MPX-MIDI data stream.

     Each MIDI comformant data channel includes 8 MPX-MIDI data streams.

>  * Each MPX-MIDI data streams includes data stream from/to MIDI ports.

     Each MPX-MIDI data stream contains the data stream from/to one MIDI port.


Regards,
Clemens
