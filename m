From: giggzounet <giggzounet@gmail.com>
Subject: Re: [Regression] With the new 2.6.33 when I plug in
 headphones, the speakers don't turn off anymore
Date: Fri, 26 Feb 2010 15:00:52 +0100
Message-ID: <4B87D414.5050409@gmail.com>
References: <hm82oh$1am$1@dough.gmane.org>	<1267176828.3751.12.camel@mattotaupa>
	<hm8aat$shn$1@dough.gmane.org>	<hm8afm$shn$2@dough.gmane.org>
	<1267184543.3802.13.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 58C3D1037F8
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:01:07 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Nl0kc-0008In-FS
	for alsa-devel@alsa-project.org; Fri, 26 Feb 2010 15:01:06 +0100
Received: from celsius02.unibw-hamburg.de ([139.11.215.121])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:01:06 +0100
Received: from giggzounet by celsius02.unibw-hamburg.de with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 15:01:06 +0100
In-Reply-To: <1267184543.3802.13.camel@mattotaupa>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Paul Menzel a =E9crit :
> Am Freitag, den 26.02.2010, 12:15 +0100 schrieb giggzounet:
>> [snip]
>>
>>>> I do not know why enable_msi is set to =BB-1=AB and not one since it s=
hould
>>>> be enabled by default now [1]. Could you try to load the sound module
>>>> with `enable_msi` set to `0` and report back your findings, please.
>>>>
>>>>         $ sudo modinfo snd-hda-intel
>>>>         [=85]
>>>>         parm:           enable_msi:Enable Message Signaled Interrupt (=
MSI) (int)
>>>>         [=85]
>>>>
>>> I have modified /etc/modprobe.d/sound with :
>>> snd-hda-intel index=3D0 enable_msi=3D0
>>>
>>> I attach the log of alsa-info.
>>>
>> I have forgotten to say that the problem is always here with
>> enable_msi=3D0
>>
>> [snip]
> =

> That=92s unfortunate. It would have been nice if this had fixed it.
> =


I have take a look to the history of changes of hda_intel.f and found that :
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D0a27fcfaaf61108d94f0377f91bed81b2dd35f52

in the source I'm seeing a blacklist :
/*
 * white/black-list for enable_msi
 */
static struct snd_pci_quirk msi_black_list[] __devinitdata =3D {
	SND_PCI_QUIRK(0x1043, 0x81f2, "ASUS", 0), /* Athlon64 X2 + nvidia */
	SND_PCI_QUIRK(0x1043, 0x81f6, "ASUS", 0), /* nvidia */
	{}
};

And on my eeepc 1201n there is lot's of nvidia things...How can I know
if I'm on this blacklist or not ? ...sorry, I don't have a lot of
knowledge in C. But this could be explain why msi is not enabled by
default...

Best regards,
Guillaume
