From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Linux driver for cs4281 with TWO cs4299 codecs?
Date: Wed, 22 May 2002 17:59:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0205221707300.12692-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: twoller@crystal.cirrus.com
Cc: pcaudio@crystal.cirrus.com, alsa-devel@lists.sourceforge.net, peter wachtendorf <pew@bfad.de>
List-Id: alsa-devel@alsa-project.org


I hope you do not mind that I have contacted you directly.

I would like to ask whether anyone has developed a driver for cs4281 working in
a dual codec sound card.

We have developed such a card, and it works fine with a single cs4299 codec,
but current alsa-driver-0.9.0rc1 fails with:

ALSA ../alsa-kernel/pci/cs4281.c:1455: DLLRDY not seen
CS4281 soundcard not found or device busy

when we connect another codec configured as slave (no quartz signal on
secondary, but SYNC, BIT_CLK, SDATA_OUT, SDATA_IN, RESET connected).

I have tried to increase the timeout to 1 s, but without any result.

Any advice?

Is the programming manual cs4281tm.pdf available at
http://www.alsa-project.org/alsa/ftp/manuals/cirrus/cs4281tm.pdf the most
recent one?

Best regards,
--
Tomasz Motylewski

BFAD GmbH & Co. KG


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
