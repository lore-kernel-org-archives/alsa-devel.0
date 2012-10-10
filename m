From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - Add missing hda_gen_spec to
	struct via_spec
Date: Wed, 10 Oct 2012 09:30:36 +0200
Message-ID: <5075241C.8040107@canonical.com>
References: <s5h7gqyeqjp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id DD5FE2616B2
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 09:30:36 +0200 (CEST)
In-Reply-To: <s5h7gqyeqjp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/10/2012 09:26 AM, Takashi Iwai wrote:
> The commit [4b527b65 ALSA: hda - limit internal mic boost for Asus
> X202E] introduced the use of auto-parser code, but it forgot to add
> struct hda_gen_spec at the head of codec->spec which the auto-parser
> assumes silently.  Without this record, it may result in memory
> corruption.
>
> This patch adds the missing piece.
>
> Cc: <stable@vger.kernel.org> [v3.5+]
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>
> David, I queued this fix now.  I'm going to send a pull request
> tomorrow or on Friday.

Thanks for catching. Isn't patch_sigmatel.c missing one also?


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
