From: "Jose Henrique Spahn Torres" <jose.torres@eldorado.org.br>
Subject: Re: Easiest way to test playback on an ASOC driver?
Date: Wed, 4 Jul 2007 09:55:15 -0300
Message-ID: <AC2729D6E3A3314A922E4E0FBE513F65E4760F@MAIL.eldorado.org.br>
References: <468AD6B3.2090905@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.eldorado.org.br (mail.eldorado.org.br [200.168.210.67])
	by alsa0.perex.cz (Postfix) with SMTP id 0D0692449D
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 14:55:18 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <468AD6B3.2090905@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

-----Original Message-----
From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-p=
roject.org] On Behalf Of Timur Tabi
Sent: ter=E7a-feira, 3 de Julho de 2007 20:08
To: alsa-devel@alsa-project.org
Subject: [alsa-devel] Easiest way to test playback on an ASOC driver?

I'm in the early stages of testing an ASOC driver, i.e. I'm trying to get p=
layback to work.

What is the easiest way to test playback?  Is there a particular tool I sho=
uld be using that does the most basic and direct playback of audio data thr=
ough ALSA?

--
Timur Tabi
Linux Kernel Developer @ Freescale
_______________________________________________


I am also working on an ASOC system (smdk2410).
After you compiled alsa-driver and alsa-lib, you can compile alsa-utils
which will give you aplay, arecord and speaker-test app.
You can test your system with these app.

Bye,
Henrique
