From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: Re: [Cooker] Switching between OSS and Alsa
Date: Wed, 21 Aug 2002 13:15:40 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <11783.3614386202$1029930497@news.gmane.org>
References: <1029774368.11431.11.camel@foxbase.home.net>
	<m2bs7yrelk.fsf@vador.mandrakesoft.com> <3D630802.302@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from vador.mandrakesoft.com (office.mandrakesoft.com [195.68.114.34])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA28252
	for <alsa-devel@alsa-project.org>; Wed, 21 Aug 2002 13:16:09 +0200
In-Reply-To: <3D630802.302@yahoo.com> (Eugenio Diaz's message of "Tue, 20
 Aug 2002 23:24:50 -0400")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: cooker@linux-mandrake.com, Jaroslav Kysela <perex@suse.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Eugenio Diaz <getnito@yahoo.com> writes:

> > > Fresh install today of latest Cooker on a notebook with CS46xx
> > > sound chipset.
> > >
> > > As reported earlier, because of OSS drivers - I get a double
> > > (echo) sound. I want to switch to Alsa but there is not easy way
> > > to do it (through harddrake2 or sndconfig)
> > >
> > > What's the recommended way to switch between OSS and Alsa?
> > 
> > send me the output of "lspcidrake -v" and the alsa module to use,
> > and i'll alter the pcitable.
>
> The only problem being that this is a 4-channel card, and alsa
> supports only 2 while OSS supports all 4 channels!
>
> I remember exchanging emails with you about this, and the problem
> where the mixer control labels for the front channels and the main
> volume were reversed, back in early June. Back then you forwarded
> the problem to jaroslav (alsa main developer and snd-cs46xx author),
> but the problems are still there ...
>
> I am still using OSS just because it supports the 4-channels, and
> that makes a big difference; but I have to remove and reload the
> modules every now and then (like once every two days) because the
> sound gets corrupted.

Jaroslav ?



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
