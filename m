From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
Date: Wed, 05 Jan 2005 16:43:30 -0500
Message-ID: <1104961410.12817.3.camel__7563.25503248281$1104965156$gmane$org@krustophenia.net>
References: <OF5A3BD386.A1A4C579-ON86256F7F.00688E0E@raytheon.com>
	 <s5his6cm1re.wl@alsa2.suse.de>  <20050105132711.70f74ecc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 3E8F4305
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 22:43:32 +0100 (MET)
In-Reply-To: <20050105132711.70f74ecc.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark_H_Johnson@raytheon.com, bunk@stusta.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-05 at 13:27 -0800, Andrew Morton wrote:
> Takashi Iwai <tiwai@suse.de> wrote:
> >
> > The default blocking behavior of OSS devices was changed recently.
> >  When the device is in use, open returns -EBUSY immediately in the
> >  latest version while it was blocked until released in the former
> >  version.
> > 
> 
> whoa.  That's a significant change in user-visible behaviour.  Why was this
> done?

http://sourceforge.net/mailarchive/message.php?msg_id=10011826

Lee



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
