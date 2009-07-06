From: Sean Burke <leftmostcat@gmail.com>
Subject: Re: No sound with nVidia Corporation MCP79 High
 Definition Audio (rev b1) (Macbook Pro 5, 5)
Date: Mon, 06 Jul 2009 11:16:35 -0600
Message-ID: <4A523173.5030100@gmail.com>
References: <4A493A56.1050504@gmail.com>
	<200907061723.18123.nutz@unfoog.de>	<s5h8wj1kea7.wl%tiwai@suse.de>
	<200907061753.47013.nutz@unfoog.de> <s5h4otpkcz2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f188.google.com (mail-pz0-f188.google.com
	[209.85.222.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F11324390
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Jul 2009 19:16:47 +0200 (CEST)
Received: by pzk26 with SMTP id 26so1485706pzk.16
	for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2009 10:16:45 -0700 (PDT)
In-Reply-To: <s5h4otpkcz2.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: =?ISO-8859-1?Q?Andreas_N=FC=DFlein?= <nutz@unfoog.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Scr=EDobh Takashi Iwai:
> At Mon, 6 Jul 2009 17:53:46 +0200,
> Andreas N=FC=DFlein wrote:
>   =

>>> The missing pin configuration initialization was already fixed by
>>> the driver overriding it after checking PCI SSID (which is different
>>> from the codec SSID).  So, this should be no problem.
>>>
>>> However, the reason why the analog output doesn't work might be
>>> different from that.  There might be something else missing, but I
>>> don't know.
>>>
>>>
>>> Takashi
>>>       =

>> oh =3D(
>>
>>
>> hmm.. anything i can do?  would it help if i tried changing values rando=
mly =

>> with hda-analyzer.py?
>>     =

>
> Well, did the driver without my change work more or less with
> the analog audio, or have you never gotten the analog output?
> You can use the generic parser (i.e. the state without cirrus patch)
> by passing model=3Dgeneric option to snd-hda-intel.
>   =

For my part, nothing worked with the generic driver. I can't confirm
digital out, but I can confirm that the kfree error is gone. What
options are open for figuring out what remains?


Sean
