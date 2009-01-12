From: Eric <ejaouen@ponctey.fr>
Subject: Re: intel DP35DP adat supported (STAC927x codec) ?
Date: Mon, 12 Jan 2009 13:46:47 +0100
Message-ID: <496B3BB7.1020203@ponctey.fr>
References: <4969FBA0.1030008@ponctey.fr> <s5hvdskdah9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp20.orange.fr (smtp20.orange.fr [193.252.22.31])
	by alsa0.perex.cz (Postfix) with ESMTP id B2A291037ED
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 13:46:52 +0100 (CET)
Received: from anita.2sapins.ponctey.fr
	(LRouen-151-72-65-95.w193-251.abo.wanadoo.fr [193.251.41.95])
	by mwinf2021.orange.fr (SMTP Server) with ESMTP id 374B01C000C5
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 13:46:52 +0100 (CET)
Received: from [192.168.100.3] (unknown [192.168.100.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by anita.2sapins.ponctey.fr (Postfix) with ESMTPS id 58B7B51615
	for <alsa-devel@alsa-project.org>; Mon, 12 Jan 2009 13:46:51 +0100 (CET)
In-Reply-To: <s5hvdskdah9.wl%tiwai@suse.de>
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

In their handbook, motherboard intel DP35DP and others with STAC927x (in
the codec datasheet also ADAT output is featured on older sigmatel
STAC9271 and now IDT STAC9274 only) advertise ADAT output possible on
their toslink.
DP35DP and other intel boards are proven to have the ADAT output working
under windows.
Is it working in Alsa ? Many HTPC users would love that... I would !

Anybody from intel or IDT/sigmatel to confirm (by checking the sigmatel
STAC927x hda codec driver) that it will work ?
I want these intel motherboards only for this ADAT output feature and I
am a linux only user so I would like to know before buying...
I want to be sure someone would make the necessary changes to the hda
sigmatel codec alsa driver so it would work.
Thank you everybody


>> Is the ADAT output of the IDT (sigmatel) STAC927x HDA codec supported in
>> alsa ?
>> If not could someone please try to add this incredibly nice feature in
>> the existing alsa driver ?


> Do you have any HD-audio device with ADAT?
> IIRC, there is no specific verbs for ADAT on STAC927x...
> Takashi
