From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: 2.6.10-mm1: ALSA ac97 compile error with
	CONFIG_PM=n
Date: Thu, 06 Jan 2005 16:30:27 +0000
Message-ID: <1105024104.24896.219.camel__45797.9147592143$1105038494$gmane$org@localhost.localdomain>
References: <OF5A3BD386.A1A4C579-ON86256F7F.00688E0E@raytheon.com>
	 <s5his6cm1re.wl@alsa2.suse.de>  <20050105132711.70f74ecc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 68E0A31C
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2005 18:34:37 +0100 (MET)
Received: from localhost.localdomain (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id 001EB406E4
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2005 18:34:36 +0100 (MET)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mark_H_Johnson@raytheon.com, bunk@stusta.de, alsa-devel@alsa-project.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Mer, 2005-01-05 at 21:27, Andrew Morton wrote:
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

It now emulates the later OSS PCI and other devices not 2.2 OSS. As such
its the right thing to have done for emulation of OSS IMHO. It also
works with more apps several of which hang on opening /dev/dsp0
expecting OSS -EBUSY responses.



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
