From: Nigel Henry <cave.dnb2m97pp@aliceadsl.fr>
Subject: alsa-info.sh output with ISA cards (cs4236)
Date: Thu, 14 Feb 2008 17:31:48 +0100
Message-ID: <200802141731.48883.cave.dnb2m97pp@aliceadsl.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.libertysurf.net (mx-out.libertysurf.net [213.36.80.91])
	by alsa0.perex.cz (Postfix) with ESMTP id BFAC4245BD
	for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2008 17:31:52 +0100 (CET)
Received: from [192.168.0.230] (213.36.0.151) by mail.libertysurf.net
	(7.3.118.8) id 479F72DE0051B668 for alsa-devel@alsa-project.org;
	Thu, 14 Feb 2008 18:36:05 +0100
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

I've been trying to help someone out on the Fedora list, who has had problems 
with snd-cs4236 since FC6, where he had to add "modprobe snd-cs4236" 
to /etc/rc.local to get the module to load. With Fedora 8 the problem got 
worse, and sound would only work as root. Using a tip from someone else on 
the list, added lines for sound, and cdrom 
in /etc/security/console.perms.d/50-default.perms, and the sound now works as 
user.

I asked him to run alsa-info.sh, having got the sound working, but there is 
very limited output, as below.

http://pastebin.ca/903074

The question is, should the script work as well with ISA cards, as it does 
with PCI ones?

Nigel.
