From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [Fwd: Re: [PATCH] cs46xx DAC volume's mechanism
 rewrite, minor bugfixes]
Date: Mon, 11 Nov 2002 13:32:35 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33L2.0211111327340.14846-100000@cactus>
References: <Pine.LNX.4.33.0211110947460.521-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211110947460.521-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Peter Good <psgood@petesinternet.net>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > Then maybe someone knows what xine uses the
> > AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2 values to,
> > do they need to interfaces to the lowlevel driver ???
>
> It's first 32-bits to setup the channel status block in the S/PDIF
> stream. The main job is to tell the remote receiver, that data are
> 'non-audio' (bit 1 = 1).

My first guess, how is this values interfaced to the lowlevel driver ?
I believe that I dont need to have any "AC3 Mode" switch in the
mixer if there already is way to know if application is opening
the IEC958 port for AC3/raw-data.

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
