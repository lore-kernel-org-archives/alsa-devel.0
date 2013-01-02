From: Bryan Kaminski <dext0rb@gmail.com>
Subject: ASoC: EA3250 V2 machine driver
Date: Wed, 2 Jan 2013 10:06:24 -0600
Message-ID: <CAD2wHyOzx1OSAyfzjeVJKccCO9w5eAGRsuk9JTKYCsLt3si1iA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 07E86260308
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2013 17:06:24 +0100 (CET)
Received: by mail-bk0-f48.google.com with SMTP id jc3so6057288bkc.7
 for <alsa-devel@alsa-project.org>; Wed, 02 Jan 2013 08:06:24 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have an Embedded Artists LPC3250 V2 development board, which has the NXP
UDA1380 audio codec on-board. I'm wondering if someone could help me get
started on making an ASoC driver for it. There already exists a machine
driver for a similar Phytec 3250 development board, with the same audio
codec. I think it should be possible to modify the existing Phytec driver,
but I'm unable to accomplish that. I modified some source and everything
compiled, but I can't get the driver to load correctly. After loading the
module with 'modprobe', I'm unable to get ALSA to recognize any sound
cards. Can anyone give me a jump-start on this?

Sorry if this is the wrong list to post on. I would post at the LPCLinux
official site but it has been down for multiple weeks now. :|

Bryan
