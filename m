From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH] miroSOUND PCM12 driver
Date: Thu, 17 Mar 2005 00:48:18 +0100
Message-ID: <20050316234818.GA2777@tuba>
References: <20050313103317.GA2280@tuba> <Pine.HPX.4.33n.0503161138550.28424-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qDbXVdCdHGoSgWSk"
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 3B150234
	for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2005 00:45:16 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0503161138550.28424-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 16, 2005 at 11:51:46AM +0100, Clemens Ladisch wrote:
> Martin Langer wrote:
> > The tenth birthday of this card is coming soon and now it's time to get
> > an ALSA driver for the miroSOUND PCM12 :)

The new miro driver patch version 0.6 is attached.

> 
> > +++ alsa-driver/isa/opti9xx/Makefile	Fri Mar 11 18:51:05 2005
> > +obj-$(CONFIG_SND_MIRO) += snd-miro.o snd-opti92x-cs4231.o
> 
> Is there any reason for the dependency on the snd-opti92x-cs4231
> driver?

No, it's rubbish. I've removed it.

> > MODULE_SUPPORTED_DEVICE("{{miroSOUND,PCM1 pro}, "
> > 			"{miroSOUND,PCM12}, "
> > 			"{miroSOUND,PCM20 Radio}}");
> 
> The first entry in each pair should be the vendor name.

fixed.

> > static int wss;                                 /* unknown range */
> > static int ide;                                 /* unknown range */
> 
> "unknown"? :-)

"wss" is only for PCM1 which I can't test with my PCM12.

"ide" isn't documented and I haven't tried ide out - it's postponed to 
later.

But perhaps 0 and 1 are the unknown values. Hmmm, there is still a 
smell of uncertainty in the air...

> > int snd_miro_mixer(miro_t * miro)
> > ...
> > 	switch (miro->hardware) {
> >         case OPTi9XX_HW_82C924:
> > 		strcpy(card->mixername, "ACI & OPTi924");
> >         case OPTi9XX_HW_82C929:
> > 		strcpy(card->mixername, "ACI & OPTi929");
> > 	default:
> > 		strcpy(card->mixername, "ACI & OPTi9xx");
> > 	}
> 
> The default case cannot happen (bwahaha!), so it might make sense to
> put a snd_BUG() in there.

good point. fixed.

> > - OPL4 support is still missing, because I'm still waiting for response
> > of my broken OPL4 chip. :(
> 
> Is it broken with the snd-opti92x-cs4231 driver, too?

Yep, it's even broken with Win2000. 

> > - I never saw any docs about the cards. All knowledge is taken from ACI
> > driver (OSS) and OPTi9xx (ALSA) drivers.
> 
> There are OPTi manuals on the ALSA FTP server.

I wasn't precise here. I was looking for ACI or Miro specific documents. 
E.g. the OSS driver has no real equalizer implementation. I hope it's 
handled correct now, because it's still untested PCM20 stuff.
OTOH, I haven't had a hole of knowledge in the OPTi part. There was no 
reason for looking into the OPTi specifications, the ALSA opti driver 
had all things inside (at least for me).

BTW, I just asked google and I've found two other intersting documents 
for addition to the ALSA ftp area:

Opti929:
http://ftp.cis.nctu.edu.tw/data/Multimedia/SoundCard/OPTi/82c929/db013_10.pdf

OPL4:
http://ftp.funet.fi/pub/msx/docs/datasheets/opl4.pdf


bye,
martin

--qDbXVdCdHGoSgWSk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="miro-0.6.patch.bz2"
Content-Transfer-Encoding: base64

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
cA==

--qDbXVdCdHGoSgWSk--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
