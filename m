From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] alsa-lib: snd_device_name_hint misbehaving
Date: Tue, 3 Nov 2009 16:48:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0911031645400.5500@eeebox2.perex-int.cz>
References: <1257128586.16837.29.camel@dark-knight>
	<s5hy6mpvzus.wl%tiwai@suse.de>
	<1257172994.2856.2.camel@dark-knight>
	<s5hljipvuvd.wl%tiwai@suse.de>
	<1257184700.1937.8.camel@dark-knight>
	<s5hocnk9j9t.wl%tiwai@suse.de> <s5hhbtc9gr4.wl%tiwai@suse.de>
	<1257262091.12479.19.camel@dark-knight>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 56FB81038FA
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 16:48:14 +0100 (CET)
In-Reply-To: <1257262091.12479.19.camel@dark-knight>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Nov 2009, John Lindgren wrote:

> On Tue, 2009-11-03 at 09:03 +0100, Takashi Iwai wrote:
>> Since no problem is found with valgrind, I applied the patch to git tree
>> now.
>
> Thanks.  I compiled the git version and the problem is fixed. Here are
> the other changes, split into four separate patches:

I applied your changes. But please ... send one patch in one e-mail in 
future to reduce our work with patch importing. Also, it makes sense to 
have one-line subject for patch and Signed-off-by: line in patches.

 				Thanks,
 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
