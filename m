From: Stefan Kost <ensonic@hora-obscura.de>
Subject: ICE1712 softdevices fixes
Date: Wed, 17 Jun 2009 23:57:26 +0300
Message-ID: <4A3958B6.7010205@hora-obscura.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.welho.com (smtp5.welho.com [213.243.153.39])
	by alsa0.perex.cz (Postfix) with ESMTP id E067F243A5
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 22:57:27 +0200 (CEST)
Received: from [192.168.0.61] (cs27097184.pp.htv.fi [89.27.97.184])
	by smtp5.welho.com (Postfix) with ESMTP id 9EDAA5BC036
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Jun 2009 23:57:26 +0300 (EEST)
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

hi,

> The following patches fixes the default device as they appear for =

> ICE1712-based cards. Without this cards, 'aplay -L' will show a series of
> devices like surround40 and surround71 that are not meaningful for this c=
ard,
> and a front device that would not work.
> =

> Diego E. 'Flameeyes' Petten=F2 (2): Remove definition for surround sound
> devices on ICE1712. Make the front:idx device work for ICE1712.


thanks for making those. this was exactly what I needed to get pulseaudio
working with my card again. I also agree that even though that my card (Hoo=
ntech
DSP 24) has 8/10 physical in/outs, those are essentially mono channels. The
surround mapping seem to be more harm that use to me. If a musician indeed =
wires
 6 3.5 jack outs somehow to his 5.1 amp, then its probably okay to uncomment
such mappings.

So what about making diegos patches the default?

Stefan
