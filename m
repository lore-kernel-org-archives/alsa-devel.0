From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 3/4] ALSA: firewire-lib: use dev_err()
	when	detecting incoming streaming error
Date: Fri, 22 May 2015 20:05:10 +0200
Message-ID: <555F6FD6.8090809@ladisch.de>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
 <1432304474-6533-4-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D195926041D
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 20:05:34 +0200 (CEST)
In-Reply-To: <1432304474-6533-4-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> When detecting invalid value in 'dbs' field of CIP header or packet
> discontinuity, current implementation reports the status by err_info().
> [...]
> This commit use dev_err() instead of dev_info() for this purpose.
> In the cases, packet streaming is aborted, thus no message floading
> occurs.

An aborted stream ends up in the XRUN state; the application is likely
to prepare and start the stream again.  So it is likely that there
will be message flooding.


Regards,
Clemens
