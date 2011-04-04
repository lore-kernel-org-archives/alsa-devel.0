From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: TerraTec DMX 6Fire USB updates
Date: Mon, 04 Apr 2011 11:41:31 +0200
Message-ID: <12f1fe37745.-6099889972348873698.-545195642910941622@zoho.com>
References: <12d995c1fa0.477955495632923443.5387390398635058860@zoho.com>
	<s5hr5c7bjmr.wl%tiwai@suse.de>
	<12da59486cd.-2882799020629445819.-7235974021966893201@zoho.com>
	<s5hmxmuiqgw.wl%tiwai@suse.de>
	<12da867d460.-8772675728917411279.-4777530225625691984@zoho.com>
	<12f0d60921e.7616534511239462585.4849758772336073987@zoho.com>
	<s5hr59mw2u5.wl%tiwai@suse.de>
	<12f1b580363.6419672029244585187.-6233154609191024090@zoho.com>
	<s5hwrjamq64.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id F16681038FD
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:41:33 +0200 (CEST)
In-Reply-To: <s5hwrjamq64.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

>Thanks. But, as you see, there are too many changes done in a single 
>patch. Could you split the changes into several incremental patches? 
>In principle, one patch should contain one change. Of course, some 
>trivial changes can be merged, but the above is way too much. 

Ok, got how it's done.

For the following patches be working correctly, please apply the patch previously supplied by Jesper Juhl ("Don't leak firmware when
usb6fire_fw_ihex_init() fails.") before if missing... I downloaded the current kernel and this patch didn't seem to be applied.

Thanks,
Torsten
