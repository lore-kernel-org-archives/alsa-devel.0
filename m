From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
Date: Wed, 05 Jan 2005 12:23:51 -0500
Message-ID: <1104945831.8589.25.camel@krustophenia.net>
References: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
	 <1104936968.24187.180.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id CAC3631F
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 18:24:31 +0100 (MET)
In-Reply-To: <1104936968.24187.180.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark_H_Johnson@raytheon.com, Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-05 at 14:56 +0000, Alan Cox wrote:
> On Mer, 2005-01-05 at 14:21, Mark_H_Johnson@raytheon.com wrote:
> > > The default blocking behavior of OSS devices was changed recently.
> > > When the device is in use, open returns -EBUSY immediately in the
> > > latest version while it was blocked until released in the former
> > > version.
> > I suppose there was a "good reason" for changing the user level
> > interface in this way. Could you [or someone else] explain that and
> > if you would consider changing it back (to stop breaking old applications)?
> > Otherwise - is there some way (other than running lsmod and grep) to find
> > out if the interface is busy and which application is using it?
> 
> OSS itself changed behaviour over time (2.2 to 2.4) ALSA has merely
> caught up with the newer OSS behaviour and the new behaviour is correct.
> 
> If you want to find out if the interface is busy open it. If you want to
> do it portably open it with O_NDELAY.
> 

And if you want to find out who is using it then try fuser /dev/dsp,
fuser /dev/snd/*, or lsof.

Lee



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
