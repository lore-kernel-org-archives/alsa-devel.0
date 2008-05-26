From: Travis Place <wishie@wishie.net>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH=5D_Added_support_to_HDAIntel?=
	=?iso-8859-1?q?_driver_for_the=09Foxconn_P35AX-S_mainboard?=
Date: Mon, 26 May 2008 23:33:18 +1000
Message-ID: <200805262333.18391.wishie@wishie.net>
References: <200805210012.02703.wishie@wishie.net>
	<s5h8wxxtjh8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-100-089.dial.usertools.net [202.137.100.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 520F810381F
	for <alsa-devel@alsa-project.org>;
	Mon, 26 May 2008 15:36:50 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id ECAE666995
	for <alsa-devel@alsa-project.org>; Mon, 26 May 2008 13:58:00 +1000 (EST)
In-Reply-To: <s5h8wxxtjh8.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 26 May 2008 9:04:03 pm Takashi Iwai wrote:
> At Wed, 21 May 2008 00:12:02 +1000,
>
> Travis Place wrote:
> > Without forcing model type to 6stack-dig, the user gets no sound.
> >
> > Patch is attached, and alsa-info.sh output is at
> > http://pastebin.ca/1023781.
> >
> > Changelog: Added IDs for the Foxconn P35AX-S mainboard to
> > patch_realtek.c, so that ALC883_6ST_DIG is used by default.
> >
> > Signed-off-by: Travis Place <wishie at wishie dot net>
>
> It's also in the upstream, too.
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Sorry for the 3 seperate posts Takashi..

Is it ok for me to unify the patches (in the future) and send 1 unified 
changelog ? Or is it preferred that the patches(and thei changelogs) are 
seperate ?

Thanks,
Travis Place


-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
