From: Andrew Morton <akpm@osdl.org>
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with
 CONFIG_PM=n
Date: Wed, 5 Jan 2005 13:27:11 -0800
Message-ID: <20050105132711.70f74ecc.akpm__33879.8423683786$1104964056$gmane$org@osdl.org>
References: <OF5A3BD386.A1A4C579-ON86256F7F.00688E0E@raytheon.com>
	<s5his6cm1re.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.osdl.org (fw.osdl.org [65.172.181.6])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B0DCB2CA
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 22:27:49 +0100 (MET)
In-Reply-To: <s5his6cm1re.wl@alsa2.suse.de>
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
Cc: Mark_H_Johnson@raytheon.com, bunk@stusta.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> The default blocking behavior of OSS devices was changed recently.
>  When the device is in use, open returns -EBUSY immediately in the
>  latest version while it was blocked until released in the former
>  version.
> 

whoa.  That's a significant change in user-visible behaviour.  Why was this
done?


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
