From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: Fwd: [PATCH] sound working on the macbook pro
Date: Thu, 22 Feb 2007 20:01:06 +0000
Message-ID: <564d96fb0702221201o54468523k20976544157c99c8@mail.gmail.com>
References: <564d96fb0702180906u6dc0f0d9k2cd1d5e1409f1911@mail.gmail.com>
	<564d96fb0702180924y32118e7esf81e5ec2514d3af9@mail.gmail.com>
	<s5hps8674an.wl%tiwai@suse.de>
	<564d96fb0702200140u7aee7dfbt271ed3818ed92366@mail.gmail.com>
	<s5hhcthrq3c.wl%tiwai@suse.de>
	<564d96fb0702201205i11beca64g11ca9602a53ad433@mail.gmail.com>
	<s5hy7mq5h5n.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hy7mq5h5n.wl%tiwai@suse.de>
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

> Interesting.  So, the front (that is hooked to speaker-pin) has no
> influence, too?  And did you get speaker working if you avoid moving
> from speaker_pin to line_outs?
No influence. For some reason the speaker doesn't work. It works when
I remove the fix-up.

> But, its corresponding dac_nid is mapped, so basically 'Front' should
> control the speaker output as it is now.
I don't know why it doesn't. Do you have any suggestion on how to find why?

>
> Takashi
>

Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
