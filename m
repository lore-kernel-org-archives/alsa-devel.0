From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: [RFC] Break up the patch_sigmatel.c
Date: Wed, 12 Aug 2009 23:35:45 +0300
Message-ID: <1250109345.7974.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 515E924666
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Aug 2009 22:35:52 +0200 (CEST)
Received: by ey-out-1920.google.com with SMTP id 13so97347eye.56
	for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2009 13:35:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi folks,

I own an stac9227 and with latest kernel, it doesn't output any sound
via front headphones. (this a is desktop)

I don't want to bother you with details, etc, I will fix that myself. I
have good knowledge of the device.

However, the mess that is patch_sigmatel.c seems to be doubled. 
its huge file, and there are loads on new codecs added.

I have a suggestion, to break it up into smaller files.
I especially want to move all 'data' from it to header file, and sort it
by model. 

Maybe move pin configs to separate file.
Also I know that stac9200 is quite old, and uses many different support
functions. I could move these in another file as well.

In other words, I want to break it up into several (5 maybe) files,
while not touching the code itself (I so that later maybe)

Since it is quite dirty and hard work, I want to ask if you agree.

Btw, half of static data can be retrieved from codec by querying it
(like dac,adc,pin node ids)

Best regards,
	Maxim Levitsky
