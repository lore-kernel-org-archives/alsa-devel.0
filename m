From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [PATCH 18/39] firewire-lib: Add a
 fallback at RCODE_CANCELLED
Date: Tue, 4 Mar 2014 12:05:35 +1030
Message-ID: <20140304013535.GP15773@marvin.atrad.com.au>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140228212535.7606e0d8@stein> <5311517B.5060905@sakamocchi.jp>
 <20140301111013.483fd7df@stein> <5311D0FC.7020302@sakamocchi.jp>
 <20140301152050.5de701a3@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 226A12656CB
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 02:35:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20140301152050.5de701a3@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, jwoithe@just42.net, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 01, 2014 at 03:20:50PM +0100, Stefan Richter wrote:
> On Mar 01 Takashi Sakamoto wrote:
> >> A related question:  Since FFADO applies 200 ms or more as FCP
> >> transaction timeout, shouldn't firewire-lib's fcp.c increase
> >> FCP_TIMEOUT_MS from 125 to 200 or more as well?
> > 
> > For this developing, I've spent much time with my test devices.
> > But I've never experienced disadvantages under FCP_TIMEOUT_MS=125msec.
> > So feel no importance.
> > 
> > If you feel this importance, please post your patch with proper reasons.
> 
> This is mostly a question to the ffado-devel subscribers.  125 ms is of
> course enough for devices which comply with the specification in this
> regard.  The question is whether FFADO developers know of devices (or
> suspect devices) which exceed the standard 100 ms and need more like 200
> ms.

I've personally had nothing to do with devices utilising FCP transactions so
unfortunately I don't really know.  My feeling is that the authors of the
respective FFADO drivers would not have applied an FCP timeout of 200 ms if
there was no demonstrated need for it.  Therefore in the absence of other
evidence I would be assuming that there are devices which require the higher
timeout allowed for in FFADO's streaming code.  However, I don't know which
specific devices these might be.

Regards
  jonathan
