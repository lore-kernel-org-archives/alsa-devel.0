From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [FFADO-devel] [PATCH 18/39] firewire-lib: Add a
 fallback at RCODE_CANCELLED
Date: Tue, 4 Mar 2014 09:33:23 +0100
Message-ID: <20140304093323.31b314d1@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140228212535.7606e0d8@stein> <5311517B.5060905@sakamocchi.jp>
 <20140301111013.483fd7df@stein> <5311D0FC.7020302@sakamocchi.jp>
 <20140301152050.5de701a3@stein>
 <20140304013535.GP15773@marvin.atrad.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F1E226571D
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 09:33:27 +0100 (CET)
In-Reply-To: <20140304013535.GP15773@marvin.atrad.com.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonathan Woithe <jwoithe@just42.net>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, ffado-devel@lists.sf.net, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On Mar 04 Jonathan Woithe wrote:
> On Sat, Mar 01, 2014 at 03:20:50PM +0100, Stefan Richter wrote:
> > >> Since FFADO applies 200 ms or more as FCP
> > >> transaction timeout, shouldn't firewire-lib's fcp.c increase
> > >> FCP_TIMEOUT_MS from 125 to 200 or more as well?
[...]
> I've personally had nothing to do with devices utilising FCP transactions so
> unfortunately I don't really know.  My feeling is that the authors of the
> respective FFADO drivers would not have applied an FCP timeout of 200 ms if
> there was no demonstrated need for it.  Therefore in the absence of other
> evidence I would be assuming that there are devices which require the higher
> timeout allowed for in FFADO's streaming code.  However, I don't know which
> specific devices these might be.

./libffado/config.h.in:
#define IEEE1394SERVICE_FCP_RESPONSE_TIMEOUT_USEC       200000

was added in this FFADO revision:
http://subversion.ffado.org/changeset/1371
Timestamp:
    10/23/08 09:00:47 (5 years ago)
Author:
    ppalmers
Message:
    * implement our own code to do FCP transactions. the code from libavc
      had too much side-effects.
    * remove libavc1394 as a dependency
    * set the SPLIT_TIMEOUT value for the host controller such that late
      responses by the DM1x00 based devices are not discarded. Should fix
      the issues with FA-101 discovery. (re: #155, #162)

I will look through the libavc1394 source history.
-- 
Stefan Richter
-=====-====- --== --=--
http://arcgraph.de/sr/
