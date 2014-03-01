From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 18/39] firewire-lib: Add a fallback at
 RCODE_CANCELLED
Date: Sat, 1 Mar 2014 11:34:44 +0100
Message-ID: <20140301113444.7c257eb3@stein>
References: <1393558072-25926-1-git-send-email-o-takashi@sakamocchi.jp>
 <1393558072-25926-19-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id F3EC5265299
 for <alsa-devel@alsa-project.org>; Sat,  1 Mar 2014 11:34:46 +0100 (CET)
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
> --- a/sound/firewire/lib.c
> +++ b/sound/firewire/lib.c
> @@ -22,7 +22,7 @@
>   * @length: length of @buffer
>   * @flags: use %FW_FIXED_GENERATION and add the generation value to attempt the
>   *         request only in that generation; use %FW_QUIET to suppress error
> - *         messages
> + *         messages: use %FW_RETURN_TIMEOUT to avoid retry at RCODE_CANCELLED

For clarity, this should be a semicolon instead of a colon, i.e.

              messages; use %FW_RETURN_TIMEOUT to avoid retry at RCODE_CANCELLED
-- 
Stefan Richter
-=====-====- --== ----=
http://arcgraph.de/sr/
