From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: Problems with Intel HDA driver
Date: Mon, 14 Sep 2009 16:41:10 +0300
Message-ID: <4AAE47F6.60505@pardus.org.tr>
References: <dfc471050909140433t28ea15ocf7883a62bb3a262@mail.gmail.com>	<s5h7hw1lnlr.wl%tiwai@suse.de>
	<4AAE38E6.8010102@pardus.org.tr>	<s5h3a6pln35.wl%tiwai@suse.de>
	<4AAE41D6.1020600@pardus.org.tr>	<s5hskepk6pi.wl%tiwai@suse.de>
	<s5hocpdk6di.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id DDD832415E
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 15:37:02 +0200 (CEST)
In-Reply-To: <s5hocpdk6di.wl%tiwai@suse.de>
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

Takashi Iwai wrote On 14-09-2009 16:23:
> I looked through alsa-info output now, and found the culprit.
> NID 0x0f is set as a line-out, and currently the driver doesn't
> don't do auto-muting for line-out unless a headphone is present.
> Changing it to a headphone should fix.  Or you can give hp_detect=1
> hint via sysfs and reconfigure.
>
>   

Yes! hp_detect=1 worked altogether with passing hp-dv5 model. I'm ready
to test any patch you suggest.
