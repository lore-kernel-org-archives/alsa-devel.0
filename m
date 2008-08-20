From: =?us-ascii?Q?Vaclav=20Peroutka?= <vaclavpe@seznam.cz>
Subject: Small problem with VIA8237/ALC655 onboard
Date: Wed, 20 Aug 2008 23:25:38 +0200 (CEST)
Message-ID: <4053.7206-3884-611247878-1219267538@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxh.seznam.cz [77.75.72.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E84124578
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Aug 2008 23:27:19 +0200 (CEST)
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

Hello all,

I started experimenting with Software Defined Radio and currently using onboard sound VIA8237/ALC655 rev.0 

I found funny behaviour of card inputs. Left channel is OK. But right channel is not routed to the connector and is very noisy. If I switch the input mixer to MIC input, both channels show me the same data - right channel is always connected to microphone input.. So it looks that there is a bug in mixer driver.

I must confess that I have a little bit older Alsa. But before upgrade, is there any change log or bugfix log for snd-via82xx module ? Or does anybody remember that such bug was solved ?

I am glad that sound works now. And I don't want to "destroy" the sound subsystem by upgrading Alsa...

Thank you in advance,
Vaclav
