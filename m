From: Jelle de Jong <jelledejong@powercraft.nl>
Subject: using dshare plugin to create multiple independent
 audio outputs for multiseat out of 7.1 internal audio card
Date: Mon, 27 Oct 2008 10:37:53 +0100
Message-ID: <49058BF1.3090705@powercraft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from node02.cambriumhosting.nl (node02.cambriumhosting.nl
	[217.19.16.163]) by alsa0.perex.cz (Postfix) with ESMTP id F2ABD246B7
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:37:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by node02.cambriumhosting.nl (Postfix) with ESMTP id 971FCB0000A7
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:37:55 +0100 (CET)
Received: from node02.cambriumhosting.nl ([127.0.0.1])
	by localhost (node02.cambriumhosting.nl [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id ziM7XvUlaORT for <alsa-devel@alsa-project.org>;
	Mon, 27 Oct 2008 10:37:55 +0100 (CET)
Received: from ashley.powercraft.nl (84-245-3-195.dsl.cambrium.nl
	[84.245.3.195])
	by node02.cambriumhosting.nl (Postfix) with ESMTP id 41C79B00009A
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:37:55 +0100 (CET)
Received: from [192.168.1.180] (unknown [192.168.1.180])
	by ashley.powercraft.nl (Postfix) with ESMTPSA id 1B5F923BC575
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 10:37:55 +0100 (CET)
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

Hello everybody,

I am looking for ways to get good cheap audio outputs per user for
multiseat systems.

A nice good way would be to be able to use the available resources of
motherboards than now come often with 8-channel audio cards with 6 or
more audio outputs ... (6 users)

I have seen something about dshare plugin that might be able to do this,
but I have no idea how this works or how and if it is possible to
configure this for multiple users?

Would somebody be able to do some experimenting and maybe make some
examples with some .asoundrc quotes?

Chipset integrated by Realtekr ALC888/ALC888T
- Flexible 8-channel audio with jack sensing
- Compliant with Azalia 1.0 Spec

Any ideas, solutions?

Thanks in advance,

Jelle
