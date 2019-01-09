From: Kailang <kailang@realtek.com>
Subject: Re: hp_pin was NULL value
Date: Wed, 9 Jan 2019 09:45:25 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18420EBD@RTITMBSV02.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18420E8B@RTITMBSV02.realtek.com.tw>
 <s5htviigoa5.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A2F22665E5
 for <alsa-devel@alsa-project.org>; Wed,  9 Jan 2019 10:45:32 +0100 (CET)
In-Reply-To: <s5htviigoa5.wl-tiwai@suse.de>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: " (alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>But this made me wonder whether we don't need to call this function at resume as well?  Currently it's called only at probing.
Yes, it only call at probing. Just need to call it at boot time.

-----Original Message-----
From: Takashi Iwai <tiwai@suse.de> 
Sent: Wednesday, January 9, 2019 5:43 PM
To: Kailang <kailang@realtek.com>
Cc: (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
Subject: Re: hp_pin was NULL value

On Wed, 09 Jan 2019 10:31:33 +0100,
Kailang wrote:
> 
> Hi Takashi,
> 
> Could I move the alc294_hp_init(codec) to below line.
> Because hp_pin = spec->gen.autocfg.hp_pins[0] was null value when alc294_hp_init(codec) at original line.
> Or move alc269_parse_auto_config() upward.

It looks OK to me.  But this made me wonder whether we don't need to call this function at resume as well?  Currently it's called only at probing.


thanks,

Takashi

------Please consider the environment before printing this e-mail.
