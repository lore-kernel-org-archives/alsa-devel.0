From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 18/39] firewire-lib: Add a fallback at
 RCODE_CANCELLED
Date: Fri, 28 Feb 2014 21:25:35 +0100
Message-ID: <20140228212535.7606e0d8@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 6449926571A
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 21:25:39 +0100 (CET)
In-Reply-To: <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
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

On Feb 28 Takashi Sakamoto wrote:
> Linux Firewire Subsystem currently gives
> 200msec for default timeout (See DEFAULT_SPLIT_TIMEOUT in core-card.c).

It's 2000 ms actually.

And this is the IEEE 1394 split transaction timeout of course.  FCP
transactions on the other hand are transported by means of two IEEE 1394
transactions:  One in which the FCP requester is IEEE 1394 requester, and
another one in which the FCP responder is IEEE 1394 requester.

firewire-core's split transaction timeout is only relevant to the request
subaction of an FCP transaction (i.e. the first one of the two IEEE 1394
transaction), and only if this one is being performed as a split
transaction rather than a unified transaction, which depends on the FCP
responder hardware.  (I am not aware of any hardware which handles
FCP request subactions as unified transactions.)

IEC 61883-1 does not specify any FCP transaction timeout.

The 1394 TA document "AV/C Digital Interface Command Set, Rev. 1.0,
1996" defines FCP transactions (for use with AV/C command set) much more
precisely than IEC 61883-1 does:

  - To each FCP request, there may be 0..n FCP responses.

  - An AV/C target may emit a final response (one with response code <
    0xf) up to 100 ms after reception of an FCP request.

  - Or the AV/C target may emit an intermediate response (one with
    response code 0xf for interim response) up to 100 ms after reception
    of an FCP request.  The target shall emit no additional interim
    response in this transaction, but one final response.  There is no
    timeout specified for this final-after-interim response, i.e. it may
    take an undefined, possibly very long time.  (The AV/C
    specification v4.0, 2001 adds that subunit specifications may define
    such timeouts for certain commands.)

  - Or the AV/C target may still be busy processing a previous command.
    In this case, the specification accepts that the target does not send
    any response to subsequent requests at all until it is done with the
    previous work.  The requester may the retry such a failed request after
    the mentioned 100 ms timeout.  (Plus IEEE 1394 transport overhead, but
    the AV/C specification v1.0 does not mention this.  AV/C v4.0 explains
    that the requester should take certain transport dependent delays
    into account in addition to the 100 ms FCP timeout, e.g. physical layer
    repeater delays, or busy retry delays.  Furthermore, AV/C v4.0
    recommends that a busy target returns certain acknowledge codes or
    response codes to pipelined requests that exceed its capacity
    to handle concurrent FCP transactions.)

  - An "IEEE 1394.0 reset" (sic) terminates any outstanding FCP transaction.
    (I suppose a 1394 bus reset is meant by this.  AV/C v4.0 clarifies this
    to be an IEEE 1394 bus reset indeed.)

>From a quick glance, the FCP transaction specification looks unchanged
from AV/C 4.0, 2001 to v4.1, 2001 and to v4.2, 2004.
-- 
Stefan Richter
-=====-====- --=- ===--
http://arcgraph.de/sr/
