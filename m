From: "Jim" <jbuckeyne@greater.net>
Subject: Re: Just a quick question...Damn - last msg w/ continue
Date: Wed, 14 Aug 2002 21:13:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <01a401c24412$20cc1160$3c01a8c0@apprentice>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> > Unfortunately the i810 driver is one of the undisclosed code family. I
> > haven't used the nforce so I don't know about it.

I went out looking for information - being from Intel - SURELY it's
documented, and such information is publicly available.... I've found a
plethora of information - but everything about the design of the ac97 spec
indicates one register set, one set of dmas ... one could interpret one
portion... there's 256 ranges of base registers one can select - but then
you'd have a full set of mixing registers etc - just totally impracticle :/
and therefore 256*3 dma units ... which isn't all that much memory andwidth
at 256*44.1khz*16*2 is only 45MB/sec ...  less than a hard disk... and I
don't understand the PCI interface entirely.... but then I did go back to
nVidia's page on the nForce chip
   http://www.nvidia.com/docs/lo/557/SUPP/nForce_MCP_Overview.pdf
and amidst all of that it says - DirectX blahblah 256 channels audio blah 64
3d ... and I think however that these are accomplished in software, and that
the hardware spec has nothing to do with this... and this minor 'marketing
hype' has been trimmed to be
  'motherboard - audio- ac97 with 256 channels.'
  though appropritely marketed as
  ' motherboard - audio - Direct Sound AC97 Audio'

went out for a general search at the conclusion of my wanderings and find
that the maestro indeed has 64 register sets - which when a audio interrupt
is received would greatly increase the time to figure out uhh which
(virtual) card has the completion event...

excerpt from maestro.c changelog
 Then we have beasts
90      *	like the APU interface that is indirect registers gotten at
through
91      *	the main maestro indirection.  Ouch.  We spinlock around the
actual
92      *	ports on a per card basis.  This means spinlock activity at each
IO
93      *	operation, but the only IO operation clusters are


Okay - so I'm over it.  now - wonder if I should use JACK or ESD?


>
> informative links regarding the ac '97 chip aka i810 audio controller...
>
> http://www.intel.com/design/chipsets/manuals/298028.htm
>
> slightly different information...
> http://www.intel.com/design/chipsets/manuals/298238.htm
>
> directory containing ac97 specs...
> ftp://download.intel.com/labs/media/audio/download/
>
> page detailing statuses etc (links for download are broken see prior link)
> http://www.intel.com/labs/media/audio/index.htm
> >
>
>
> > The ones that I know work are the trident, the es1968 (maestro), the
> > interwave. I think there are a few more but cannot remember. It is a
> > question for the LAU FAQ though so I'll try to find out some more.
> >
> > --
> > Patrick Shirkey - Boost Hardware Ltd.
> > For the discerning hardware connoisseur
> > Http://www.boosthardware.com
> > Http://www.boosthardware.com/LAU/guide/
> > ========================================
> >
>



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
