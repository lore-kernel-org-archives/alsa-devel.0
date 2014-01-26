From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: usb-audio - Capture and duplex
 support for Digidesign Mbox 1 sound card.
Date: Sun, 26 Jan 2014 17:52:39 +0100
Message-ID: <52E53D57.3010700@ladisch.de>
References: <52E5254A.8090308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 531AE261675
 for <alsa-devel@alsa-project.org>; Sun, 26 Jan 2014 17:52:54 +0100 (CET)
In-Reply-To: <52E5254A.8090308@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> This patch creates a dual endpoint quirk.
> The quirk interface needs a second audioformat struct for this to work
> which I called ".data2".

Couldn't you just let .data point to an array of two structs?


Regards,
Clemens
