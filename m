From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
Date: Wed, 05 Jan 2005 13:04:38 -0500
Message-ID: <1104948279.8589.42.camel@krustophenia.net>
References: <OFB0B3CD59.F6AC2867-ON86256F80.004CECD3@raytheon.com>
	 <s5hhdlvyg6q.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 0C4F3307
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 19:08:48 +0100 (MET)
In-Reply-To: <s5hhdlvyg6q.wl@alsa2.suse.de>
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
Cc: Mark_H_Johnson@raytheon.com, Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-05 at 17:49 +0100, Takashi Iwai wrote:
> At Wed, 5 Jan 2005 08:21:20 -0600,
> Mark_H_Johnson@raytheon.com wrote:
> > 
> > > At Tue, 4 Jan 2005 13:25:40 -0600,
> > > Mark_H_Johnson@raytheon.com wrote:
> > > > [snip - how to get to the problem]
> > > > At this point, I get the window asking if I heard the sound (I did
> > not). If
> > > > I repeat the test after waiting a short period, it eventually succeeds.
> > >
> > > The default blocking behavior of OSS devices was changed recently.
> > > When the device is in use, open returns -EBUSY immediately in the
> > > latest version while it was blocked until released in the former
> > > version.
> > I suppose there was a "good reason" for changing the user level
> > interface in this way. Could you [or someone else] explain that and
> > if you would consider changing it back (to stop breaking old applications)?
> 
> It was discussed on alsa-devel in November.  Unfortunately, I can't
> find ML archive any longer...
> 

Heh, if you want the excruciating details, here are some pointers.  It's
a long thread, and unfortunately the threading is a little broken.

Here's a link to the technical part:

http://sourceforge.net/mailarchive/message.php?msg_id=10008900

And here's the rant that started it:

http://sourceforge.net/mailarchive/message.php?msg_id=10014826

Lee



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
