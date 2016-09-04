From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC][PATCH 0/2] ALSA: control: limit life time
	of	user-defined element set
Date: Sun, 4 Sep 2016 17:38:20 +0200
Message-ID: <c05a8424-724d-89a1-7a70-c2365420d7d7@ladisch.de>
References: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 130E9265D21
 for <alsa-devel@alsa-project.org>; Sun,  4 Sep 2016 17:38:46 +0200 (CEST)
In-Reply-To: <1472983616-16254-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: tiwai@suse.de, jimmy@spalge.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> ALSA control core allows applications to add arbitrary element sets to an
> instance of control device, while removal of the element sets is voluntarily
> done by some applications. This is not convenient to certain situations.

This was originally designed for softvol, where the user-defined element
should behave as much as possible as a hardware control.

> My large concern is whether there's any applications to open a file descriptor
> just to add any element sets.

alsactl restore


Regards,
Clemens
