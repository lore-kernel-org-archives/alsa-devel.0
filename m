From: Alex Song <asong@xvdcorp.com>
Subject: RE: ATI IXP SPDIF
Date: Thu, 27 May 2004 12:17:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1649E0C057D17842BA917E5124BF331A15BD7F@as2.alaris.com>
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

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, May 27, 2004 5:45 AM
> To: Alex Song
> Cc: 'alsa-devel@lists.sourceforge.net'
> Subject: Re: [Alsa-devel] ATI IXP SPDIF
> 
> 
> At Wed, 26 May 2004 15:19:05 -0700,
> Alex Song wrote:
> > 
> > hi,
> > 
> > i happened to have that ASUS mobo (P4R800-VM) which has an 
> ATIIXP/AD1888 and
> > both PCM and ac3 pass through works with SPDIF.
> > but the board i am trying to get working has an 
> ATIIXP/ALC655 and i had a
> > look at the realtek site and they had some drivers
> > 
> (http://www.realtek.com.tw/downloads/dlac97-2.aspx?lineid=5&fa
> mid=12&series=
> > 8&Software=True) which looks like they were based off 
> alsa-1.0.4. just doing
> > a quick diff i see that they added some SPDIF stuff amongst 
> other things.
> > after testing and some code diffing this is what i figured:
> > 
> > alsa-1.0.4			broken atiixp-spdif	broken 
> alc655-spdif
> > realtek-alsa-1.0.4	broken atiixp-spdif	working alc655-spdif
> > alsa-cvs			working atiixp-spdif	broken 
> alc655-spdif
> > 
> > i am going to try and hack together some combination of 
> realtek-alsa-1.0.4
> > and alsa-cvs and see if what i figured is right or not. it 
> would be great if
> > one of the alsa developers can look into realtek-alsa-1.0.4 
> and merge those
> > changes into alsa.
> 
> ok then the problem seems alc655 specific.
> 
> after a quick look, i haven't found relavant changes for the spdif.
> they implemented additional switches for category but these 
> should be already
> handled if you set IEC958 status bits.
> 
> how did you test your board?
> 
> 
> Takashi

what do you mean set the IEC958 status bits? who sets it? atiixp.c?

my board is a gigabyte GA-8TRS300M with ATIIXP/ALC655 and i test by running
aplay with a wav file and ac3dec with an ac3 file. with alsa-cvs using bith
aplay and ac3dec, software says it is playing but i get no sound, the
optical spdif light is not lit. with realtek-alsa-1.0.4, the software says
it is playing, still no sound but the optical spdif light is on. i am
loading the atiixp module without options, just defaults.

alex


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
