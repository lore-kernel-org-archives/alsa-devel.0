From: vivek kaushik <vic.techlist@gmail.com>
Subject: testing mic-in for tlv320aic33
Date: Tue, 1 Dec 2009 00:29:53 +0530
Message-ID: <1932e3c30911301059s23ad8110rd5f106d44d331f71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f171.google.com (mail-vw0-f171.google.com
	[209.85.212.171])
	by alsa0.perex.cz (Postfix) with ESMTP id E8D80103810
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 19:59:55 +0100 (CET)
Received: by vws1 with SMTP id 1so1235092vws.23
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 10:59:53 -0800 (PST)
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

Hi All,

I am testing MIC IN on tlv320aic33. but getting the following error:
arecord: pcm_read:1338: read error: Input/output error

On my custom board tlv320aic33 is connected mcbsp-1 of omap3530, i am
configuring tlv as mater and omap3530 as slave.aplay is working fine for me
but getting the above error in case of arecord.

I am testing MIC IN with following command

arecord -fdat record.wav

when i probe signals I am getting proper MCLK, WCLK(48khz) and BCLK(1.5Mhz)
but there is no toggling on data line.

would be grateful to any help

Thanks in advance

Cheers

Vivek
