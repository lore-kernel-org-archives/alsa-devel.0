From: Doug McLain <doug@nostar.net>
Subject: Re: [Alsa-devel] Re: Real-world reports on two Delta
 1010LTs/ice1712 synched?
Date: Mon, 16 Jan 2006 14:26:59 -0500
Message-ID: <43CBF383.3000807@nostar.net>
References: <20051224124823.GA4183@localhost.localdomain> <20051224144548.GA4306@localhost.localdomain> <20051224165610.GA4484@localhost.localdomain> <43AE9FA6.2020207@nostar.net> <20051226130327.GA4763@localhost.localdomain> <43B059A3.2050302@nostar.net> <20051227000428.GA3805@localhost.localdomain> <43B0A83F.1040907@nostar.net> <20051227130029.GB3770@localhost.localdomain> <43B1A8FA.8080408@nostar.net> <20060116175652.GM28738@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <jackit-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060116175652.GM28738@edu.joroinen.fi>
Sender: jackit-devel-admin@lists.sourceforge.net
Errors-To: jackit-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
To: =?ISO-8859-1?Q?Pasi_K=E4rkk=E4inen?= <pasik@iki.fi>
Cc: John Rigg <j@sound-man.co.uk>, alsa-devel@lists.sourceforge.net, jackit-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Good timing, I was just about to give a summary of my findings so far:

First of all, the differences in the 1010LT vs the 1010 that are most=20
relevent here, I believe, is the SPDIF i/o chips (cs8413 receiver,=20
cs8404 xmitter) used on the 1010 vs the one single transceiver (cs8427)=20
used on the 1010LT.  They also use different ADC/DAC's, but at this=20
point in the game they dont appear to be relevent to this problem, and=20
they appear to be completely functional.

Last night I got my oscope back and took a look at the wordclock output=20
signal, first in windows.  As expected, the card outputs at the=20
frequency the card is running at, wether its via internal clock, SPDIF=20
in, or word clock input.  I checked all three.  Also in windows, SPDIF=20
Out works in all 3 modes as well, as it should.

In Linux, There is no word clock output signal nor an SPDIF signal=20
unless I either input a word clock signal or an SPDIF signal, and then=20
the signal stays at the speed of the input signal, even if I switch to=20
various internal clock speeds.  Basically the input clock is just being=20
passed thru.  Also, the card will not sync to an input word clock signal=20
no way, no how.  It will sync to an spdif signal though.  This is=20
actually the only way to get spdif out to work.  On a delta 1010LT in=20
Linux, the only way to get SPDIF out, is if there is a valid SPDIF In
signal, and I am clocked off it.

Knowing this, I am currently able to run two delta 1010LT's synced via=20
spdif (spdif out of card 1 to spdif of card 2), with JACK (using john=20
rigg's asoundrc, alsa-lib, and jack patches), with an external spdif=20
signal coming into card 1's SPDIF In from a digital mixer. I did many=20
mutitrack recordings of all 16 inputs simultaneously into ardour,=20
everything worked great. This just confirms that the only thing keeping=20
the 1010LT's from playing nice together is the clock problem.  Otherwise=20
they are ready to go.  A possible option while the clock issue remains=20
at large, is to use the spdif output from your on board sound card(if so=20
equipped) as an spdif source to your first delta.  I gave this about 5=20
minutes of my time, and didnt have the best of luck.  I couldnt keep the=20
signal coming out of my via82xx alive all the time, etc.  I don't know=20
it well enough to use alsamixer, etc and I had to keep xmms running (set=20
to use the alsa driver on the via82xx directly) all the time to keep the=20
signal alive.  I wasnt too interested in getting it working well like=20
this, but it was an idea.

I've been studying the ice1712 alsa driver closely over the past few=20
weeks, and comparing all relevent ice1712 control register values in=20
windows vs linux (in windows I got ahold of this nice program called=20
PCIScope, a dream for reverse engineering pci hardware!) and I think=20
(hope) the problem is in the init and configuration of the cs8427 spdif=20
transceiver.  There are differences in bit values on the ice1712's GPIO=20
data register. So my two areas of concern are deciphering the usage of=20
the GPIO register and the cs8427 spdif transceiver. The ice1712 talks to=20
the cs8427 over I2C, which isnt as straightforward to read as regular=20
i/o registers, so it's more studying ahead.  I am focusing on fixing=20
spdif functionality, since the cs8427 datasheet is very clear about=20
spdif operation.  I am hoping by fixing regular spdif functionality on=20
the ship, word clock will be fixed too. We'll see.

Doug
--
http://nostar.net/


Pasi K=E4rkk=E4inen wrote:

>=20
> Doug,=20
>=20
> Have you found out anything?=20
>=20
> - Pasi K=E4rkk=E4inen
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log =
files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_idv37&alloc_id=16865&op=3Dclick
> _______________________________________________
> Jackit-devel mailing list
> Jackit-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/jackit-devel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
