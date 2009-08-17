From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: How to use hda-verb to detect
Date: Mon, 17 Aug 2009 12:41:39 +0300
Message-ID: <4A8925D3.2000203@pardus.org.tr>
References: <4A89219E.20400@pardus.org.tr> <s5hljlieqcn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 87C8110380C
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 11:38:06 +0200 (CEST)
In-Reply-To: <s5hljlieqcn.wl%tiwai@suse.de>
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

Takashi Iwai wrote On 17-08-2009 12:34:
> For SET_UNSOLICITED_ENABLE verb, you need to a value (TAG | AC_USRSP_EN).
> in the case of above, suppose the tag to be 0x0c, pass 0x8c.
>
>   
Okay I've got the mechanism, thanks.

How can I help for fixing HP automuting? setting UNSOLICITED_ENABLE
didn't help at all.
