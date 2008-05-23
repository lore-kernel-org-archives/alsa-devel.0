From: Juergen Beisert <jbe@pengutronix.de>
Subject: Question about "control names"
Date: Fri, 23 May 2008 10:28:21 +0200
Message-ID: <200805231028.22282.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by alsa0.perex.cz (Postfix) with ESMTP id 0C96D2460D
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 10:28:27 +0200 (CEST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1JzSdS-0002j7-W3
	for alsa-devel@alsa-project.org; Fri, 23 May 2008 10:28:26 +0200
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

I'm playing with the control names of my "snd_kcontrol_new" controls. When =
I'm =

using "PCM Playback Switch" and "PCM Playback Volume" alsamixer shows me a =

slider with a switch at its bottom. That's what I expected.
But when I'm using a second set ("line in" to "line out" bypass), with "Lin=
e =

Bypass Capture Switch" and "Line Bypass Capture Volume" control names, its =

confusing (BTW: "Line Bypass Capture Volume" is of type =

SNDRV_CTL_ELEM_TYPE_ENUMERATED).

The "Line Bypass Capture Volume" control is shown on the [Playback] page wi=
th =

the name "Line Byp" and the default value. I can walk through the enumerate=
d =

values. But the "Line Bypass Capture Switch" is shown on the [Capture] page =

in alsamixer as:

  L    R
  CAPTUR

<Line Byp>

What does it mean? Problem of alsamixer or the name of this set?

Juergen
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
