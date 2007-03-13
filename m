From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: Fwd: [PATCH] sound working on the macbook pro
Date: Tue, 13 Mar 2007 07:14:19 +0000
Message-ID: <564d96fb0703130014u371b91a8p4f6db354153dcec0@mail.gmail.com>
References: <564d96fb0702180906u6dc0f0d9k2cd1d5e1409f1911@mail.gmail.com>
	<s5hhcthrq3c.wl%tiwai@suse.de>
	<564d96fb0702201205i11beca64g11ca9602a53ad433@mail.gmail.com>
	<s5hy7mq5h5n.wl%tiwai@suse.de>
	<564d96fb0702221201o54468523k20976544157c99c8@mail.gmail.com>
	<s5hd5417xmx.wl%tiwai@suse.de>
	<564d96fb0702262134t438dd480t45c83e556f315e2e@mail.gmail.com>
	<s5h8xe8bqu8.wl%tiwai@suse.de>
	<564d96fb0703092157t5b7f171cr1f94125cac32b782@mail.gmail.com>
	<s5hwt1mjyll.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwt1mjyll.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I guess it's a missing initialization for the first line-out jack.
> It works on ohter devices because the default PIN setup has
> AC_PIN_OUT_EN.  But, on Mac, it has AC_PIN_IN_EN by some reason.
>
> The patch below should fix the problm.  Give it a try.

It does :-)
The "Front" control now sets the speaker volume.

> Takashi
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
