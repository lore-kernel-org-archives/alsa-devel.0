From: "Jim" <jbuckeyne@greater.net>
Subject: Re: Just a quick question...
Date: Wed, 14 Aug 2002 21:05:08 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <019e01c24410$f1d68ad0$3c01a8c0@apprentice>
References: <006c01c2429a$45e35b80$3c01a8c0@apprentice> <3D58C6EA.3030107@boosthardware.com> <00c201c2432f$c4375640$3c01a8c0@apprentice> <3D5A24A8.80402@boosthardware.com>
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

>
> Unfortunately the i810 driver is one of the undisclosed code family. I
> haven't used the nforce so I don't know about it.

I went out looking for information - being from Intel - SURELY it's
documented, and such information is publicly available.... I've found a
plethora of information - but everything about the design of the ac97 spec
indicates one register set, one set of dmas ... one could interpret one
portion... there's 256 ranges of base registers one can select - but then
you'd have a full set of mixing registers etc - just totally impracticle :/
and therefore 256*3 dma units ... which isn't all that much memory bandwidth
at 256*44.1khz*16*2 is only 45MB/sec ...  less than a hard disk... and I
don't understand the PCI interface entirely.... but then I did go back to
nVidia's page on the nForce chip






informative links regarding the ac '97 chip aka i810 audio controller...

http://www.intel.com/design/chipsets/manuals/298028.htm

slightly different information...
http://www.intel.com/design/chipsets/manuals/298238.htm

directory containing ac97 specs...
ftp://download.intel.com/labs/media/audio/download/

page detailing statuses etc (links for download are broken see prior link)
http://www.intel.com/labs/media/audio/index.htm
>


> The ones that I know work are the trident, the es1968 (maestro), the
> interwave. I think there are a few more but cannot remember. It is a
> question for the LAU FAQ though so I'll try to find out some more.
>
> --
> Patrick Shirkey - Boost Hardware Ltd.
> For the discerning hardware connoisseur
> Http://www.boosthardware.com
> Http://www.boosthardware.com/LAU/guide/
> ========================================
>



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
