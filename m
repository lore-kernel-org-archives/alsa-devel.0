From: "Woller, Thomas" <tom.woller@cirrus.com>
Subject: RE: Linux driver for cs4281 with TWO cs4299 codecs?
Date: Wed, 22 May 2002 13:27:43 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <973C11FE0E3ED41183B200508BC7774C022FBD50@csexchange.crystal.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: 'Takashi Iwai' <tiwai@suse.de>, tomasz motylewski <T.Motylewski@bfad.de>
Cc: "Woller, Thomas" <tom.woller@cirrus.com>, Austin PC Audio Support <pcaudio@crystal.cirrus.com>, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>
List-Id: alsa-devel@alsa-project.org

I do not have a dual codec cs4281 driver. i do not believe that
any of our customers ever created such a design either, so not
100% sure that the h/w will all work as spec'ed, but I have no
idea... might though. officially cirrus did not support >1 codec
with the cs4281.  i do know that the linux driver will support
multiple cs4281/single codec systems, up to 4 i believe was
tested external to cirrus. 
tom woller

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de]
Sent: Wednesday, May 22, 2002 1:12 PM
To: tomasz motylewski
Cc: twoller@crystal.cirrus.com; pcaudio@crystal.cirrus.com;
alsa-devel@lists.sourceforge.net; peter wachtendorf
Subject: Re: [Alsa-devel] Linux driver for cs4281 with TWO cs4299
codecs?


Hi,

At Wed, 22 May 2002 17:59:55 +0200 (CEST),
tomasz motylewski wrote:
> 
> 
> I hope you do not mind that I have contacted you directly.
> 
> I would like to ask whether anyone has developed a driver for
cs4281 working in
> a dual codec sound card.
> 
> We have developed such a card, and it works fine with a single
cs4299 codec,
> but current alsa-driver-0.9.0rc1 fails with:
> 
> ALSA ../alsa-kernel/pci/cs4281.c:1455: DLLRDY not seen
> CS4281 soundcard not found or device busy
> 
> when we connect another codec configured as slave (no quartz
signal on
> secondary, but SYNC, BIT_CLK, SDATA_OUT, SDATA_IN, RESET
connected).
> 
> I have tried to increase the timeout to 1 s, but without any
result.
> 
> Any advice?
 
ALSA driver still doesn't support secondary codec, so most likely
it's
a driver problem.

according to the cirrus' doc, ASDI2E and TCID must be set for the
secondary codec before the loop checking DLLRDY.

ok, now i did a very very quick hack.  could you try the attached
patch?  (you'll need to pass the module option snd_dual_codec=1)
it doesn't change the TCID value (it was set to 1).  it might be
different value.  tune as you like.


Takashi

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
