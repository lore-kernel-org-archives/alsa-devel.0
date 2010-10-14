From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 12:38:50 +0600
Message-ID: <4CB6A57A.90101@gmail.com>
References: <4CB68FC7.2060601@canonical.com>	<4CB69FA4.9030702@gmail.com>
	<AANLkTimu4xyGTKPqV8hRRAthuraACrat9g4mmYpgHX5K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 98FC8103A73
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 08:38:50 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1848438ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 23:38:50 -0700 (PDT)
In-Reply-To: <AANLkTimu4xyGTKPqV8hRRAthuraACrat9g4mmYpgHX5K@mail.gmail.com>
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

> Do you mean that you want to add that "subwoofer" control which is connected
> the the master mono pin of the codec  to the slave controls of the virtual
> master volume control ?
Yes, except "subwoofer" control is to be connected to subwoofer's own 
pin (for instance, 0x17 on Lenovo machines). Subwoofer pins I've seen so 
far have their own output amplifier with mute.

Apart of this, adding presets has usual benefits like giving other 
controls descriptive names (say, "Int. Mic" instead of just "Mic"), but 
obviously it has nothing to do with a subwoofer.

Valentine
