From: Thomas Hood <jdthood@yahoo.co.uk>
Subject: 1.0.10rc2 alsa-utils build warnings under gcc 4.0.2
Date: Wed, 12 Oct 2005 15:14:44 +0200
Message-ID: <434D0C44.5000905@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailservice.tudelft.nl (mailservice.tudelft.nl [130.161.131.5])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC0F5178
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:14:38 +0200 (MEST)
Received: from localhost (localhost [127.0.0.1])
	by rav.antivirus (Postfix) with ESMTP id 80D5A80284
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:14:38 +0200 (CEST)
Received: from aglu.demon.nl (x104.decis.nl [130.161.177.104])
	by mx4.tudelft.nl (Postfix) with ESMTP id E5E5E800D0
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:14:37 +0200 (CEST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by aglu.demon.nl (Postfix) with ESMTP id 7870A3FE96
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 15:14:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

FYI alsa-utils build warnings under gcc 4.0.2

(Next time I will run with -Wno-pointer-sign.)


alsamixer.c:542: warning: pointer targets in passing argument 3 of =91snd=
_mixer_selem_get_enum_item=92 differ in signedness
alsamixer.c:805: warning: pointer targets in passing argument 3 of =91snd=
_mixer_selem_get_enum_item=92 differ in signedness
aplay.c:1335: warning: pointer targets in passing argument 1 of =91pcm_wr=
ite=92 differ in signedness
aplay.c:1358: warning: pointer targets in passing argument 1 of =91voc_pc=
m_write=92 differ in signedness
aplay.c:1378: warning: pointer targets in passing argument 1 of =91pcm_wr=
ite=92 differ in signedness
aplay.c:1875: warning: pointer targets in passing argument 1 of =91pcm_wr=
ite=92 differ in signedness
aplay.c:1904: warning: pointer targets in passing argument 1 of =91pcm_wr=
ite=92 differ in signedness
aplay.c:1929: warning: pointer targets in passing argument 1 of =91pcm_re=
ad=92 differ in signedness
aplay.c:2047: warning: pointer targets in assignment differ in signedness
aplay.c:2094: warning: pointer targets in assignment differ in signedness
aseqnet.c:378: warning: pointer targets in passing argument 3 of =91accep=
t=92 differ in signedness



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
