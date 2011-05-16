From: Felix Homann <linuxaudio@showlabor.de>
Subject: =?windows-1252?q?error=3A_implicit_declaration_of_fu?=
 =?windows-1252?q?nction_=91fw=5Fiso=5Fresource=5Fmanage=92?=
Date: Mon, 16 May 2011 15:00:13 +0200
Message-ID: <4DD11FDD.2050504@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 07A9F103834
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 15:00:19 +0200 (CEST)
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

I've just tried building Alsa from git (alsa-driver/alsa-kernel). It =

won't build resulting in this error message:

~/workspace/Alsa/alsa-driver/firewire/../alsa-kernel/firewire/iso-resources=
.c: =

In function =91fw_iso_resources_allocate=92:
~/workspace/Alsa/alsa-driver/firewire/../alsa-kernel/firewire/iso-resources=
.c:135:2: =

error: implicit declaration of function =91fw_iso_resource_manage=92

Are there any patches waiting to resolve this issue?

Regards,

Felix
