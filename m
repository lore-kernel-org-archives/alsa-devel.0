From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: mm snapshot broken-out-2007-03-05-02-22.tar.gz
	uploaded
Date: Wed, 7 Mar 2007 23:16:51 +0100
Message-ID: <6bffcb0e0703071416j2217623bxbef6d24ddf755630@mail.gmail.com>
References: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>
	<45EC2DEB.1050108@googlemail.com> <45EEA3C4.7000501@googlemail.com>
	<20070307104746.f08a2e84.akpm@linux-foundation.org>
	<6bffcb0e0703071141j42309702w793e4a76b1b23bfa@mail.gmail.com>
	<20070307115024.756c848f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa0.perex.cz (Postfix) with ESMTP id F1B162432C
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2007 23:16:53 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id n29so345113nfc
	for <alsa-devel@alsa-project.org>; Wed, 07 Mar 2007 14:16:53 -0800 (PST)
In-Reply-To: <20070307115024.756c848f.akpm@linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 07/03/07, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 7 Mar 2007 20:41:30 +0100 "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > > > 831466f4ad2b5fe23dff77edbe6a7c244435e973 is first bad commit
> > > > commit 831466f4ad2b5fe23dff77edbe6a7c244435e973
> > > > Author: Randy Cushman <rcushman_linux@earthlink.net>
> > > > Date:   Tue Dec 19 18:42:16 2006 +0100
> > > >
> > > >     [ALSA] ac97 - fix microphone and line_in selection logic
> > > >
> > > >     This patch fixes the Microphone and LINE_IN select logic for
> > > >     Analog Devices surround codecs with shared jacks.  The existing
> > > >     code can never utilize the shared jacks for Microphone and LINE_IN
> > > >     due to the reversed jack selection logic.  The patched code
> > > >     correctly selects the shared jack for input if the 'Channel Mode'
> > > >     selector does not specify that the jack is to be used for output.
> > > >     Specifically, in '2ch' mode the Center/LFE jack is used for
> > > >     microphone input and the Surround jack is used for LINE_IN,
> > > >     in '4ch' mode the Center/LFE jack is used for microphone input
> > > >     and the Surround jack is used for output, and in '6ch' mode
> > > >     both jacks are used for output.
> > > >
> > > >     Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>
> > > >     Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > >     Signed-off-by: Jaroslav Kysela <perex@suse.cz>
> > > >
> > >
> > > Is 2.6.21-rc3 similarly broken?
> >
> > Yes.
> >
>
> OK.  Can you please confirm that applying the below fixes 2.6.21-rc3?

Yes, I can confirm that.

>
> If so, I'll queue it up for application in a week or two if there is no
> progress on this.
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
