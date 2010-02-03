From: John Graham <johngavingraham@googlemail.com>
Subject: Access to bytes from the raw audio stream? (AC'97)
Date: Wed, 3 Feb 2010 16:08:38 +0000
Message-ID: <94cf76f1002030808t1d54dc08oab179673e814f016@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f221.google.com (mail-bw0-f221.google.com
	[209.85.218.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 62A8710380F
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 17:08:40 +0100 (CET)
Received: by bwz21 with SMTP id 21so1170040bwz.4
	for <alsa-devel@alsa-project.org>; Wed, 03 Feb 2010 08:08:39 -0800 (PST)
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

Hi there,

I'm new to ALSA, and working on a project where I need to find out
where I can see/modify the raw bytes coming in from/going out to a
device. The device is an AC'97 codec (a philips UCB1400, if it makes
any difference...) on an embedded board.

I tried looking on the web, and found the tutorial at
http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/, but that
seems to be more about device management and configuration.

So, can anybody tell me what functions and files in the sound/
directory of the linux kernel I need to look at to see/modify the raw
data stream coming in? Am I just missing something in the tutorial?
I'd appreciate any suggestions very much.

Thanks,

John Graham
