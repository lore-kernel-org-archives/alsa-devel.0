From: Micah Bucy <micah.bucy@gmail.com>
Subject: iMac 9,1 patch work
Date: Tue, 21 Apr 2009 10:40:49 -0400
Message-ID: <C6135331.46B1%micah.bucy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.250])
	by alsa0.perex.cz (Postfix) with ESMTP id 9561F24695
	for <Alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 16:40:58 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id k29so856948rvb.32
	for <Alsa-devel@alsa-project.org>; Tue, 21 Apr 2009 07:40:57 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Alsa-devel@alsa-project.org" <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I=B9m working on a patch for the iMac 9,1 and have the output working.  Inp=
ut
is giving me problems.  The particular setup is using patch_realtek.c from
hda.  I noticed that the built-in microphone works if it uses alc883 with
model=3Dauto specified.  I=B9m just not sure what the relevant code is that
alc883_auto is using for capture.  Any pointers would be helpful.

-Micah
