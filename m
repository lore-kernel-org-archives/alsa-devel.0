From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: [BUG] NULL pointer dereference in patch_sigmatel.c
Date: Mon, 10 Aug 2009 10:01:03 +0300
Message-ID: <4A7FC5AF.5050105@pardus.org.tr>
References: <4A5F84D6.5040708@pardus.org.tr>
	<s5h1vofac2z.wl%tiwai@suse.de>	<s5hy6qn8wyj.wl%tiwai@suse.de>
	<4A7ADD87.4030109@pardus.org.tr>	<s5hfxc5114w.wl%tiwai@suse.de>
	<4A7BF4F7.20405@pardus.org.tr>	<ad2655cb0908070243h6318dbdep80d90a08fa6c435b@mail.gmail.com>	<s5hiqh0ymkn.wl%tiwai@suse.de>
	<4A7C03BE.7040300@pardus.org.tr>	<s5hd477zyo1.wl%tiwai@suse.de>
	<4A7C2E87.1060102@pardus.org.tr>	<s5hljlvyc8m.wl%tiwai@suse.de>
	<4A7EBCB7.8010104@pardus.org.tr>	<s5h63cwvpbd.wl%tiwai@suse.de>
	<4A7F556E.9060809@pardus.org.tr>	<s5hiqgwns6n.wl%tiwai@suse.de>
	<s5hhbwgnrqw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.uludag.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id C9D59103808
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 08:57:39 +0200 (CEST)
In-Reply-To: <s5hhbwgnrqw.wl%tiwai@suse.de>
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

Takashi Iwai wrote On 10-08-2009 08:48:
>
> Doh, sorry a totally broken patch.  The fixed one is below.
>
> I could reproduce the bug with the emulator, and this patch fixes the
> issue.  Updated sound GIT tree and snapshot now.
>   

Both conexant one and the sigmatel one are now fixed. Thanks for all the
efforts :)
