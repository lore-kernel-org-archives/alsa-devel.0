From: =?iso-8859-1?q?karsten=20wiese?= <annabellesgarden@yahoo.de>
Subject: Re: Turtle Beach Pinnacle/Fiji alsa driver 0.1.3
Date: Tue, 9 Jul 2002 15:22:01 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020709132201.81296.qmail@web12208.mail.yahoo.com>
References: <s5h8z4mv7gr.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z4mv7gr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Takashi Iwai <tiwai@suse.de> wrote: > Hi Karsten,
> 
> At Sat, 6 Jul 2002 15:11:36 +0200 (CEST),
> karsten wiese wrote:
> > 
> > here is a newer version.
> > it doesn't crash the pc when using oss emulation
> > anymore. 
> > it can do 2 (or 3) periods per buffer now.
> 
> thanks for your work.
> now it's committed to cvs.  please check the cvs
> tree.

works fine here :-)

> 
> i changed slightly your patch:
> 
> - the module is renamed as snd-msnd-classic (with
> hyphen)
> - all stuffs are still on alsa-drivers.  will be
> moved to alsa-kernel
>   and submitted to 2.5 kernel tree later once after
> it's confirmed to
>   work fine.  this is our policy.
>   
> regarding to pnp.
> is it possible to integrate it using the standard
> isapnp api?
> or is it a specific one?

hmmm.., don't know & don't want to test that on this
machine, 'cause it is to also run NT4 (:no pnp for
stability) for commercial reasons.

> 
> 
> ciao,
> 
> Takashi 

can we put the firmware-binaries on cvs as well?
so far it is necessary to extract them with some extra
steps...

best,

Karsten

__________________________________________________________________

Gesendet von Yahoo! Mail - http://mail.yahoo.de
Yahoo! pr‰sentiert als offizieller Sponsor das Fuﬂball-Highlight des
Jahres: - http://www.FIFAworldcup.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Stuff, things, and much much more.
http://thinkgeek.com/sf
