From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-devel] Questions about
	sound/isa/sb/sb8_main.c
Date: Tue, 26 Feb 2008 10:00:38 +0100
Message-ID: <47C3D536.50305@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 190F51038BD
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 09:58:55 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9C7A3A136E
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 03:58:54 -0500 (EST)
Received: from [10.1.2.24] (schk206.dmc-one.com [213.238.46.206])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ECC961F432
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 03:58:53 -0500 (EST)
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

Rask Ingemann Lambertsen wrote:
>    I'm looking at sound/isa/sb/sb8_main.c from linux 2.6.20. In
> snd_sb8_capture_prepare(), a line reads:
>
>         if (chip->capture_format != SB_DSP_OUTPUT) {
>
>    Shouldn't this be SB_DSP_INPUT instead?

Yes.  Now fixed in the ALSA tree.


Thanks!
Clemens
