From: alexander <axeldenstore@gmail.com>
Subject: sound devices USBPre2 gets 'cannot submit syncpipe for
 urb 0' error when run in usb2 mode
Date: Tue, 17 Jan 2012 18:48:36 +0200
Message-ID: <4F15A664.7070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 26FF1103A40
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:55:45 +0100 (CET)
Received: by lagp5 with SMTP id p5so57710lag.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 08:55:44 -0800 (PST)
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

I've understood that linux infact does have support for uac2 so this 
device should work in usb2 mode but currently doesn't. I've made an alsa 
bug report with more info.

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5512
