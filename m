From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: Re: Changing default card using its name
Date: Tue, 23 Nov 2010 09:54:48 +0100
Message-ID: <4CEB8158.6010809@ivitera.com>
References: <4CE98AB0.4030601@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (upc-plzen.insite.cz [84.242.100.8])
	by alsa0.perex.cz (Postfix) with ESMTP id 4993524437
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 09:54:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id 1A99BA1A40B18
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 09:54:49 +0100 (CET)
Received: from cable.insite.cz ([127.0.0.1])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06ZSuIDQJawc for <alsa-devel@alsa-project.org>;
	Tue, 23 Nov 2010 09:54:49 +0100 (CET)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	by cable.insite.cz (Postfix) with ESMTPSA id E6B3DA1A40B0F
	for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2010 09:54:48 +0100 (CET)
In-Reply-To: <4CE98AB0.4030601@ivitera.com>
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

Pavel Hofman napsal(a):
> Hi,
> 
> Please excuse my ignorance but I have not been able to figure out this 
> simple task. Nowadays most PCs have multiple soundcards (onboard plus 
> HDMI, often another PCI card). Order of the cards is not stable. How do 
> I define in /etc/asound.conf another default card using its name and 
> keep the PCMs defined by its corresponding alsa card/pcm config files?
> 
> In my case aplay -L:
> 
> defaults.ctl.card "CMI8768"
> 
> which IMO would have been the simplest solution.
> 

Well, adding the exclamation mark

!defaults.pcm.card "CMI8768"

does not work either. It may look trivial, but changing the default card
 while preserving the fine-tuned device definitions the for each card in
/usr/share/alsa/pcm/* and /usr/share/alsa/cards/* has been an
unattainable peak for me so far. Neither have I been able to google it
anywhere. IMO there must be a simple way to do this key change.

Thanks a lot for suggestion and hints.

Pavel.
