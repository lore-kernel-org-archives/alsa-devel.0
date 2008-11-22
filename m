From: Vincent Petry <PVince81@yahoo.fr>
Subject: Problem: different volumes for different jacks in
	ALC888
Date: Sun, 23 Nov 2008 01:24:50 +0800
Message-ID: <49284062.3060609@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n13.bullet.mail.mud.yahoo.com (n13.bullet.mail.mud.yahoo.com
	[68.142.206.40]) by alsa0.perex.cz (Postfix) with SMTP id 9C7242414F
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 18:24:35 +0100 (CET)
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
Cc: manu@frogged.de
List-Id: alsa-devel@alsa-project.org

Hi,

We have designed a new model for the following laptop: Amilo Xa3530 from
Fujitsu Siemens (see bug report 0004240 for alsa-info).

The chipset is Realtek ALC888.

When using channel mode with 6ch or 8ch, the mic-in jack (0x18) is
converted to an output (PIN_OUT 0x40).
The problem is that the CLFE channel (0x0e) on the mic-in jack (0x18) is
not loud enough. When reassigning the CLFE (0x0e) to the line-out jack
(0x17), the volume is at a normal level.

But in the codec there is no volume difference between the connection
paths from mic-in and side path.

I saw that the Mic-in also has a VREF value, but changing it doesn't
affect the volume. AFAIK the VREF value only affects

Has someone met this kind of issue before?

Thanks,

Vincent Petry
