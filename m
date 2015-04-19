From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Pop noise on startup when headphones are plugged in
	(Dell XPS13 9333)
Date: Sun, 19 Apr 2015 19:26:58 +0200
Message-ID: <23057263.IjMh4t6SYF@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f48.google.com (mail-wg0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BD742651CE
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2015 19:27:00 +0200 (CEST)
Received: by wgyo15 with SMTP id o15so157398914wgy.2
 for <alsa-devel@alsa-project.org>; Sun, 19 Apr 2015 10:27:00 -0700 (PDT)
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
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Hi,

I've recently found that commit a551d91473 ("ALSA: hda - Use regmap for
command verb caches, too") is somehow causing a pop noise on startup
when headphones are plugged in, but I couldn't figure out the exact
cause. Was this observed on other systems (mine is a Dell XPS13 9333,
Realtek ALC3661)? Does anyone have any idea of what the cause might be?

Regards,
Gabriele
