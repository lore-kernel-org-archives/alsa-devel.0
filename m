From: plessas@mur.at (Peter Plessas)
Subject: via82xx DC offset at -30dB
Date: Mon, 29 Oct 2007 01:44:34 +0100
Message-ID: <20071029004434.GD32311@mur.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fox.mur.at (fox.mur.at [89.106.208.7])
	by alsa0.perex.cz (Postfix) with ESMTP id E6CA7249D4
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 01:44:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by fox.mur.at (Postfix) with ESMTP id A6FC74BDBD
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 01:44:37 +0100 (CET)
Received: from fox.mur.at ([127.0.0.1])
	by localhost (fox.mur.at [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 29814-02-3 for <alsa-devel@alsa-project.org>;
	Mon, 29 Oct 2007 01:44:35 +0100 (CET)
Received: from hornet.mur.at (hornet.mur.at [89.106.208.12])
	by fox.mur.at (Postfix) with ESMTP id 247EA4B98A
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 01:44:35 +0100 (CET)
Content-Disposition: inline
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

Dear List,

having a Compaq Presario notebook in front of me, running Debian testing
and a 2.6.18-4-686 kernel, i have a strange DC offset when trying to
record audio via the mic/line input. As the audacity level meters
suggest, it resides at -30dBFS.
Audio comes through and gets recorded though, but the offset severely
limits the headroom of course.
The sensitivity of the line/mic input seems to be quite high, although i
have the mic boost setting turned off of course.
Setting the module option ac97_quirk=yes did not help either.
Can it be that a soundcard of this strange behavior is manufactured, or
is it an alsa/driver issue? I really don't want to install another M$
operating system to check if it works there, so any help is deeply
appreciated.

lspci lists the device as:
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
AC97 Audio Controller (rev 20)

regards, PP

PS: please CC: me, as i am not subscribed to alsa-devel (yet)
