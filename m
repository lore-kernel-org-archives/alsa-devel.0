From: Andrea Borgia <andrea@borgia.bo.it>
Subject: Re: [PATCH - quirk for USB Aureon cards 1/1] Add quirk
 to provide proper naming of the Terratec Aureon 5.1 MkII USB card
Date: Wed, 03 Jun 2009 15:40:10 +0200
Message-ID: <4A267D3A.6000808@borgia.bo.it>
References: <4A22F13F.6090707@borgia.bo.it>
	<s5hprdofhj7.wl%tiwai@suse.de>	<4A2571D1.9070001@borgia.bo.it>
	<s5hprdlyh5q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from galactica.digitalpha.it
	(host200-236-149-62.serverdedicati.aruba.it [62.149.236.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 36CD51038BA
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 15:40:20 +0200 (CEST)
In-Reply-To: <s5hprdlyh5q.wl%tiwai@suse.de>
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

>> From the looks of it, would you agree my latest patch works like my
>> earlier one for the Toshiba SB-0500 ? That is, renames the device and
>> nothing else?
> Hm, doesn't it work properly even after your correction patch?

It does, sort of... but at least I found out that the patched module
wasn't being rebuilt and that was causing the glitch.

Now I get a funny name: "MkII". The full name is ok, but the shorter
name in "cards" is not.

What do you suggest in such cases? Remove all spaces, change them to
underscores or what else?

A.
