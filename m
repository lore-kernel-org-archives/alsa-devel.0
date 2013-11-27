From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: [PATCH 06/17] firewire-lib: Add support for MIDI
	capture/playback
Date: Wed, 27 Nov 2013 08:33:01 +0000
Message-ID: <201311270833.01221.gineera@aspect135.co.uk>
References: <1385186884-8259-1-git-send-email-o-takashi@sakamocchi.jp>
 <52949BD5.6010601@ladisch.de> <5294D616.9020000@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 4.array2.smtp.34sp.com (4.array2.smtp.34sp.com [46.183.8.157])
 by alsa0.perex.cz (Postfix) with ESMTP id C8AAA261B17
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 09:28:15 +0100 (CET)
Received: from smtpauth1.array1.smtp.34sp.com (lvs3.34sp.com [80.82.124.221])
 by 4.array2.smtp.34sp.com (Postfix) with ESMTP id 4CE53A790E
 for <alsa-devel@alsa-project.org>; Wed, 27 Nov 2013 08:28:08 +0000 (GMT)
In-Reply-To: <5294D616.9020000@sakamocchi.jp>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tuesday 26 November 2013 17:10, Takashi Sakamoto wrote:
> (Nov 26 2013 22:02), Clemens Ladisch wrote:
> > Takashi Sakamoto wrote:
> >> In my understanding of RP-027:
> >> 'MIDI data stream' is a data stream to/from each MIDI ports
> >> 'MPX-MIDI data channel' is a data channel for each 'MIDI data stream'
> >> 'MIDI comformant data channel' has multiplexed 8 'MPX-MIDI data
> >> channel's
> >
> > Yes.
>
> OK. Here I use 'midi_channels' as 'MIDI comformant data channels' for
> struct amdtp_stream.
>
> >> /*
> >>   * This module supports maximum 2 MIDI comformant data channels.

s/ conformant ??

Regards

Alan
