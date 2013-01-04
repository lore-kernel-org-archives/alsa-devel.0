From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC PATCH] ALSA: usb - fix race in creation of
 M-Audio Fast track pro driver
Date: Fri, 04 Jan 2013 21:19:52 +0100
Message-ID: <50E73968.4070703@ladisch.de>
References: <1357315338-2843-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 3ADEA264F07
 for <alsa-devel@alsa-project.org>; Fri,  4 Jan 2013 21:20:35 +0100 (CET)
In-Reply-To: <1357315338-2843-1-git-send-email-david.henningsson@canonical.com>
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
Cc: tiwai@suse.de, 1095315@bugs.launchpad.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> this patch resolves the issue for him. It also leaves a message
> in the log:
> "snd-usb-audio: probe of 1-1.1:1.1 failed with error -5"

I'd guess this is for an interface not claimed by the driver but
without an explicit QUIRK_IGNORE_INTERFACE entry.


Regards,
Clemens
