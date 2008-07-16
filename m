From: Sergei Steshenko <steshenko_sergei@list.ru>
Subject: Re:
	=?koi8-r?b?aXMgdGhpcyBjYXJkIHN1cHBvcnRlZCBieSBBTFNB?=
	=?koi8-r?b?Pw==?=
Date: Thu, 17 Jul 2008 00:30:15 +0400
Message-ID: <E1KJDdf-0004kJ-00.steshenko_sergei-list-ru@f143.mail.ru>
References: <BLU137-W701C780DA17174DEA342E958F0@phx.gbl>
Reply-To: Sergei Steshenko <steshenko_sergei@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <BLU137-W701C780DA17174DEA342E958F0@phx.gbl>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, Rene Herman <rene.herman@keyaccess.nl>, devel <alsa-devel@alsa-project.org>, alsa@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org



-----Original Message-----
From: Landis McGauhey <b3zdomny@hotmail.com>
To: Rene Herman <rene.herman@keyaccess.nl>
Date: Wed, 16 Jul 2008 13:15:19 -0700
Subject: Re: [Alsa-user] is this card supported by ALSA?

> 
> 
> 
> > Date: Wed, 16 Jul 2008 20:50:21 +0200
> > From: rene.herman@keyaccess.nl
> > To: b3zdomny@hotmail.com
> > CC: tiwai@suse.de; alsa-user@lists.sourceforge.net; alsa-devel@alsa-project.org; alsa@sc8-sf-spam2.sourceforge.net
> > Subject: Re: [Alsa-user] is this card supported by ALSA?
> > 
> > On 16-07-08 20:00, Landis McGauhey wrote:
> > 
> > > OK, this is interesting:
> > > 
> > > # patch -p1 -r < ens1371-ac97_reset_hack.diff=
> > > bash:ens1371-ac97_reset_hack.diff: No such file or directory
> > > 
> > > # patch -p1 -r < ens1371-ac97.diff
> > > bash: ens1371-ac97.diff: No such file or directory
> > > 
> > > Go figure.
> > 
> > Of course. You've done this a number of times now, so I took for granted 
> > that by now you'd understand to put in the path yourself. You saved 
> > these diff's from earlier mssages.
> > 
> > > Attached are two high-res pix of the card. The smallest chips were
> > > just too darned small for me to read the printing; maybe you can
> > > magnify the pix and make something of them.
> > 
> > A CT4730. You have an onboard amp (and it's disabled -- setting both the 
> > jumpers to the SPK position enables it but keeping it disabled is better 
> > if you don't really need it; these opamps suck).
> > 
> > Moreover, the AC97 codec seems integrated in the EV1938. Just found a 
> > patch for FreeBSD following up a similar report for your card. Will look 
> > at it tomorrow.
> > 
> > Rene.
> 
> 
> OK, thanks!  As for the "patch -p1 -r" commands, I see.  I already had sent the diff's to the recycle bin, so following your message, I restored them and then ran the commands again with the paths.  They erred out with a complaint that "option requires an argument -- r".  I'm reading the manual now, I'll figure it out, you go get some sleep!
> 
> as always, many thanks and best regards,
> 
> Landis
>   
> _________________________________________________________________
> Time for vacation? WIN what you need- enter now!
> http://www.gowindowslive.com/summergiveaway/?ocid=tag_jlyhm
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> 
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user
> 
> 

Maybe Rene meant '-R' (reverse patch) rather than '-r rejects_file'.

Regards,
  Sergei.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
