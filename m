From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Problems with Intel HDA driver
Date: Mon, 14 Sep 2009 16:15:02 +0300
Message-ID: <4AAE41D6.1020600@pardus.org.tr>
References: <dfc471050909140433t28ea15ocf7883a62bb3a262@mail.gmail.com>	<s5h7hw1lnlr.wl%tiwai@suse.de>
	<4AAE38E6.8010102@pardus.org.tr> <s5h3a6pln35.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BDDD10382C
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 15:10:53 +0200 (CEST)
In-Reply-To: <s5h3a6pln35.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, =?UTF-8?B?QW5kcml1cyDFoHRpa29uYXM=?= <stikonas@gmail.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote On 14-09-2009 15:36:
>
> Yeah, I think we can add EAPD handling as default for IDT92HD71xx
> codecs.  I've never seen machines that can't live with GPIO0 bit up.
>   

enable_msi doesn't seem to affect the auto-muting problem. I played with
every single node in hda-analyzer but can't get auto-mute work. I can
manually mute the HP output and the internal speakers by
checking/unchecking OUT checkboxes on relevant NIDs. There's a 8xn
matrix for GPIO settings, I played with them as well to set unsol but nope.

I want to remember that dell-m4-1 makes automute work but breaks the
mixer channels:

http://www.spinics.net/lists/alsa-devel/msg26714.html

Err, I know that I didn't answer the last question in the thread as I'm
a little bit lost in the NID pool and didn't have time to investigate
further.
