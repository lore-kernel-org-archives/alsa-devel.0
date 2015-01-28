From: Pascal Huerst <pascal.huerst@gmail.com>
Subject: sigmadsp: adau1701: Version mismatch while loading
	firmware in 3.18.3
Date: Wed, 28 Jan 2015 14:47:45 +0100
Message-ID: <54C8E881.60106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A4BE261A66
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 14:47:48 +0100 (CET)
Received: by mail-wi0-f178.google.com with SMTP id bs8so3636858wib.5
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 05:47:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Lars-Peter,

i followed the instructions on:

http://wiki.analog.com/resources/tools-software/linux-software/sigmadsp_genfirmware

and built the firmware from my xml-file. But when the driver loads, I
always get:

adau1701 2-0034: Failed to load firmware: Invalid version 2. Supported
firmware versions: 1
adau1701 2-0034: Failed to load firmware
adau1701 2-0034: ASoC: can't set adau1701 hw params: -22

I have been using that .xml/.bin file in 3.14.13 for some time, but now
in 3.18.3 I always get the version mismatch from above.

What am I doing wrong?


regards
pascal
