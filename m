From: Eric <ejaouen@ponctey.fr>
Subject: Re: intel DP35DP adat supported (STAC927x codec) ?
Date: Sat, 31 Jan 2009 13:06:46 +0100
Message-ID: <49843ED6.5050703@ponctey.fr>
References: <4969FBA0.1030008@ponctey.fr>
	<s5hvdskdah9.wl%tiwai@suse.de>	<496B3BB7.1020203@ponctey.fr>
	<496E7FE7.8020706@embeddedalley.com>	<16A430A423D62246A24C9A892622FE668D5227@CORPEXCH1.na.ads.idt.com>
	<s5h63jv25pn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp21.orange.fr (smtp21.orange.fr [80.12.242.47])
	by alsa0.perex.cz (Postfix) with ESMTP id EAD821037EA
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 13:06:54 +0100 (CET)
Received: from anita.2sapins.ponctey.fr
	(LRouen-151-72-65-95.w193-251.abo.wanadoo.fr [193.251.41.95])
	by mwinf2107.orange.fr (SMTP Server) with ESMTP id 7EEE01C00087
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 13:06:54 +0100 (CET)
Received: from [192.168.100.3] (unknown [192.168.100.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by anita.2sapins.ponctey.fr (Postfix) with ESMTPS id 2883F5161B
	for <alsa-devel@alsa-project.org>; Sat, 31 Jan 2009 13:06:51 +0100 (CET)
In-Reply-To: <s5h63jv25pn.wl%tiwai@suse.de>
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

Their has never been an ADAT input advertised on the STAC927x codec.
What is needed for this codec to work is a switch to change between
SPDIF and ADAT mode OUTPUT (on the backpanel toslink).
As shown in the codec datasheet :
When choosing ADAT mode : node 1Fh ADATout (instead of node 1Eh spdif)
goes to node 21h Digout.

I think I have to buy the DP35DP so we can make and test the driver
modifications for it to work... I am really interested in the intel ADAT
output capable motherboard line.
Thanks

> I think that mux list is reather "the input source" of SPDIF output,
> not the output target.  i.e. if you choose ADAT there, it means that
> the input from ADAT will go to SPDIF output.
> Takashi
