From: Tom Corner <tom.c.corner@gmail.com>
Subject: cmipci surround sound front-left plays on lfe
Date: Thu, 09 Sep 2010 10:10:47 +0200
Message-ID: <4C889687.4090603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id E5D2424565
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Sep 2010 10:10:49 +0200 (CEST)
Received: by bwz4 with SMTP id 4so962277bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 09 Sep 2010 01:10:49 -0700 (PDT)
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

 I've been going around and around on this.  The surround sound 5.1 is
playing fine except channel 0 (front-left) is playing on the woofer.  I
have a Terratec Aureon fun - CMI8738-MC6. I can redirect the output on 0
to right-front successfully using .asoundrc and "ttable.0.1 1".  I have
gotten desperate and have tested this card in Windows and was able to
get it working right there. I have been using the file
www_lynnemusic_com_surround_test.wma through mplayer and speaker-test to
to test the setup. I am using pulseaudio, but I reconfigured my system
without pulseaudio and get the same result.

Any help would be much appreciated.

Tom Corner
