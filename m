From: Juergen Beisert <jbe@pengutronix.de>
Subject: Names for ALSA controls
Date: Thu, 12 Jun 2008 11:58:19 +0200
Message-ID: <200806121158.20112.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id 3F82A24996
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jun 2008 11:58:26 +0200 (CEST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1K6jZV-00030M-KW
	for alsa-devel@alsa-project.org; Thu, 12 Jun 2008 11:58:25 +0200
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

when I register these mixer controls:

Line Playback Switch
Line Playback Route
Mono Playback Switch
Mono Playback Route
Phone Playback Switch
Phone Playback Route
Headphone Playback Switch
Headphone Playback Route
PCM Playback Switch
PCM Playback Volume
Line Bypass Capture Switch
Line Bypass Capture Volume
ADC Capture Route

Running "alsamixer" fails with:

 ALSA lib simple_none.c:1218:(simple_add1) helem (MIXER,'Headphone Playback=
 Switch',0,0,0) appears twice or more

It seems there are restrictions what kind of control name I can use for each
control, but what restrictions? Are there better names for my output
amplifiers? Each of it I can enable/disable (-> Switch) and select a source
(-> Route) independently.

Regards,
Juergen

-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
