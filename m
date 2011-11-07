From: b0h3m4 <b0h3m4@gmail.com>
Subject: ALSA Snapshot alsa-utils-1.0.24.2.25.g9fa7c No user
 enum control support in alsa-lib
Date: Mon, 07 Nov 2011 21:46:01 +0100
Message-ID: <4EB84389.9050407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 75E0724520
	for <alsa-devel@alsa-project.org>; Mon,  7 Nov 2011 21:46:03 +0100 (CET)
Received: by faaa20 with SMTP id a20so1031646faa.38
	for <alsa-devel@alsa-project.org>; Mon, 07 Nov 2011 12:46:03 -0800 (PST)
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

Hi there

I'm trying to compile snapshot of ALSA packages on Oneiric x86 for via8235

 >alsa-driver-1.0.24.72.g7c48f.1314.geb1d0.tar.bz2
 >alsa-lib-1.0.24.1.46.g15c6f.tar.bz2
 >alsa-utils-1.0.24.2.25.g9fa7c.tar.bz2

First two packages go without a hitch
on alsa-utils I'm stuck at
 >checking for snd_ctl_elem_add_enumerated... no
 >configure: error: No user enum control support in alsa-lib

Anything I should be aware of?
