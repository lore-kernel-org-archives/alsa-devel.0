From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 14:40:25 +0600
Message-ID: <4CB6C1F9.8000504@gmail.com>
References: <4CB68FC7.2060601@canonical.com>
	<4CB69FA4.9030702@gmail.com>	<AANLkTimu4xyGTKPqV8hRRAthuraACrat9g4mmYpgHX5K@mail.gmail.com>	<4CB6A57A.90101@gmail.com>
	<AANLkTim8aDvqXfHT9P+E_74mOCOuSMeQO4O1daht=dZm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D4EA7103B1A
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 10:40:24 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1887160ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 01:40:24 -0700 (PDT)
In-Reply-To: <AANLkTim8aDvqXfHT9P+E_74mOCOuSMeQO4O1daht=dZm@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> There are laptop which has 2.1 speakers which subwoofer is connected to
> master mono pin of the STAC codec  , The ".1" subwoofer is most likely the
> result of a Low pass filter attached to the mono pin
Maybe - I'm not pretending I've seen all possible configurations. Since 
the idea I'm discussing is to just add some new models for several 
laptops with subwoffers, ultimately it doesn't matter which pin has the 
subwoofer connected, it just have to be correct pin for a given laptop 
family (0x17 for mine, whatever corresponds to Master Mono for someone 
else's etc).

> Seem that your Lenovo are not using ALC670,
Nope it doesn't. It is Lenovo Y550P with ALC272, and in my system, the 
subwoofer is connected at pin 0x17. I'm not at it at the moment, but I 
can send alsa-info.sh later if it is of any interest.

Valentine.
