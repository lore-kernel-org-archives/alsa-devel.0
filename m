From: Tomas Pospisek's Mailing Lists <tpo2@sourcepole.ch>
Subject: No state is present for card CMI8738
Date: Wed, 16 May 2007 00:28:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705160024160.13010@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from viefep25-int.chello.at (viefep13-int.chello.at [213.46.255.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E5DF248A7
	for <alsa-devel@alsa-project.org>;
	Wed, 16 May 2007 00:27:56 +0200 (CEST)
Received: from localhost ([193.247.120.15]) by viefep25-int.chello.at
	(InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
	id <20070515222755.HDXK5420.viefep25-int.chello.at@localhost>
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2007 00:27:55 +0200
Received: from tpo2 (helo=localhost)
	by localhost with local-esmtp (Exim 3.36 #1 (Debian))
	id 1Ho5Uw-0003OV-00
	for <alsa-devel@alsa-project.org>; Wed, 16 May 2007 00:28:02 +0200
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

Since alsa-user is rather ... errr ... silent, I dare to repost the same 
question here.

I've seen that Alsa likes the Terratec cards, however since they're also 
based on the CMI chipset, and at least /my/ onboard CMI chipset here sucks 
badly I wonder what low cost card I can use?

I hope somebody can give me a clue,
*t

PS: Mic input is barely loud enough with my onboard sound. Mic boost has
     no effect.

--
-----------------------------------------------------------
   Tomas Pospisek
   http://sourcepole.com -  Linux & Open Source Solutions
-----------------------------------------------------------

---------- Forwarded message ----------
Date: Mon, 14 May 2007 14:39:36 +0200 (CEST)
From: Tomas Pospisek's Mailing Lists <tpo2@sourcepole.ch>
To: alsa-user@lists.sourceforge.net
Subject: [Alsa-user] No state is present for card CMI8738

The following is my problem:

$ alsactl -f .alsavoip restore
No state is present for card CMI8738

I see this "sometimes". Sometimes the above works and sometimes it returns
with that error message.

It needs to be noted that I am suspending to ram. Nevertheless, the
behaveour is not consistent in between "s2ram"s and I don't know whether
that has anything to do with it either.

It also needs to be noted that alsamixer *never* has any problems
accessing the card. But even after changing the card settings with
alsamixer, alsactl will keep on repeating that error message.

* $ lspci
    00:0d.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)

* alsa userspace is at 1.0.13
* kernel is Debian's 2.6.18-4-686

Further, minor problems:

* After waking up from suspend the card looses its microphone   settings -
    that is - "Mic Capture" is allway reset to zero.

* Further on the choice to hide the microphone setting "Mic Capture" in
    alsamixer behind F5 irritates me a bit - there are *a lot* of very
    obscure settings (such as "IEC958 5V" - huh?), that are displayed by
    default.

What's up with that error above? What does it mean? Is there any
way I can fix or circumvent it? Anybody a hint?
*t

--
-----------------------------------------------------------
    Tomas Pospisek
    http://sourcepole.com -  Linux & Open Source Solutions
-----------------------------------------------------------

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user
