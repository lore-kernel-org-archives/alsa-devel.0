From: Mark_H_Johnson@raytheon.com
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with CONFIG_PM=n
Date: Wed, 5 Jan 2005 12:15:50 -0600
Message-ID: <OF26B98961.8FD70ADB-ON86256F80.00645396-86256F80.006453DD@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from dfw-gate2.raytheon.com (dfw-gate2.raytheon.com [199.46.199.231])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8D129203
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 20:49:34 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

> At Wed, 5 Jan 2005 08:21:20 -0600,
> Mark_H_Johnson@raytheon.com wrote:
[snip - back & forth on the blocking behavior]
> > I suppose there was a "good reason" for changing the user level
> > interface in this way. Could you [or someone else] explain that and
> > if you would consider changing it back (to stop breaking old
applications)?
>
> It was discussed on alsa-devel in November.  Unfortunately, I can't
> find ML archive any longer...
>
> The blocking behavior of OSS is a feature which is nowehre defined.
> Some OSS drivers open in the blocking mode and some don't.
> So, apps shouldn't depend on this feature.
>
> We had implemented OSS emulation in the blocking manner since we
> intepreted the POSIX definition in that way.  But Linus pointed out
> that it's a misreading.
>
> BTW, you can enable the blocking mode again via module/boot option.
> See OSS-Emulation.txt.
>
Thanks for the explanation and the suggested work around. Thanks
also to Lee Revell for his other suggestion (using fuser). I should
be able to work around this OK for now.

> > > [snip - rehash of symptoms]
> Please provide the hardware details (I don't see your original post to
> lkml).  Otherwise it'll be a vapor discusson...

Details provided separately. Basically it is a two CPU system (866 Mhz
Pentium III) with an Ensoniq sound card. I use this system primarily
for comparative tests of kernels (for RT latency) before moving a
kernel update to other system for more comprehensive tests.

  --Mark



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
