From: =?UTF-8?B?6auY5LqV5ZKM5Lmf?= <ktakai@sun-denshi.co.jp>
Subject: For playback method of stopping after the execution
	aplay command
Date: Wed, 9 Nov 2016 10:36:52 +0900
Message-ID: <CAA_zGK07Ywm_RvXHvJfS9ZrTEy2CFAB7rG_nHauB-pmgh-3ggA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 078672667E7
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2016 02:37:13 +0100 (CET)
Received: by mail-wm0-f47.google.com with SMTP id a197so279400950wmd.0
 for <alsa-devel@alsa-project.org>; Tue, 08 Nov 2016 17:37:13 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello

Use ALSA aplay command we have developed a device for audio reproduction.

After the audio playback at aplay command, forcibly or will not tell us
what should take what way to halt the play.
(After starting the aplay command, I tried a way to kill the process, but
it could have taken to stop playing, rarely Linux There was to be a
iowaitsleep state)

best regards
