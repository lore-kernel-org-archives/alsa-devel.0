From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 18/39] firewire-lib: Add a fallback at
 RCODE_CANCELLED
Date: Fri, 28 Feb 2014 21:39:48 +0100
Message-ID: <20140228213948.2817649b@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
 <20140228212535.7606e0d8@stein>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DFFA26572E
 for <alsa-devel@alsa-project.org>; Fri, 28 Feb 2014 21:39:51 +0100 (CET)
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
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Feb 28 Stefan Richter wrote:
>   - Or the AV/C target may still be busy processing a previous command.
>     In this case, the specification accepts that the target does not send
>     any response to subsequent requests at all until it is done with the
>     previous work.

To be more precise:  The specification accepts that the target *ignores*
incoming AV/C command frames while processing an AV/C command.  This is
indicated to the requester by lack of a response to any ignored request.

To me, this implies that the target must send a response to any request
that it did not ignore, i.e. to any command that it executed.  On the
other hand, I don't think there is any rollback behavior specified or
practical in cases when the target is unable to deliver a response to the
initiator.
-- 
Stefan Richter
-=====-====- --=- ===--
http://arcgraph.de/sr/
