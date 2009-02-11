From: constantine <geminisbro@gmail.com>
Subject: Please Help
Date: Wed, 11 Feb 2009 09:59:07 -0500
Message-ID: <4992E7BB.6020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B81A010380F
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 15:59:15 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c5so131869anc.2
	for <alsa-devel@alsa-project.org>; Wed, 11 Feb 2009 06:59:14 -0800 (PST)
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

I'm having trouble with youtube in Ubuntu 8.10

I've tried this guide: 
https://help.ubuntu.com/community/SoundTroubleshooting
to no success and submitted a bug report as suggested. 

I then entered #alsa and here's the result of that chat: (I am Constantine)

<constantine_> hi, I'm having problems with youtube sound and already 
troubleshot it
<constantine_> I am trying to manually start the driver at this point 
but can't get sudo modprobe snd
<constantine_>  to work with the file name I put after it
<constantine_> all other audio worked fine before the switch to alsa and 
still does, except youtube

<gnubien> constantine_ run this command: cat /proc/asound/cards  #and 
then paste output to this channel; its OK to paste up to 10 lines here
<constantine_>  0 [Intel          ]: HDA-Intel - HDA Intel
<constantine_>                       HDA Intel at 0xfea38000 irq 16
<gnubien> constantine_ close all sound apps and firefox and then ONLY 
report you have: sound, no sound or errors after you run this command: 
speaker-test -c2 -D hw:0,0 -t wav -l1
<constantine_> sound

<gnubien> constantine_: ok, only problem is no sound when playing flash 
in firefox?
<constantine_> only 'certain' flash, ie youtube
<gnubien> constantine_: ok, alsa is setup and working ok so flash is the 
problem so time to do some searching...


Thanks,
Constantine
