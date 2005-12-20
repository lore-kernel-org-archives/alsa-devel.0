From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [RFC: 2.6 patch] Makefile: sound/ must come before
 drivers/
Date: Tue, 20 Dec 2005 22:24:05 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0512202220040.12853__36690.0195055225$1135114073$gmane$org@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>
 <20051220131810.GB6789@stusta.de> <20051220155216.GA19797@master.mivlgu.local>
 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org> <20051220191412.GA4578@stusta.de>
 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org> <20051220202325.GA3850@stusta.de>
 <Pine.LNX.4.64.0512201240480.4827@g5.osdl.org> <43A86DCD.8010400@superbug.co.uk>
 <20051220211359.GA5359@stusta.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 56C961AD
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2005 22:24:06 +0100 (MET)
In-Reply-To: <20051220211359.GA5359@stusta.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adrian Bunk <bunk@stusta.de>
Cc: James Courtier-Dutton <James@superbug.co.uk>, Linus Torvalds <torvalds@osdl.org>, Sergey Vlasov <vsu@altlinux.ru>, Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, video4linux-list@redhat.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 20 Dec 2005, Adrian Bunk wrote:

> On Tue, Dec 20, 2005 at 08:47:09PM +0000, James Courtier-Dutton wrote:
> > Linus Torvalds wrote:
> > >
> > >On Tue, 20 Dec 2005, Adrian Bunk wrote:
> > >
> > >>But the non-saa7134 access to my soundcard (e.g. rexima or xmms) is no 
> > >>longer working.
> > >
> > >
> > >Ahh. I assume it's the sequencer init etc that is missing.
> > >
> > >Maybe we'll just have to do the late_init thing for at least the 2.6.15 
> > >timeframe.
> > >
> > >		Linus
> > >
> > 
> > But that's not really a useable fix. The problem is with almost all ALSA 
> > sound cards.
> 
> No, inside sound/ it's working due to the link order.
> 
> Thinking about this, what about the patch below?
>
> -drivers-y	:= drivers/ sound/
> +drivers-y	:= sound/ drivers/

It might break the "video" subsystem, because we have a lowlevel code 
for radio tuners in our code.

Basically, everything from /sound/core tree should be initialized at first 
before any lowlevel driver is loaded, except /sound/core/oss and
/sound/core/seq/oss subtrees.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
