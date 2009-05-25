From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: [PATCH] ALSA: hda - Add forced
 codec-slots	for	ASUS W5Fm
Date: Mon, 25 May 2009 09:07:50 +0300
Message-ID: <4A1A35B6.8050809@pardus.org.tr>
References: <1243080004-32721-1-git-send-email-ozan@pardus.org.tr>	<4A194E7C.8060505@pardus.org.tr>
	<s5hr5yev43c.wl%tiwai@suse.de>	<4A19BAF7.10502@pardus.org.tr>
	<s5hskitda2z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 0C11B103811
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 08:05:52 +0200 (CEST)
In-Reply-To: <s5hskitda2z.wl%tiwai@suse.de>
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

Takashi Iwai wrote On 25-05-2009 08:29:
>
> It's a string shown in debug messages.  It's compiled in only when the
> debug option is set.
>
> DMI matching could be another candidate for this kind of quirk, yes.
>
>   

Hm, so another box having exactly the same device(1043:1262) but no
problems in terms of model probing through BIOS, will be affected by
this quirk, right?
