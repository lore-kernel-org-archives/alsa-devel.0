From: "christian pellegrin" <chripell@gmail.com>
Subject: [PATCH RESEND 0/3] ALSA SOC driver for s3c24xx with
	uda134x
Date: Sat, 15 Nov 2008 08:57:59 +0100
Message-ID: <cabda6420811142357w5d60707avaf459b1691489739@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.241])
	by alsa0.perex.cz (Postfix) with ESMTP id 02D441037F3
	for <alsa-devel@alsa-project.org>; Sat, 15 Nov 2008 08:58:00 +0100 (CET)
Received: by rv-out-0708.google.com with SMTP id f25so1819814rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 23:57:59 -0800 (PST)
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
To: alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

This patch adds support for the UDA134X codec and a sound card
definition for one of these UDAs connected to the s3c24xx. It is
*heavily* based on the one made by Zoltan Devai but:

1 since the UDA is the only use of the L3 protocol I can find I just
embedded a stripped-down L3 bit-banging algorithm from the original
RMK work. It is really small.

2 the driver has the possibility to specify the pins used by codec
via platform data so it can work on SMDK2410, SMDK2440 or any custom
design.

3 it tries to guess the right clock source and divider so it is not tied
to a particular crystal used.

4 it fixes some bugs.

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
