From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
Date: Wed, 05 Jan 2005 14:56:09 +0000
Message-ID: <1104936968.24187.180.camel@localhost.localdomain>
References: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DF86D316
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 17:00:21 +0100 (MET)
Received: from localhost.localdomain (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 5916E404F4
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 17:00:21 +0100 (MET)
In-Reply-To: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark_H_Johnson@raytheon.com
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Mer, 2005-01-05 at 14:21, Mark_H_Johnson@raytheon.com wrote:
> > The default blocking behavior of OSS devices was changed recently.
> > When the device is in use, open returns -EBUSY immediately in the
> > latest version while it was blocked until released in the former
> > version.
> I suppose there was a "good reason" for changing the user level
> interface in this way. Could you [or someone else] explain that and
> if you would consider changing it back (to stop breaking old applications)?
> Otherwise - is there some way (other than running lsmod and grep) to find
> out if the interface is busy and which application is using it?

OSS itself changed behaviour over time (2.2 to 2.4) ALSA has merely
caught up with the newer OSS behaviour and the new behaviour is correct.

If you want to find out if the interface is busy open it. If you want to
do it portably open it with O_NDELAY.



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
