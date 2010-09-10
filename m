From: Tom Corner <tom.c.corner@gmail.com>
Subject: cmipci surround sound front-left plays on lfe
Date: Fri, 10 Sep 2010 08:55:28 +0200
Message-ID: <4C89D660.4020705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f45.google.com (mail-fx0-f45.google.com
	[209.85.161.45]) by alsa0.perex.cz (Postfix) with ESMTP id A257124335
	for <alsa-devel@alsa-project.org.>;
	Fri, 10 Sep 2010 08:55:29 +0200 (CEST)
Received: by fxm7 with SMTP id 7so1544036fxm.32
	for <alsa-devel@alsa-project.org.>;
	Thu, 09 Sep 2010 23:55:29 -0700 (PDT)
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

I've been going around and around on this. The surround sound 5.1 is

playing fine except channel 0 (front-left) is playing on the woofer.  
I have a Terratec Aureon fun - CMI8738-MC6. I can redirect the output on 0
to right-front successfully using .asoundrc and "ttable.0.1 1".  I have
gotten desperate and have tested this card in Windows and was able to
get it working right there. I have been using the file
www_lynnemusic_com_surround_test.wma through mplayer and speaker-test to
to test the setup. I am using pulseaudio, but I reconfigured my system
without pulseaudio and get the same result.

Any help would be much appreciated.

Tom Corner
