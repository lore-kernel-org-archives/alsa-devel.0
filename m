From: Colomban Wendling <lists.ban@herbesfolles.org>
Subject: Re: Realtek ALC889: HDA Intel and kernel 3.0 gives
	choppy sound
Date: Wed, 27 Jul 2011 14:53:55 +0200
Message-ID: <4E300A63.30803@herbesfolles.org>
References: <4E2F2E47.8080902@herbesfolles.org>	<s5h8vrk8esz.wl%tiwai@suse.de>	<4E2FF321.4070101@herbesfolles.org>
	<s5h1uxcc6li.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.herbesfolles.org (a4nancy.globenet.org [80.67.172.114])
	by alsa0.perex.cz (Postfix) with ESMTP id 24F40243D1
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 14:53:56 +0200 (CEST)
In-Reply-To: <s5h1uxcc6li.wl%tiwai@suse.de>
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
Cc: Jonathan Nieder <jrnieder@gmail.com>, 635362@bugs.debian.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le 27/07/2011 13:20, Takashi Iwai a =E9crit :
> At Wed, 27 Jul 2011 13:14:41 +0200,
> Colomban Wendling wrote:
>>
>>> Also, you can replace the files in sound/pci/hda/* from 2.6.39 kernel
>>> tree.  If this fixes the problem, it's a sound driver bug.  If not,
>>> it's anything else, e.g. the problem in more core side, e.g. IOMMU
>>> like above or the timer change, etc.
>>
>> Hey, that was a great idea! I reverse-patched sound/pci/hda of 3.0 with
>> 2.6.39.3, and it fixes the problem! :)
> =

> OK, then try to replace only sound/pci/hda/hda_intel.c and keep the
> rest.  What happens?

Doesn't work, that sound is choppy again.

Regards,
Colomban
