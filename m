From: "=?UTF-8?Q?Rafael_Esp=C3=ADndola?=" <rafael.espindola@gmail.com>
Subject: Re: Fwd: [PATCH] sound working on the macbook pro
Date: Tue, 20 Feb 2007 09:40:35 +0000
Message-ID: <564d96fb0702200140u7aee7dfbt271ed3818ed92366@mail.gmail.com>
References: <564d96fb0702180906u6dc0f0d9k2cd1d5e1409f1911@mail.gmail.com>
	<564d96fb0702180924y32118e7esf81e5ec2514d3af9@mail.gmail.com>
	<s5hps8674an.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hps8674an.wl%tiwai@suse.de>
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

> How (and what) does it fail exactly?
a "diff" of the trace without and with the fix-up is:

1) snd_hda_parse_pin_def_config moves the speaker to the line_out
2) stac92xx_add_dyn_out_pins adds two line_outs
3) stac92xx_auto_create_multi_out_ctls creates the controls "Front",
"Surround", Center, LFE
4) stac92xx_auto_create_hp_ctls doesn't run add_spec_dacs or
create_controls for the speaker. It then creates a control name Master
instead of Headphone.

> I'm sure that this would break many other devices.  So, the patch is
> unacceptable as it is, unfortunately.
>
> The line_outs are actually primary outputs, not exactly "line-out".
> You can find pretty many codes that refer to this as the primary
> output.
Do you consider changing this a long term goal? I agree that we should
first try to get the sound working on the mac book, but the current
implementation is strange IMHO.

>
> Takashi
>

Thanks,
Rafael

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
