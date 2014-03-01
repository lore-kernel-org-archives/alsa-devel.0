From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 18/39] firewire-lib: Add a fallback at
	RCODE_CANCELLED
Date: Sat, 01 Mar 2014 12:18:19 +0900
Message-ID: <5311517B.5060905@sakamocchi.jp>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140228212535.7606e0d8@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 79D2F265976
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 04:18:27 +0100 (CET)
In-Reply-To: <20140228212535.7606e0d8@stein>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Stefan,

At first, I introduce this is for a patch below. You can see actual logs:
[alsa-devel] [PATCH 39/39] bebob: Add support for M-Audio special 
Firewire series
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073484.html

> It's 2000 ms actually.

Oops. Here I made a mistake to refer to unrelated value here. I might 
consider about the other thing when writing this commit, perhaps because 
of noon in Friday and a bit tired...

Well, yes. It's 2000 msec.

(Feb 28 2014 12:27), Takashi Sakamoto wrote:
 > As a result, in worst case that all of three retries are timeout
 > and devices don't send responses, fcp_avc_transaction() returns 1sec
 > later ((200 + 125) msec * 3 times).

So in this case, this function returns 6,375msec later. (but it's rare, 
again.)

> And this is the IEEE 1394 split transaction timeout of course.  FCP
> transactions on the other hand are transported by means of two IEEE 1394
> transactions:  One in which the FCP requester is IEEE 1394 requester, and
> another one in which the FCP responder is IEEE 1394 requester.
>
> firewire-core's split transaction timeout is only relevant to the request
> subaction of an FCP transaction (i.e. the first one of the two IEEE 1394
> transaction),

OK.

> and only if this one is being performed as a split
> transaction rather than a unified transaction, which depends on the FCP
> responder hardware.  (I am not aware of any hardware which handles
> FCP request subactions as unified transactions.)

As You explained in this message:
[alsa-devel] Echo Fireworks control protocol (was Re: Sample program for 
hwdep interface)
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/071978.html

> IEC 61883-1 does not specify any FCP transaction timeout.

I've confirmed it.

> The 1394 TA document "AV/C Digital Interface Command Set, Rev. 1.0,
> 1996" defines FCP transactions (for use with AV/C command set) much more
> precisely than IEC 61883-1 does:
>
>    - To each FCP request, there may be 0..n FCP responses.
>
>    - An AV/C target may emit a final response (one with response code <
>      0xf) up to 100 ms after reception of an FCP request.
>
>    - Or the AV/C target may emit an intermediate response (one with
>      response code 0xf for interim response) up to 100 ms after reception
>      of an FCP request.  The target shall emit no additional interim
>      response in this transaction, but one final response.  There is no
>      timeout specified for this final-after-interim response, i.e. it may
>      take an undefined, possibly very long time.  (The AV/C
>      specification v4.0, 2001 adds that subunit specifications may define
>      such timeouts for certain commands.)
>
>    - Or the AV/C target may still be busy processing a previous command.
>      In this case, the specification accepts that the target does not send
>      any response to subsequent requests at all until it is done with the
>      previous work.  The requester may the retry such a failed request after
>      the mentioned 100 ms timeout.  (Plus IEEE 1394 transport overhead, but
>      the AV/C specification v1.0 does not mention this.  AV/C v4.0 explains
>      that the requester should take certain transport dependent delays
>      into account in addition to the 100 ms FCP timeout, e.g. physical layer
>      repeater delays, or busy retry delays.  Furthermore, AV/C v4.0
>      recommends that a busy target returns certain acknowledge codes or
>      response codes to pipelined requests that exceed its capacity
>      to handle concurrent FCP transactions.)
>
>    - An "IEEE 1394.0 reset" (sic) terminates any outstanding FCP transaction.
>      (I suppose a 1394 bus reset is meant by this.  AV/C v4.0 clarifies this
>      to be an IEEE 1394 bus reset indeed.)

Additionally, there are two types of AV/C transactions, 'immediate 
transaction' and 'deffered transaction'. Current 'firewire-lib' don't 
implement 'deffered transaction' so fcp_avc_transaction() always returns 
first AV/C response frame. This will be response=INTERIM against 
ctype=STATUS/NOTIFY.  The gap between a first response and a second 
response of 'deffered transaction' is defined as 'unspecified interval'.

But this is not related to an issue about which this patch mentions.

(Mar 01 2014 05:39), Stefan Richter wrote:
> To be more precise:  The specification accepts that the target*ignores*
> incoming AV/C command frames while processing an AV/C command.  This is
> indicated to the requester by lack of a response to any ignored request.
>
> To me, this implies that the target must send a response to any request
> that it did not ignore, i.e. to any command that it executed.  On the
> other hand, I don't think there is any rollback behavior specified or
> practical in cases when the target is unable to deliver a response to the
> initiator.
 >
>>From a quick glance, the FCP transaction specification looks unchanged
> from AV/C 4.0, 2001 to v4.1, 2001 and to v4.2, 2004.

I cannot find some sections about such ignorance in 'AV/C Digital 
Interface Command Set General Specification Version 4.2 (Sep 01, 2004, 
1394TA)' and 'IEC 61883-1 ed2'.

Can I request you any pointers about this ignorance?


Thanks

Takashi Sakamoto
o-takashi@sakamocchi.jp
