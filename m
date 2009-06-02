From: Andrea Borgia <andrea@borgia.bo.it>
Subject: Re: [PATCH - quirk for USB Aureon cards 1/1] Add quirk
 to provide proper naming of the Terratec Aureon 5.1 MkII USB card
Date: Tue, 02 Jun 2009 20:39:13 +0200
Message-ID: <4A2571D1.9070001@borgia.bo.it>
References: <4A22F13F.6090707@borgia.bo.it> <s5hprdofhj7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from galactica.digitalpha.it
	(host200-236-149-62.serverdedicati.aruba.it [62.149.236.200])
	by alsa0.perex.cz (Postfix) with ESMTP id F2DDD103870
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 20:39:16 +0200 (CEST)
In-Reply-To: <s5hprdofhj7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai ha scritto:

>> Signed-off-by: Andrea Borgia <andrea@borgia.bo.it>
> Applied now.  Thanks!

I fear I might have made a mistake somewhere: after patching, rebuilding
and reloading the module the device is still showing up with the generic
"Audio" name in /proc/asound/cards

>From the looks of it, would you agree my latest patch works like my
earlier one for the Toshiba SB-0500 ? That is, renames the device and
nothing else?

Andrea.
