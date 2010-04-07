From: "Marcus Weigelt" <noize007@gmx.de>
Subject: User-space control elements in ext PCM plugin
Date: Wed, 07 Apr 2010 12:01:04 +0200
Message-ID: <20100407100104.41190@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id DE88810380B
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Apr 2010 12:01:07 +0200 (CEST)
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

Hi, =


I=B4m having an external PCM plugin that should do some processing on the a=
udio. That part works fine. Now I=B4d like to have some way to modify the w=
ay to give some parameters to the plugin to tell it how the processing is d=
one (eg. set delay time, pan, attack time, ...). =

I=B4ve searched the web for days and hours, but could not really find somet=
hing. =

On the alsa mailing list there was a similiar question three years ago, and=
 the answer was, that one could create user-space control elements in the p=
lugin. How is that done? I could not find examples or good documentation ab=
out it. Did I miss something out? Can anyone give me a hint, maybe a link t=
o some docs about it or source of a PCM plugin creating/using user space co=
ntrol elements? Thanks a lot.

Marcus
-- =

GRATIS f=FCr alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
