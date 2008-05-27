From: Juergen Beisert <jbe@pengutronix.de>
Subject: Digital Audio Multiplexer of the i.MX27 processor
Date: Tue, 27 May 2008 17:13:49 +0200
Message-ID: <200805271713.49868.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id 9D4D524415
	for <alsa-devel@alsa-project.org>;
	Tue, 27 May 2008 17:13:55 +0200 (CEST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1K10s3-0004Fh-8d
	for alsa-devel@alsa-project.org; Tue, 27 May 2008 17:13:55 +0200
Content-Disposition: inline
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

Hi,

does anybody understand the DAM unit in the i.MX27 processor?
This routing device drivers me crazy, as I do not understand how to route =

clocks, syncs and the data signals of my internal i2s unit to the processor=
's =

pins.
All I can see is, when I enable the internal SSI unit in i2s mode, the DMA =

unit transfers some data into it, but the SSI unit does not shift it out. S=
o =

everything stops, the DMA timeouts and I cannot hear anything. I can see th=
e =

external device generates clock and frame signals, but it seems they do not =

reach the internal SSI unit.
Has anybody a working DAM configuration which uses the internal SSI#1 as an =

i2s slave, an external i2s device connected to the SSI#1 pin group of this =

processor which acts as a master (I did not find anything in the manual, ho=
w =

the relation between the internal so called port-1 to port-6 at the DAM uni=
t =

and the 4 external SSI1...SSI4 pin groups are). Means the external i2s devi=
ce =

generates the clock and frame signal and the internal SSI#1 unit in i2s mod=
e =

should use it to send serial sound data to the external device.

Juergen
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
