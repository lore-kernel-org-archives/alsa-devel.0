From: Eric Holstege <eric_holstege@yahoo.com>
Subject: explicit commandline control of speakers vs headphone
	output
Date: Wed, 25 Aug 2010 09:41:47 -0700 (PDT)
Message-ID: <858637.27362.qm@web50708.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web50708.mail.re2.yahoo.com (web50708.mail.re2.yahoo.com
	[206.190.38.106]) by alsa0.perex.cz (Postfix) with SMTP id D5B84246A1
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 18:41:48 +0200 (CEST)
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

It appears that when I have a headphone plugged in, the speakers are 
automatically disabled and the output sound is sent to the headphone.

However, I want to explicitly control (e.g. via a script or commandline 
- not a GUI) whether the sound from an (arbitrary) application is going 
to the speakers or to the headphone even when the headphone is plugged in.
(When I say "arbitrary application" that means I can't alter the code of 
the application itself).

Is this possible?

(I have heard that ALSA mutes the speakers when it detects plugged-in 
headphones. Is switching between them as simple as using e.g. amixer(1) 
to unmute the speakers and mute the headphones and vice versa, or is 
there more to it.)
