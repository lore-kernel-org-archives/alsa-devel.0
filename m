From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: trying to get sound working at a mac book pro
	(core 2 duo)
Date: Wed, 14 Feb 2007 22:32:13 +0000
Message-ID: <564d96fb0702141432v1146817egf879533ba44163b6@mail.gmail.com>
References: <564d96fb0702141121j185378d1m4c3a192831442fb7@mail.gmail.com>
	<1171482019.7083.8.camel@razman.gruemaster.com>
	<564d96fb0702141209g6b032115pebe2ce1a7e3de57b@mail.gmail.com>
	<564d96fb0702141235p4ed263fdnb14de941be27e334@mail.gmail.com>
	<564d96fb0702141256t55f2febbna1e9bbdf50c200d@mail.gmail.com>
	<s5hire4l6ho.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.227])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E478030A
	for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2007 23:32:14 +0100 (MET)
Received: by hu-out-0506.google.com with SMTP id 34so116003hui
	for <alsa-devel@alsa-project.org>; Wed, 14 Feb 2007 14:32:14 -0800 (PST)
In-Reply-To: <s5hire4l6ho.wl%tiwai@suse.de>
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

> The driver always takes PCI SSID as a key for table-lookup.
> The codec has its own SSID (and often a different value from PCI SSID)
> as proc shows, but it's not used anywhere in the driver code.
Yes, but it looks like we will have to use it to disambiguate the mac books :-(

>
> Takashi
>
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
