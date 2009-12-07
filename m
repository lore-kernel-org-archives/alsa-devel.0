From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [Updated]iMac_91_sound_patch.
Date: Mon,  7 Dec 2009 15:07:45 -0800
Message-ID: <1260227266-6206-1-git-send-email-justinmattock@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f196.google.com (mail-yx0-f196.google.com
	[209.85.210.196])
	by alsa0.perex.cz (Postfix) with ESMTP id 3940324469
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 00:07:46 +0100 (CET)
Received: by yxe34 with SMTP id 34so4515014yxe.16
	for <alsa-devel@alsa-project.org>; Mon, 07 Dec 2009 15:07:44 -0800 (PST)
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
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org



This is an updated patch for the Apple iMac 9,1 model to add sound.
Original patch posted here:
http://article.gmane.org/gmane.linux.alsa.devel/61361/match=

I have been using this patch for a while now
and have to say it works vary well, except for a few minor 
things:

	With the iMac 24-inch 3.06GHz Intel Core 2 Duo
	everything seems to be working as it should,
        although I have not looked into the microphone
	(never really use one, nor have any apps to test,
	my guess is it doesn't work, or I never figured out how
	to get it to work).

	With the iMac 24-inch 2.66GHz Intel Core 2 Duo
	everything is the same as with the above machine 
	except I'm hearing a light scratchy/distortion noise
	come out of the speakers when using headphones(above machine
	does not do this).

Other than that the sound level is great(especially with good Dj headphones).

Now onto this patch. I took the liberty of sighning off on it
although I don't feel comfortable doing so, since this is not my
work(except for a few changes to fit the latest kernel).
In reading:
http://article.gmane.org/gmane.linux.alsa.devel/61596/match=
there was mention of a sign off, but something happened. 

Anyways I'll leave it up to the people in charge of patches
to make the descision on what to do with this. 


 Documentation/sound/alsa/HD-Audio-Models.txt |    1 +
 sound/pci/hda/patch_realtek.c                |  111 ++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 0 deletions(-)
