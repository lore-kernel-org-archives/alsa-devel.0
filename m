From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - add mute LED for HP Pavilion
 17 (Realtek codec)
Date: Mon, 07 Jan 2013 11:08:51 +0100
Message-ID: <50EA9EB3.9070400@canonical.com>
References: <1357552289-3232-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B4DE02650D1
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2013 11:08:51 +0100 (CET)
In-Reply-To: <1357552289-3232-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, 1096789@bugs.launchpad.net
List-Id: alsa-devel@alsa-project.org

Sorry for the misleading subject in the previous email. There is only 
one patch.

On 01/07/2013 10:51 AM, David Henningsson wrote:
> The mute LED is in this case connected to the Mic1 VREF.
>
> The machine also exposes the following string in BIOS:
> "HP_Mute_LED_0_A", so if more machines are coming, it probably
> makes sense to try to do something more generic, like for the
> IDT codec.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
