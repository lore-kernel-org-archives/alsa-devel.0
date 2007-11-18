From: Ctirad Fertr <c.fertr@gmail.com>
Subject: Re: E-mu 1212M ADAT channels missing ?
Date: Sun, 18 Nov 2007 11:45:52 +0100
Message-ID: <200711181145.53028.c.fertr@gmail.com>
References: <745480.9857.qm@web51104.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.vol.cz (smtp1.vol.cz [195.250.128.78])
	by alsa0.perex.cz (Postfix) with ESMTP id 0FABF244E7
	for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2007 11:45:59 +0100 (CET)
Received: from [10.16.3.4] (dsl-tn-6-43.static.adsl.vol.cz [83.148.7.43])
	by smtp1.vol.cz (Postfix) with ESMTP id B513886232
	for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2007 11:45:58 +0100 (CET)
In-Reply-To: <745480.9857.qm@web51104.mail.re2.yahoo.com>
Content-Disposition: inline
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

Dne Sunday 18 of November 2007 05:54:37 Kenneth Long napsal(a):
> I'm using qjackctl to launch jackd and before, I would
> see the PCM channels appear under "Connect" button.
> Alsa_pcm only shows two channels "capture_1 and
> capture_2. Before there were 16 channels...

Do you use correct capture device in qjackctl? The correct device for 
multichannel capture is 0,2 (in case your card is 0). 

------
Ctirad
