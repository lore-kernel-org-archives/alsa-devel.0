From: Daniel Mack <zonque@gmail.com>
Subject: Re: M-Audio FTU issues
Date: Fri, 22 Jul 2011 10:42:26 +0200
Message-ID: <CACTFLAPqLjFeDykeysvG=LhQaYQKBeM352EkcZ9jDDEVjWg7Rg@mail.gmail.com>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>
	<4E045058.6000405@showlabor.de>
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>
	<4E04B42E.2080906@ladisch.de>
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
	<BAY155-w40601505DEAEF2C675FB21B64F0@phx.gbl>
	<CACTFLAPTo2jGftr2G25yyw5Dn6rBv=ayk+y1Ny6JhnYDwF9BPQ@mail.gmail.com>
	<BAY155-w44BFA897C126A8D60923D6B64F0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 526A6243A9
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Jul 2011 10:42:28 +0200 (CEST)
Received: by ywa8 with SMTP id 8so1073590ywa.38
	for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2011 01:42:27 -0700 (PDT)
In-Reply-To: <BAY155-w44BFA897C126A8D60923D6B64F0@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Juan Pablo Bouza <jpbouza@hotmail.com>
Cc: gdiffey@gmail.com, tiwai@suse.de, clemens@ladisch.de, alsa-devel@alsa-project.org, linuxaudio@showlabor.de, blablack@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 21, 2011 at 10:31 PM, Juan Pablo Bouza <jpbouza@hotmail.com> wrote:
>
> Yes, I know about the duplex mode kernel crash... But anyway, playback is just broken with the patch and my compilation...

All others reported success on this. Are you really playing a plain .wav file?

> Against what version of kernel 3 is the patch supposed to work?

On top of Takashi's master branch:
git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

> Is there any additional kernel configuration option I should or should not use in order to make the patch work??

You should have of course have a kernel which does in general support
the FTU, but nothing more.


Daniel
