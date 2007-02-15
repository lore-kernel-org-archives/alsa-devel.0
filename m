From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: trying to get sound working at a mac book pro
	(core 2 duo)
Date: Thu, 15 Feb 2007 19:55:06 +0000
Message-ID: <564d96fb0702151155q8d568ebj91ad7488faf1be6a@mail.gmail.com>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
	<1171482019.7083.8.camel@razman.gruemaster.com>
	<564d96fb0702141209g6b032115pebe2ce1a7e3de57b@mail.gmail.com>
	<564d96fb0702141235p4ed263fdnb14de941be27e334@mail.gmail.com>
	<564d96fb0702141256t55f2febbna1e9bbdf50c200d@mail.gmail.com>
	<s5hire4l6ho.wl%tiwai@suse.de>
	<1171502000.7083.23.camel@razman.gruemaster.com>
	<s5hsld7aack.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 308C9394
	for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2007 20:55:09 +0100 (MET)
Received: by nf-out-0910.google.com with SMTP id n29so1217480nfc
	for <alsa-devel@alsa-project.org>; Thu, 15 Feb 2007 11:55:06 -0800 (PST)
In-Reply-To: <s5hsld7aack.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> As I mentioned in another mail, so far, it'd be much easier to check
> the codec SSID in each patch code rather than changing the common PCI
> quirk lookup.
>
> An experimental patch is below.  Rafael, please give it a try.

It works. I have to do more tweaking on the macbook_pro_pin_configs,
but this patch is a nice improvement.

>
> Takashi

Thanks,
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
