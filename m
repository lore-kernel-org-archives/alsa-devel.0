From: Matteo Canella <matteo.canella@mta.it>
Subject: handle an external PWM amplifier via alsa interface
Date: Tue, 27 Jan 2009 11:15:48 +0100
Message-ID: <39618.2692064487$1233051450@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dig-mailtc.digitek.int (mail-dgt.mta.it [93.63.228.226])
	by alsa0.perex.cz (Postfix) with ESMTP id E892F1037EA
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 11:15:48 +0100 (CET)
Content-Language: it
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
I'm a newbie in ALSA development.
I'm trying to implement an alsa interface for the audio section of my board.
I have an mpc5200 that control via i2s a pcm1774 stereo DAC and I also have
an amplifier between the DAC and the speakers.
At the moment I have the pcm1774 driver properly working, but I have a few
ideas on how to integrate the control of the external amplifier in the alsa
structure. I need to set the amplifier level with a PWM input to it.

Now I'm trying to use "non dapm" controls, adding the PWM settings into this
structure...

What do you guys think about this?
Am I completely wrong or could this be a good way?

Thanks a lot


=A0 Ing. Matteo Canella
=A0 Firmware Engineer
=A0 Digitek - MTA SpA
=A0 Via L. Romagnoli, 24
=A0 41033 Concordia s.S. (MO) - Italy
=A0 T. +39 0535 57732
=A0 F. +39 0535 54550
=A0 email: matteo.canella@mta.it
