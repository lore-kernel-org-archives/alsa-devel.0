From: Gregory T Flynn <gflynn1@binghamton.edu>
Subject: Soundcard Detection problem (ALSA regression)
Date: Mon, 29 Mar 2010 13:57:40 -0400
Message-ID: <b98465221003291057p2d7201c6q8c86a6c9a1a1bf17@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 91B5624524
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Mar 2010 19:57:41 +0200 (CEST)
Received: by fxm20 with SMTP id 20so17860538fxm.32
	for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2010 10:57:41 -0700 (PDT)
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

So far I have tested the current stable drive and now the current
snapshot, both to no avail.=A0 The last ALSA driver version that worked
on this sound card was 1.0.18.

General Info from the 1.0.18 driver:

!!PCI Soundcards installed in the system
!!--------------------------------------
00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a=
2)


!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------
00:10.1 0403: 10de:026c (rev a2)
=A0=A0=A0 Subsystem: 1462:373d

Currently I'm running Ubuntu 10.04 beta1 and this sounds regression
(which was also in 9.10) is my only problem with the new system.=A0 So
it would be awesome to get solved and packed into the beta before
release.

more details in bug report:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D4967
--
- Greg Flynn
