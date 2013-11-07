From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC] ALSA: hda - check for mute/micmute LEDs on
 all Lenovo machines (Realtek)
Date: Thu, 07 Nov 2013 09:34:14 +0100
Message-ID: <527B5086.7070106@canonical.com>
References: <1383744096-7510-1-git-send-email-david.henningsson@canonical.com>	<s5hy551v3s7.wl%tiwai@suse.de>	<s5htxfpv33f.wl%tiwai@suse.de>
 <CAJ=jquZ0iir2e59d+afdj91JBYe2MiXsrQdam1PrS4BfKOdBmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EF34260376
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 09:34:15 +0100 (CET)
In-Reply-To: <CAJ=jquZ0iir2e59d+afdj91JBYe2MiXsrQdam1PrS4BfKOdBmw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Hung <alex.hung@canonical.com>, Takashi Iwai <tiwai@suse.de>
Cc: Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org, YK <yk@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 11/07/2013 02:58 AM, Alex Hung wrote:
> @Takashi and David,
> 
> DMI is a good way to check models, and we may not need to check the
> years as older Thinkpads with no mute led do not have "MMTS" and
> "SSMS" control methods in ACPI DSDT. Checking their existence before
> making the actual calls in thinkpad-acpi avoids this problems.

So, the only thing we want to avoid is to load the module if it should
not be loaded, and the symbol_request call will always load the module.
So we want to avoid calling symbol_request if it's not a hardware that
is supported by thinkpad-acpi (and I assume that means Ideapads).

Should we check the DMI information to distinguish between Thinkpads and
Ideapads (and potentially others), and what DMI string would be best to
look for?

-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
