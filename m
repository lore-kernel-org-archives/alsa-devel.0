From: Jean-Christian Hassler <jhassler@free.fr>
Subject: Question to integrate a new driver
Date: Tue, 15 May 2007 21:06:09 +0000 (UTC)
Message-ID: <1179349709.6403.12.camel@piorce>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g19.free.fr (smtp3-g19.free.fr [212.27.42.29])
	by alsa0.perex.cz (Postfix) with ESMTP id AFE9E2487B
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2007 23:05:45 +0200 (CEST)
Date: Wed, 16 May 2007 23:08:29 +0200
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

Hello !

I wrote with a friend an ALSA driver for the emagic AUDIOWERK 2
soundcard. Now it works for the analog inputs/outputs.

The project page is here : http://home.gna.org/aw2-alsa/index.html

We have 2 questions to continue our work :
1- what is the way to submit our code to be integrated in the ALSA
tree ?
2- We develop on two different version of the kernel (2.6.17-14 &
2.6.20) and the request_irq function prototype has changed between these
two versions(the "struct pt_regs *" does no longer exists), how is this
managed in ALSA ?

Thank you
