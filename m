From: Jaroslaw Sobierski <fycio@gucio.com>
Subject: Re: S/PDIF on AD1980 patch
Date: Thu, 20 Feb 2003 01:01:52 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045731712.3e549980214db@webmail.namezero.com>
References: <1045497687.3e5107575caeb@webmail3.namezero.com> <s5hheb1h6cy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hheb1h6cy.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@suse.cz, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Quoting Takashi Iwai <tiwai@suse.de>:

> At Mon, 17 Feb 2003 08:01:27 -0800,
> Jaroslaw Sobierski wrote:
> > 
> > 
> > Another question though. I still cannot get the AC3 pass-through to work.
> > I assume the spdif source must be set to AC-Link (which is hw-reset default
> 
> > anyway), and I figure all other stuff should be set by alsa (like
> Category
> > Code, etc.). I have no problem with AC3 on emu10k1, so I guess mplayer is
> > requesting correct stream params from alsa. Yet on AC97 I can't get it to
> 
> > work (amp keeps indicating a PCM stream). Any suggestions what to look
> for?
> 
> hmm.. ICH4 has a separate SPDIF channel and it looks like we don't use
> this properly.  that is, SPDIF is routed via the normal slot 3/4.
> perhaps we should route the spdif via slot 10/11 (in GLOB_CNT bit
> 30:31 to 1:1), and set SPSA to the corresponding value.
> the definition of iec958 in ICH.conf should be rewritten, too...
The default configuration for ad1980 is to use slots 7/8. 3/4 is not
the best choice since the DACs are set to this by default. I don't
think ICH4 has anything to do with this, I downloaded the specs a while
ago only to realize that it just gives you access to the ac97 regs and
that's it. There's practically nothing to configure on the south bridge
itself.

> 
> anyway,  can you check whether the register 0x3a is set correctly when
> mplayer tries to play ac3?
> 
Yes and no :-). I dumped all ac97 regs from /proc and was going to send
you teh list, but they did not change at all between PCM and ac3. I later
discovered, quite by accident, that for some reason ac3 is never routed
to the ac97 codec - when I choose the hwac3 option the stream always
goes to emu10k1 (and plays correctly over its spdif), even though I 
explicitly specify "hw:1". I have to try unloading the modules for emu and 
see what happens then. But this seems anyway a bug. Unless the ICH driver
declares no possibilty to create open ac3 stream and alsa falls back on
the default card? 

--------------
Fycio (J.Sobierski)
 fycio@gucio.com


-------------------------------------------------------
This SF.net email is sponsored by: SlickEdit Inc. Develop an edge.
The most comprehensive and flexible code editor you can use.
Code faster. C/C++, C#, Java, HTML, XML, many more. FREE 30-Day Trial.
www.slickedit.com/sourceforge
