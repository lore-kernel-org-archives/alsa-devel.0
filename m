From: John Rigg <aldev@sound-man.co.uk>
Subject: Re: [PATCH 1/2] Remove definition for surround sound
	devices on ICE1712.
Date: Wed, 21 Jan 2009 22:24:39 +0000
Message-ID: <20090121222439.GA3993@localhost>
References: <1232455075-27712-1-git-send-email-flameeyes@gmail.com>
	<1232455075-27712-2-git-send-email-flameeyes@gmail.com>
	<Pine.LNX.4.61.0901201339310.8466@tm8103.perex-int.cz>
	<m2ocy29lyw.fsf@gmail.com>
	<Pine.LNX.4.61.0901201434500.8466@tm8103.perex-int.cz>
	<m2iqoa9jem.fsf@gmail.com> <20090121141610.GC2839@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AF25103873
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 23:11:09 +0100 (CET)
Received: from localhost (unknown [78.32.150.178])
	by mail3.uklinux.net (Postfix) with ESMTP id 9D3881F663E
	for <alsa-devel@alsa-project.org>; Wed, 21 Jan 2009 22:11:08 +0000 (GMT)
Received: from anon by localhost with local (Exim 4.63)
	(envelope-from <john@sound-man.co.uk>) id 1LPlV1-00012y-OL
	for alsa-devel@alsa-project.org; Wed, 21 Jan 2009 22:24:39 +0000
Content-Disposition: inline
In-Reply-To: <20090121141610.GC2839@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

 On Tue, Jan 20, 2009 at 02:49:53PM +0100, Diego E. 'Flameeyes' Petten=F2 w=
rote:
 > Jaroslav Kysela <perex@perex.cz> writes:
 > =

 > > Do you have seen M-Audio Delta 1010 ? The problem is that we have hard=
ware =

 > > that can be used for surround output, but alsa-lib configuration files =

 > > cannot describe the restrictions in detail now.
 > =

 > I thought that was an ICE1724, rather than 1712; I was mistaken, sorry.
 > =

 > Still, as they are the devices are non-functional at least on my card,
 > and I'm ready to bet that the same would happen on the Delta 1010 given
 > that the number of channels is not coherent (you try to open surround71
 > as 8-channels and it'll fail because this minimal card has 10; if the
 > 1010 has the same amount of channels, it'll still fail).
 =

 The ice1712 has 12 inputs and 10 outputs, regardless of how
 many physical in/outs your card has.
 =

 Most of the ice1712 interfaces I've seen have 8 analogue in/outs
 along with S/PDIF in/out. I can't think of many stereo-only
 ice1712 cards (apart from the Audiophile 2496).
 =

 John
