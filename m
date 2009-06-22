From: Eran Ben-Avi <eranpublic@yahoo.com>
Subject: Noisy USB audio stream using MPlayer
Date: Mon, 22 Jun 2009 01:17:25 -0700 (PDT)
Message-ID: <786354.70664.qm@web62506.mail.re1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web62506.mail.re1.yahoo.com (web62506.mail.re1.yahoo.com
	[69.147.75.98]) by alsa0.perex.cz (Postfix) with SMTP id BA1F624372
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Jun 2009 10:17:26 +0200 (CEST)
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

I encountered some issue with my USB audio device and couldn't find any sim=
ilar issue in previous mailing lists, any help will be appreciated.
When playing an audio stream using MPlayer Ver1.0rc2-4.1.2=A0(tried differe=
nt sample rates=A044K, 48K and different files WAV , MP3)=A0using my Creati=
ve SB0271 USB device on ARM based system(Marvell Kirkwood SoC) and kernel 2=
.6.22.18, I hear an=A0interfering constant noise additionally to the origin=
al audio stream.
At the beginning I heard this noise also when I used aplay(for WAV) but aft=
er I reinstalled the ALSA-LIB and ALSA-UTILS(version 1.0.14rc4), the aplay =
suddenly started to work smooth.
I tested different USB audio device(AKM) but got same noisy results.
Another piece of information I can provide is that increasing the CPU utili=
zation eliminates the noise completely - maybe a timing issue ???

Any ideas ?

Thanks,
Eran.



      =
