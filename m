From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH] cs46xx memory management fixes for cs46xx_dsp_spos_create()
 - make sure we free and don't do pointless work.
Date: Sat, 30 Oct 2010 21:44:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1010302143530.1572@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1010292242080.24561@swampdragon.chaosbits.net> <4CCB4851.7080701@hostmobility.com> <201010301406.12961.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1140537297-1288467873=:1572"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201010301406.12961.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: =?ISO-8859-15?Q?Benny_Sj=F6strand?= <benny@hostmobility.com>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1140537297-1288467873=:1572
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 30 Oct 2010, Ondrej Zary wrote:

> On Saturday 30 October 2010 00:18:57 Benny Sjöstrand wrote:
> > Hello again!
> >
> > Just doing a reply-all.
> > It's has been many years since I did anything to the cs46xx driver, so
> > I'm wondering
> > if there's anyone out there still using a cs46xx sound card?
> > I think the changes look's correct, but I can't test it, I do not have a
> > cs46xx hardware anymore.
> 
> Sure, there are many of these cards "out there". I just got a "new" Terratec 
> DMX Xfire 1024 (CS4624). I'll test the patch.
> 

Thanks a lot. Let me know how the test goes :-)

-- 
Jesper Juhl <jj@chaosbits.net>             http://www.chaosbits.net/
Plain text mails only, please      http://www.expita.com/nomime.html
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html

--8323328-1140537297-1288467873=:1572--
