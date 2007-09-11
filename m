From: Krzysztof Helt <krzysztof.h1@gmail.com>
Subject: Re: [PATCH] New Aztech Sound Galaxy driver.
Date: Tue, 11 Sep 2007 21:07:04 +0200
Message-ID: <20070911210704.e738bd61.krzysztof.h1@gmail.com>
References: <46E1DD43.6060403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by alsa0.perex.cz (Postfix) with ESMTP id D26A8103870
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Sep 2007 21:00:18 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so559760wri
	for <alsa-devel@alsa-project.org>; Tue, 11 Sep 2007 12:00:17 -0700 (PDT)
In-Reply-To: <46E1DD43.6060403@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Ram Kromberg <ramkromberg@mail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 08 Sep 2007 01:22:43 +0200
Rene Herman <rene.herman@gmail.com> wrote:

> 5. I38-MMSN852 = AZT2316R + CS4231A-KL, with EEPROM
> 

I got this one. It has also AZT3320 chip.

> All cards with a settings EEPROM have been tested with their JMPCFG jumper 
> set to both EEPROM and SOFTWARE, and work correctly in both situations.
> 

The JMPCFG was set to software.
 
I run into these problems:

1. There is a problem with freeing resources in the probe function. If the probe
ends with error, removal of the driver does not release requested regions, so the
driver cannot be reloaded again (and cat /proc/iports crashes). It is easy to
reproduce: give irq number which is already acquired by another driver
then unload driver.

2. After a while I found the free irq (it took quite long with this manual settings).
 The driver loaded, the /proc/asound/* files showed GALAXY something
but the alsamixer ended with message that there was no mixer device. 

I look forward to next version of your driver to test,
Krzysztof
