From: Ludovico Cavedon <ludovico.cavedon@gmail.com>
Subject: 0 or EAGAIN from snd_pcm_update_avail()?
Date: Thu, 2 Apr 2009 23:20:34 -0700
Message-ID: <7337540c0904022320s2b40bf79r2ad00bd80569ffba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.248])
	by alsa0.perex.cz (Postfix) with ESMTP id CEBB41037E3
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Apr 2009 08:20:35 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id c5so828902rvf.32
	for <alsa-devel@alsa-project.org>; Thu, 02 Apr 2009 23:20:34 -0700 (PDT)
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

Hi all,

if snd_pcm_update_avail() gets called on a PCM device in non-blocking
mode when no data is availabe jet, what is the expected return value?
-0
-EAGAIN
-either is valid

I am asking this question because pulseaudio expect to receive 0, but
the the bluetooth headset pcm transfer callback returns EAGAIN, so I
want to find out against whoms I should open a bug :)

Thanks in advance,
Ludovico
