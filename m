From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC 0/4] FIFO caused playback delay (latency)
	handling in soc
Date: Fri, 5 Mar 2010 09:19:00 +0800
Message-ID: <4f3252891003041719h3c492e5mbde9f1c0a5a11705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B0AB103822
	for <alsa-devel@alsa-project.org>; Fri,  5 Mar 2010 02:19:02 +0100 (CET)
Received: by pvg16 with SMTP id 16so905661pvg.38
	for <alsa-devel@alsa-project.org>; Thu, 04 Mar 2010 17:19:00 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Do soc support snd_pcm_rewind() and snd_pcm_forward ?

>>No driver demand yet, though it'd be trivially implemented if anyone
>>wanted to do it.

if size of fifo is around 1x ~ 3x fames

How accucate do those media player need to allow A/V lip sync ,
Video is about 24 ~ 30 frames per seconds  and audio is 48000Hz ?
