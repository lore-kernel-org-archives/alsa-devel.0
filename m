From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: [PATCH] ALSA: hda - Add forced codec-slots
 for	ASUS W5Fm
Date: Mon, 25 May 2009 00:24:07 +0300
Message-ID: <4A19BAF7.10502@pardus.org.tr>
References: <1243080004-32721-1-git-send-email-ozan@pardus.org.tr>	<4A194E7C.8060505@pardus.org.tr>
	<s5hr5yev43c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pardus.org.tr (comar.uludag.org.tr [193.140.100.220])
	by alsa0.perex.cz (Postfix) with ESMTP id AD4E324434
	for <alsa-devel@alsa-project.org>;
	Sun, 24 May 2009 23:24:03 +0200 (CEST)
In-Reply-To: <s5hr5yev43c.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> Thanks, applied now with a minor fix (reordering the entry).
>
> But, looking at the change, it might be that the entry 1046:1262 could
> be a typo.  It should be harmless, though :)
>
>   
Yes it's strange that the vendor ID seems different from one variant to
another.

BTW, is the 3rd parameter to the macro is used for DMI matching or is it
just for informational purposes?

Thanks,
