From: Karsten Wiese <fzu@wemgehoertderstaat.de>
Subject: Re: [PATCH] snd-usb-us122l v0.2 for US-122L
Date: Mon, 17 Mar 2008 13:45:14 +0100
Message-ID: <200803171345.14768.fzu@wemgehoertderstaat.de>
References: <200803161956.42461.fzu@wemgehoertderstaat.de>
	<s5hskypr9a9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 86725103850
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 13:45:20 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so2336197nfd.32
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 05:45:19 -0700 (PDT)
In-Reply-To: <s5hskypr9a9.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: alsa-devel@alsa-project.org, Samuel Mimram <samuel.mimram@ens-lyon.org>, Federico Briata <federicobriata@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am Montag, 17. M=E4rz 2008 schrieb Takashi Iwai:
> At Sun, 16 Mar 2008 19:56:41 +0100,
> Karsten Wiese wrote:
> > =

> > Hi,
> > =

> > attached is a fresh US-122L linux(test-)driver.
> =

> Karsten, is this supposed to be merged to ALSA (and upstream) tree?

Yes.
> =

> If it's highly experimental and you are still unsure to push to the
> linux kernel tree, we can keep it in alsa-driver tree.  If it's in a
> form that can be in the kernel tree but still you feel unsafe, you can
> add the dependnecy to CONFIG_EXPERIMENTAL, too.

Hm, as I wrote it needs a patch for ehci-hcd or it will only work when
connected to uhci-hcd. (ohci-hcd should be ok too, but I have no such.)
The needed ehci patch is in David Brownell's review queue, he wrote.
I hope he'll review it in time to go into 2.6.26 kernel.

I'd prefer inclusion into alsa-kernel with dependency to CONFIG_EXPERIMENTA=
L,
as long as the ehci-patch isn't accepted.

We can also wait a little for David's review of the ehci-patch and decide l=
ater.


      Karsten
