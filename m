From: Alex Song <asong@xvdcorp.com>
Subject: RE: ATI IXP SPDIF
Date: Wed, 26 May 2004 15:19:05 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1649E0C057D17842BA917E5124BF331A15BD7D@as2.alaris.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: "'alsa-devel@lists.sourceforge.net'" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hi,

i happened to have that ASUS mobo (P4R800-VM) which has an ATIIXP/AD1888 and
both PCM and ac3 pass through works with SPDIF.
but the board i am trying to get working has an ATIIXP/ALC655 and i had a
look at the realtek site and they had some drivers
(http://www.realtek.com.tw/downloads/dlac97-2.aspx?lineid=5&famid=12&series=
8&Software=True) which looks like they were based off alsa-1.0.4. just doing
a quick diff i see that they added some SPDIF stuff amongst other things.
after testing and some code diffing this is what i figured:

alsa-1.0.4			broken atiixp-spdif	broken alc655-spdif
realtek-alsa-1.0.4	broken atiixp-spdif	working alc655-spdif
alsa-cvs			working atiixp-spdif	broken alc655-spdif

i am going to try and hack together some combination of realtek-alsa-1.0.4
and alsa-cvs and see if what i figured is right or not. it would be great if
one of the alsa developers can look into realtek-alsa-1.0.4 and merge those
changes into alsa.

cheers,

alex

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, May 25, 2004 2:45 AM
> To: Alex Song
> Cc: 'alsa-devel@lists.sourceforge.net'
> Subject: Re: [Alsa-devel] ATI IXP SPDIF
> 
> 
> At Mon, 24 May 2004 16:16:42 -0700,
> Alex Song wrote:
> > 
> > hi,
> > 
> > i am trying to get SPDIF output working on ATI IXP/Realtek 
> ALC655 and i am
> > using atiixp.c from cvs (version 1.9) and linux kernel 
> 2.6.5. i tried
> > playing back wav files through aplay and ac3 files with 
> ac3play and i
> > couldn't get any output from either SPDIF over AC97 or 
> SPDIF Direct. analog
> > output is fine. from the cvs logs i gather that SPDIF on 
> ATI IXP should work
> > for some cases at least, has anyone got it to work? if so with what
> > files/hardware/settings etc?
> 
> it works fine on my test machine.  it's an ASUS mobo (forgot the
> model).
> 
> 	% ac3dec -C some-48k.ac3
> 
> or
> 
> 	% aplay -Dplug:spdif foo.wav
> 
> but the direct SPDIF mode doesn't work...
> 
> --
> Takashi Iwai <tiwai@suse.de>		ALSA Developer - 
> www.alsa-project.org
> 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
