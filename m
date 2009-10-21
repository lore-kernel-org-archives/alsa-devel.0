From: Colin Kincaid Williams <discord@uw.edu>
Subject: snd-hda-intel , changing the model option
Date: Wed, 21 Oct 2009 02:10:25 -0700
Message-ID: <a5bf07fe0910210210l4d55bf83se973ba7755e18723@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id D182B103827
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Oct 2009 11:10:26 +0200 (CEST)
Received: by qyk15 with SMTP id 15so4878305qyk.23
	for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2009 02:10:25 -0700 (PDT)
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

Hello,

I'm trying to get my sound working and was wondering: Is there is a way to
change the model option without restarting my computer? I tried editing the
/etc/modprobe.d/alsa-base.conf file, and then restarting alsa with
/etc/init.d/alsa-utils restart 0 , however I do not think the change is
taking place. I used the alsa-info.sh script to determine if the change took
place however it appears that the card has the same model name as when the
machine booted.

Best,

Colin Williams
