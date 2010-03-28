From: Oliver Lupton <oliverlupton@gmail.com>
Subject: [PATCH 5/5] Echoaudio - add suspend/resume support
Date: Sun, 28 Mar 2010 11:44:19 +0100
Message-ID: <4BAF3303.9040201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C05DC1037FC
	for <alsa-devel@alsa-project.org>;
	Sun, 28 Mar 2010 12:44:23 +0200 (CEST)
Received: by wyi11 with SMTP id 11so533144wyi.38
	for <alsa-devel@alsa-project.org>; Sun, 28 Mar 2010 03:44:22 -0700 (PDT)
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

Just thought I'd mention that I've tested these five patches applied to 
a fedora 12 2.6.32.9 kernel with an Indigo IO card and it appears to now 
work fine when resuming from standby (which it didn't previously -- I 
had to remove/reinsert the card and close all applications with the 
device open)

Cheers,
Olli
