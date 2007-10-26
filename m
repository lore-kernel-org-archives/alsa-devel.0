From: "Kay Sievers" <kay.sievers@vrfy.org>
Subject: Re: [alsa-devel] sysfs: WARNING: at fs/sysfs/dir.c:424 sysfs_add_one() - with ALSA
Date: Fri, 26 Oct 2007 18:17:38 +0200
Message-ID: <3ae72650710260917t3ed93450gd5aa97d1337273f0@mail.gmail.com>
References: <877aabc40710260014v220ab804o5de5dbc36b870bd1@mail.gmail.com>
	 <20071026091722.GA21274@linux.vnet.ibm.com>
	 <20071026155202.GD23016@kroah.com> <s5hzly6nen8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763676AbXJZQRt@vger.kernel.org>
In-Reply-To: <s5hzly6nen8.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, alsa-devel@alsa-project.org, Amit Shah <amitshah@gmx.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10/26/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 26 Oct 2007 08:52:02 -0700,
> Greg KH wrote:
> >
> > On Fri, Oct 26, 2007 at 02:47:22PM +0530, Kamalesh Babulal wrote:
> > > I get similar warning, while loading the alsa driver
> >
> > This is a different problem, not a rename issue like the network one
> > was.
> >
> > > [  191.933548] Advanced Linux Sound Architecture Driver Version 1.0.15
> > > (Tue Oct 23 06:09:18 2007 UTC).
> > > [  191.996323] ALSA sound/core/seq/oss/seq_oss.c:232: can't register
> > > device seq
> > > [  192.046004] sysfs: duplicate filename 'audio' can not be created
> > > [  192.086048] WARNING: at fs/sysfs/dir.c:424 sysfs_add_one()
> >
> > This is an error in the alsa core, perhaps the alsa developers can help
> > figure out why they are registering the same file twice?
>
> ALSA core shouldn't do so.  Maybe a built-in OSS driver conflict with
> ALSA?  We'd need to check .config, then.

Maybe:
   find /sys/ -name audio
shows the devpath of the already existing device?

Kay
