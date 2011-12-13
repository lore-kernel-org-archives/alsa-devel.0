From: Colomban Wendling <lists.ban@herbesfolles.org>
Subject: Re: Realtek ALC889: HDA Intel and kernel 3.1 gives
 choppy sound (again)
Date: Tue, 13 Dec 2011 15:33:04 +0100
Message-ID: <4EE76220.2020103@herbesfolles.org>
References: <4EB85F94.2060908@herbesfolles.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	by alsa0.perex.cz (Postfix) with ESMTP id D6EB9103B0D
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 15:33:10 +0100 (CET)
Received: from [192.168.1.110] (unknown [82.242.152.211])
	by smtp4-g21.free.fr (Postfix) with ESMTP id E205C4C8556
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 15:33:05 +0100 (CET)
In-Reply-To: <4EB85F94.2060908@herbesfolles.org>
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

Le 07/11/2011 23:45, Colomban Wendling a =E9crit :
> Hi,
> =

> Back to 3.0, the sound on my soundcard [1] started to be choppy, I
> reported it [2] and it got fixed (thanks to Takashi Iwai!).
> =

> However, the story repeated with 3.1 (and probably 3.0.8 or before [3]):
> I've got similar choppy sound again.
> =

> I bisected the few commits that happened on
> sound/pci/hda/patch_realtek.c, and finally found the villain:
> =

> "8974bd51 ALSA: hda/realtek - Fix auto-mute with HP+LO configuration"
> =

> Reverting it from v3.1 fixes the problem.
> =

> master (94956ee) also suffers of the problem, but I couldn't test
> without that commit because reverting it fails, too much changes happened.

This bug is still there in 3.2rc5 (dc47ce9).

Regards,
Colomban
