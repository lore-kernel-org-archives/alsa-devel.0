From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: ALSA UCM
Date: Thu, 04 Nov 2010 10:09:09 +0000
Message-ID: <1288865349.3277.14.camel@odin>
References: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id BD7D510384D
	for <alsa-devel@alsa-project.org>; Thu,  4 Nov 2010 11:09:15 +0100 (CET)
Received: by wwi17 with SMTP id 17so1843050wwi.20
	for <alsa-devel@alsa-project.org>; Thu, 04 Nov 2010 03:09:14 -0700 (PDT)
In-Reply-To: <AANLkTimFdKg=_KDv8fbSJry6XTEsZqyQz7GhzaPxXDYP@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: abraham duenas <aduejazz@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-11-03 at 14:38 -0600, abraham duenas wrote:
> Hello,
> 
> I recently cloned:
> git clone git://git.alsa-project.org/alsa-lib.git alsa-lib
> git clone git://git.alsa-project.org/alsa-utils.git alsa-utils
> and switched to the "ucm" branch to give it try. I have a panda board
> (pandaboard.org it is just a TI OMAP4 platform).
> 

Ok, this is the correct repository.

> I created some configuration files for my card. My conf file is
> 'SDP4430.conf' and my verb is on 'hifi'.
> I came with a simple program to set my verb and configure it for a
> simple device. I'm calling this sequence:
> 1. open it.... snd_use_case_mgr_open(&uc_mgr,"SDP4430")
> 2. reset it ....snd_use_case_mgr_reset(uc_mgr)
> 3. query for my verb.... snd_use_case_get_list(uc_mgr,"_verbs",&mylist)
> 4. set my verb ... snd_use_case_set(uc_mgr,"_verb",*mylist)
> 5. set my created device... snd_use_case_set(uc_mgr,"_enadev","Headset.0")
> 6. close it... snd_use_case_mgr_close(uc_mgr)
> 
> Seems to work ok (without any errors) but I can't see any of my amixer
> controls set/changed accordingly to my verb/device.
> Is this a right sequence to follow? may be my files are not well written?
> 

This sequence looks correct. Can you share with us the relevant parts of
your configuration files. 

Jaroslav did make some changes to the config file format so maybe we
have a formatting problem here.

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
