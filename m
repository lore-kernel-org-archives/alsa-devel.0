From: Konstantin Kletschke <konsti@ku-gbr.de>
Subject: Re: A: VIA Technologies Inc. VT1720/24
Date: Thu, 25 Jan 2007 13:36:21 +0100
Message-ID: <20070125123620.GA8634@synertronixx3>
References: <45AFE785.6020307@informatik.uni-oldenburg.de>
	<45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de>
	<s5hac08cvct.wl%tiwai@suse.de>
	<20070125101319.GA3340@titan.lahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20070125101319.GA3340@titan.lahn.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Well actually I am fiddling around with the same card also. Since
nobody responded here in this mailing list anymore I went into

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2384

and evolved a separate prodigy_hifi.c which is quite redundant due to
the simialirities but I have to get know to als coding and wanted to
clean up later. This here looks clean and seems to work though.

I went back here Raymond pointing me to the alsa-devel archive. This
is the first mail which arrives at my mail account so I answer now
here.

I applied your stuff onto alsa-driver-1.0.14rc2.

Am 2007-01-25 11:13 +0100 schrieb Philipp Matthias Hahn:

> Yes, see below. Three more questions:
> 1. Since the "Aureon7.1", "Prodigy7.1" and my "Prodigy7.1HiFi"; as well
> as the "Prodigy7.1LT" and the "Prodigy7.1XT" respectively seem so share
> the same EEPROM-Date, wouldn't it be better to re-use/share those
> eeprom-data instead of declaring them 3 respectively 2 times?

In my opinion Prodigy7.1HiFi eeprom_ data has to be slightly
different, I need to put 

[ICE_EEP2_SYSCONF] = 0x4b

instead of

[ICE_EEP2_SYSCONF] = 0x0b

Otherwise I got speeded up sound playback.
See note (0014172) in this thread by me.

What I am currently fiddling about is the CS8415A Chip:

ALSA /XXX/alsa-kernel/pci/ice1712/aureon.c:1921: No CS8415
chip. Skipping CS8415 controls.

In the note (0014176) I am trying to search it at the i2c address it
should appear at. Still I did not found it :-)

Regards, Konsti

-- 
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
