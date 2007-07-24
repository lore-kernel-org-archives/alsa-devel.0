From: Marek Zelem <marek@terminus.sk>
Subject: Re: No sound card found for ATI SB600 Azalia
Date: Tue, 24 Jul 2007 21:53:01 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0707242139260.25733@shell.terminus.sk>
References: <Pine.LNX.4.58.0707232239190.25733@shell.terminus.sk>
	<75b66ecd0707231942k15fa92c3mc67211764375bee8@mail.gmail.com>
	<s5hd4yiyvb6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from s-mail.terminus.sk (seldon.terminus.sk [85.248.119.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 193A724369
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 21:53:14 +0200 (CEST)
In-Reply-To: <s5hd4yiyvb6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org


  Hi

On Tue, 24 Jul 2007, Takashi Iwai wrote:

> Well, in this case, the codec probe itself fails, so we cannot get the
> mostly userful information such as codec#* proc files.  Thus it won't
> be helpful to give such instructions.
>
> I suspect this particular case is rather an ACPI problem like others.
> Some ACPI-related boot options are worth to try...

I have tried almost everything about ACPI and also IRQ routing but without
success.
If it helps, the BIOS reports that there is Sigmatel 9205 audio card.

Is there any chance to make it work? I am C programmer so do not hesitate
to point me into sources, add printks which will help to figure out why
the codec is not detected.

Thanks a lot

Marek
