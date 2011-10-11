From: Vidblain Amaro <vidblain@gmail.com>
Subject: How to use "hw" or "plughw"?
Date: Tue, 11 Oct 2011 09:48:48 -0700
Message-ID: <CAB+hiFQ_i+b+Brp0_829d5G0cGxCyp028tt03Rgq2gfXVxfG9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 26B1D10391F
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Oct 2011 18:48:52 +0200 (CEST)
Received: by vws20 with SMTP id 20so60926vws.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2011 09:48:49 -0700 (PDT)
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

Hi everbody

I have a beginner in this area, i have to develop an audio application to
implement filter algorithms to reduce the noisy of an audio
I have readed the alsa api, and i decided to partition into 3 threads mi
application, one for read samples from an audio file, the second for
filter de samples, and the third for  playback the audio filtered using
snd_pcm_writei,
but i am confused about the use "hw" and "plughw" when open de audio device.

Some suggestion

-- =

Vidblain
"Lo verdadero es demasiado sencillo, pero siempre se llega a ello por lo m=
=E1s
complicado."
