From: "Daniel Persch" <d.persch@qgroup.de>
Subject: VIA82XX on MSI K78MM Front Channel Problem
Date: Sat, 18 Aug 2007 15:33:27 +0200
Message-ID: <0B9BC0F04D815444AB5AF4450646E01484AF7E@qgroup-s1.qgroup.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qtrust.qgroup.de (mail.qgroup.de [212.96.128.66])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D2E0245EC
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Aug 2007 15:33:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.qgroup.de (Postfix) with ESMTP id 660472A2BE6
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Aug 2007 15:33:28 +0200 (CEST)
Received: from qtrust.qgroup.de ([127.0.0.1])
	by localhost (qtrust [127.0.0.1]) (amavisd-new, port 27304) with ESMTP
	id 20717-11 for <alsa-devel@alsa-project.org>;
	Sat, 18 Aug 2007 15:33:28 +0200 (CEST)
Received: from qgroup-s1.qgroup.de (qgroup-s1.qgroup.de [212.96.144.20])
	by qtrust.qgroup.de (Postfix) with ESMTP id D55D42A2BE5
	for <alsa-devel@alsa-project.org>;
	Sat, 18 Aug 2007 15:33:27 +0200 (CEST)
Content-class: urn:content-classes:message
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

Dear Developers,

I'm using the on-board AC97 in 6-channel mode with analog output.
However everything works fine except front channels:

- front right is playing front left
- front left is mute

In stereo mode:

- front right is playing front left
- center is playing front right

I was wandering whether someone could tell me where in the source I can
play with the channel-settings/slots or if there is a solution for my
issue.

Or should I create a Bug-Report?


Regards in advance,


Daniel

lspci output for the sound card: 
00:11.5 0401: 1106:3059 Multimedia audio controller: VIA Technologies,
Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)

Alsamodule: via82xx
