From: "Daniel Persch" <d.persch@qgroup.de>
Subject: Re: VIA82XX on MSI K78MM Front Channel Problem
Date: Mon, 20 Aug 2007 18:15:31 +0200
Message-ID: <0B9BC0F04D815444AB5AF4450646E01484AF83@qgroup-s1.qgroup.de>
References: <0B9BC0F04D815444AB5AF4450646E01484AF7E@qgroup-s1.qgroup.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qtrust.qgroup.de (mail.qgroup.de [212.96.128.66])
	by alsa0.perex.cz (Postfix) with ESMTP id BB28624482
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 18:15:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by localhost.qgroup.de (Postfix) with ESMTP id 9F1152A2C8C
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 18:15:31 +0200 (CEST)
Received: from qtrust.qgroup.de ([127.0.0.1])
	by localhost (qtrust [127.0.0.1]) (amavisd-new, port 27304) with ESMTP
	id 29065-32 for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 18:15:31 +0200 (CEST)
Received: from qgroup-s1.qgroup.de (qgroup-s1.qgroup.de [212.96.144.20])
	by qtrust.qgroup.de (Postfix) with ESMTP id D0B9A2A2B4A
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Aug 2007 18:15:30 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <0B9BC0F04D815444AB5AF4450646E01484AF7E@qgroup-s1.qgroup.de>
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

Hello again,

After hours and hours, well, I found the problem myself: 

my case has an error in the front-panel connectors 

so the rear connector of the sound card which gets the result of the
front pannel seems plays wrong, too. No I connected the pings with
jumpers and the sound comes as expected...

However I can't explain the center-issue but as I'm running in 5.1 mode
there is no problem (I didn't test again - as glad as I am that it
finally works).


Cheers,

Daniel



> -----Original Message-----
> From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-
> bounces@alsa-project.org] On Behalf Of Daniel Persch
> Sent: Samstag, 18. August 2007 15:33
> To: alsa-devel@alsa-project.org
> Subject: [alsa-devel] VIA82XX on MSI K78MM Front Channel Problem
> 
> Dear Developers,
> 
> I'm using the on-board AC97 in 6-channel mode with analog output.
> However everything works fine except front channels:
> 
> - front right is playing front left
> - front left is mute
> 
> In stereo mode:
> 
> - front right is playing front left
> - center is playing front right
> 
> I was wandering whether someone could tell me where in the source I
can
> play with the channel-settings/slots or if there is a solution for my
> issue.
> 
> Or should I create a Bug-Report?
> 
> 
> Regards in advance,
> 
> 
> Daniel
> 
> lspci output for the sound card:
> 00:11.5 0401: 1106:3059 Multimedia audio controller: VIA Technologies,
> Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
> 
> Alsamodule: via82xx
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
