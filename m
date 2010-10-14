From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 16:30:43 +0800
Message-ID: <AANLkTim8aDvqXfHT9P+E_74mOCOuSMeQO4O1daht=dZm@mail.gmail.com>
References: <4CB68FC7.2060601@canonical.com> <4CB69FA4.9030702@gmail.com>
	<AANLkTimu4xyGTKPqV8hRRAthuraACrat9g4mmYpgHX5K@mail.gmail.com>
	<4CB6A57A.90101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E68D1103A3F
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 10:30:43 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1883950ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 01:30:43 -0700 (PDT)
In-Reply-To: <4CB6A57A.90101@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/14 Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

> Do you mean that you want to add that "subwoofer" control which is
>> connected
>> the the master mono pin of the codec  to the slave controls of the virtual
>> master volume control ?
>>
> Yes, except "subwoofer" control is to be connected to subwoofer's own pin
> (for instance, 0x17 on Lenovo machines). Subwoofer pins I've seen so far
> have their own output amplifier with mute.
>

There are laptop which has 2.1 speakers which subwoofer is connected to
master mono pin of the STAC codec  , The ".1" subwoofer is most likely the
result of a Low pass filter attached to the mono pin

Seem that your Lenovo are not using ALC670,  it is hard to make any comment
without knowing the output of alsa-info.sh
