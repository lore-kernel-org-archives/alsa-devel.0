From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [PATCH 08/19] firewire-motu: add MOTU specific
	protocol layer
Date: Mon, 30 Jan 2017 15:34:56 +1030
Message-ID: <20170130050455.GO8159@marvin.atrad.com.au>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
 <20170129035417.2095-9-o-takashi@sakamocchi.jp>
 <20170129131604.GA15067@marvin.atrad.com.au>
 <91783045-ce45-cd2b-8f78-cfc24e21ba1d@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 94E5B266D7E
 for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2017 06:05:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <91783045-ce45-cd2b-8f78-cfc24e21ba1d@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 30, 2017 at 12:50:07PM +0900, Takashi Sakamoto wrote:
> In MOTU FireWire series, sampling clock and the other clocks seem to
> be independent.

Agreed.  This is what I was trying to say so I apologise that it was not
clear.

> If you have different stories, please show reasoning from enough facts, at
> first. Not from your opinion or memories.

Sending timestamps derived from a fixed interval did not provide reliable
audio output from these devices in general.  This was observed with real
hardware and tangentially, the hardware did not send SPH timestamps with a
fixed interval either.  At 48 kHz for example, deviations from a difference
of 512 were routinely observed in both directions even with official drivers
on vendor-supported OSes.

Over and out.
  jonathan
