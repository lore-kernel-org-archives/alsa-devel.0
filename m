From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH]snd-usb-usx2y 0.7.2a
Date: Mon, 13 Sep 2004 20:04:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409132004.29086.annabellesgarden@yahoo.de>
References: <200409121133.46219.annabellesgarden@yahoo.de> <200409131908.09116.annabellesgarden@yahoo.de> <s5h3c1mt6qa.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h3c1mt6qa.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Montag 13 September 2004 19:32 schrieb Takashi Iwai:
> At Mon, 13 Sep 2004 19:08:08 +0200,
>
> Karsten Wiese wrote:
> > Am Montag 13 September 2004 18:30 schrieb Takashi Iwai:
> > > At Sun, 12 Sep 2004 11:33:46 +0200,
> > >
> > > Karsten Wiese wrote:
> > > > [1  <text/plain; us-ascii (7bit)>]
> > > > Hi Takashi,
> > > >
> > > > I found some improvements in the current kernel's version.
> > > > Please also apply in cvs.
> > >
> > > Could you send the summary and the description of the patch for
> > > changelog?
> >
> > summary:
> >   Coding style changes and sanity checks
> >   ported back from kernel 2.6.9-rc1-bk12.
>
> Did it a simply backport from linus bk?  Or did you add your own
> changes?  If you added changes, please split the patch into two
> pieces, the backport (2.6-bk-sync) and your changes.

Erm, I found those changes while toying with the voluntary preemption patches.
I patched the kernel 2.6.8 with stuff from people.redhat.com/~mingo up to 
bk12.
Didn't add any change myself.
And don't know who did the changes for shure.
A guess would be Alexander Viro as there is a note about him having changed 
"usx2y" in the 2.6.9-rc2 announcement (but no details).

thanks,
Karsten



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
