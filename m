From: Daniel Koukola <koukola@upcmail.cz>
Subject: ctxfi mixer initialization bug
Date: Fri, 16 Apr 2010 18:55:45 +0200
Message-ID: <4BC89691.8090705@upcmail.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from r3aa142.net.upc.cz (r3aa142.net.upc.cz [213.220.218.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FB6F244CF
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Apr 2010 18:55:48 +0200 (CEST)
Received: from [192.168.0.7] (menegroth.twilight [192.168.0.7])
	by r3aa142.net.upc.cz (8.13.8/8.13.8) with ESMTP id o3GGtj2k024318
	for <alsa-devel@alsa-project.org>; Fri, 16 Apr 2010 18:55:46 +0200
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

There seems to be some problem with the mixer initialization in the =

ctxfi driver. After the module is loaded, the analog capture doesn't =

work even though the =93Digit-IO=94 mixer switch is set to off. You have to =

set it to on and then to off again to make the capture work.

This was tested with a Sound Blaster X-Fi XtremeMusic card and the =

driver that comes with Fedora's 2.6.32.10-90.fc12.x86_64 kernel =

(reported version: 1.0.21).

Dan
