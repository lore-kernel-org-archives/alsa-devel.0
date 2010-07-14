From: Jason Butler <jbutler@hcn-inc.com>
Subject: controlling access to the sound card
Date: Wed, 14 Jul 2010 14:48:54 -0500
Message-ID: <4C3E14A6.2040903@hcn-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.hcn-inc.com (mail.hcn-inc.com [74.52.94.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FE4E2454B
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Jul 2010 20:48:45 +0200 (CEST)
Received: from cpe001c10f65d93-cm00111ae3031a.cpe.net.cable.rogers.com
	([99.241.128.254] helo=[192.168.1.104])
	by mail.hcn-inc.com with esmtpa (Exim 4.69)
	(envelope-from <jbutler@hcn-inc.com>) id 1OZ70a-0001AD-HZ
	for alsa-devel@alsa-project.org; Wed, 14 Jul 2010 14:48:40 -0400
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

I have three applications that want to use the sound card, two audio 
stream players, and a voip phone.
Is it possible to use alsa so that if a call comes in on the phone alsa 
will disconnect the audio players, give exclusive access to the voip 
phone, and then when the phone is done reconnect the audio players to 
the sound card.

Can this be done using alsa and if so how? Could it be done using just 
the alsa command line tools and config files and if so how?
