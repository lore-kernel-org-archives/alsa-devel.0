From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: eeprom params for ice1724 module - recommendation?
Date: Wed, 04 Jan 2012 23:30:11 +0100
Message-ID: <4F04D2F3.5060609@ivitera.com>
References: <4F04B89A.1060801@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (static-84-242-75-189.net.upcbroadband.cz
	[84.242.75.189]) by alsa0.perex.cz (Postfix) with ESMTP id 8EDB82449E
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 23:30:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 8ACE8A1A40B20
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 23:30:20 +0100 (CET)
Received: from cable.insite.cz ([84.242.75.189])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nzo-evRimOJT for <alsa-devel@alsa-project.org>;
	Wed,  4 Jan 2012 23:30:15 +0100 (CET)
Received: from [192.168.105.101] (ip28.insite.cz [81.0.237.28])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id 7E517A1A32346
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 23:30:15 +0100 (CET)
In-Reply-To: <4F04B89A.1060801@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 4.1.2012 21:37, Pavel Hofman napsal(a):
> Hi,
> 
> Please which version would you recommend (i.e. accept as a patch)?
> 

I think there is a much better option - defining the eeprom values for
this card in the driver and choosing it with the model name. I will send
the patch.

Regards,

Pavel.
