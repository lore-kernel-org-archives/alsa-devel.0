From: "Sebastian H." <vand2@gmx.de>
Subject: snd_mixer handle in two threads
Date: Wed, 09 Jun 2010 15:05:33 +0200
Message-ID: <4C0F919D.1040603@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id E57F0103927
	for <alsa-devel@alsa-project.org>;
	Wed,  9 Jun 2010 15:05:16 +0200 (CEST)
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

Hello again

This is still about the alsamixer-qt4 application I working on.

This time I wonder if a snd_mixer_t handle created with
snd_mixer_open ( ... ) can be used in two threads concurrently.

One thread should be the main Qt4 GUI thread and the second thread
should only poll ( ... ) blocking for ALSA events on the shared
snd_mixer_t handle in accompany with

  snd_mixer_poll_descriptors_count ( ... )
  snd_mixer_poll_descriptors ( ... )
  snd_mixer_poll_descriptors_revents ( ... )

The second thread then will post Qt4 signals to the main thread
on occassion.

Does this sound feasible?

This approach seems neccessary as I want to avoid timed polls and any
integration of linux poll() in the Qt4 mail loop seems to boil down to
timed polls.


Regards,
Sebastian H.
