From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: snd-rme9652 fails
Date: Mon, 22 Dec 2003 13:43:27 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312221340010.8959@pnote.perex-int.cz>
References: <200312221238.hBMCcqlt015332@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200312221238.hBMCcqlt015332@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Sergey Vlasov <vsu@altlinux.ru>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 22 Dec 2003, Paul Davis wrote:

> i'm a bit late to the party, but ...
> 
> >> > --- rme9652.c.ORIGINAL	Thu Dec 18 23:43:36 2003
> >> > +++ rme9652.c	Thu Dec 18 23:45:12 2003
> >> > @@ -1618,7 +1618,6 @@
> >> >  RME9652_SPDIF_RATE("IEC958 Sample Rate", 0),
> >> >  RME9652_ADAT_SYNC("ADAT1 Sync Check", 0, 0),
> >> >  RME9652_ADAT_SYNC("ADAT2 Sync Check", 0, 1),
> >> > -RME9652_ADAT_SYNC("ADAT3 Sync Check", 0, 2),
> >> >  RME9652_TC_VALID("Timecode Valid", 0),
> >> >  RME9652_PASSTHRU("Passthru", 0)
> >> >  };
> >> 
> >> Yes, duplicated controls ARE NOT ALLOWED NOW. Applied. Thanks.
> 
> how did this code imply a duplicate control? removing it is
> *wrong*, utterly wrong. it is an important control for some purposes.

It seems that this control is available only for 9652 not for 9632 
version. The same control was used and defined twice for 9652 while with 
9632 was probably useless:

....

static snd_kcontrol_new_t snd_rme9652_adat3_check =
RME9652_ADAT_SYNC("ADAT3 Sync Check", 0, 2);

....

       if (rme9652->ss_channels == RME9652_NCHANNELS)
               if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_rme9652_adat3_check, rme9652))) < 0)
                       return err;


						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
