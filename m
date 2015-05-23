From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/4] ALSA: firewire-lib: code cleanup
Date: Sat, 23 May 2015 21:16:23 +0200
Message-ID: <5560D207.3010404@ladisch.de>
References: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CB741260550
 for <alsa-devel@alsa-project.org>; Sat, 23 May 2015 21:16:49 +0200 (CEST)
In-Reply-To: <1432304474-6533-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> Current implementation includes several macros and functions with improper
> name, hard-coded numerical value and so on.
>
> This patchset is for code cleanup.
>
> Takashi Sakamoto (4):
>   ALSA: firewire-lib: rename local functions for code cleanup
>   ALSA: firewire-lib: macro arrangement for code cleanup
>   ALSA: firewire-lib: use dev_err() when detecting incoming streaming error
>   ALSA: firewire-lib: use protocol error when detecting wrong value in CIP header

All four:
Acked-by: Clemens Ladisch <clemens@ladisch.de>

>  sound/firewire/amdtp.c | 104 ++++++++++++++++++++++++++-----------------------
>  1 file changed, 55 insertions(+), 49 deletions(-)
