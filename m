From: Matej Laitl <strohel@gmail.com>
Subject: Re: [ALSA] HDA: no sound in headphone-out caused by
	commit f889fa91ad47e (2.6.25-rc1 regression)
Date: Tue, 12 Feb 2008 11:50:36 +0100
Message-ID: <200802121150.36743.strohel@gmail.com>
References: <200802112158.41989.strohel@gmail.com>
	<s5hfxvyv5x4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B3C01038B9
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 11:50:41 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1266118nfd.32
	for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2008 02:50:40 -0800 (PST)
In-Reply-To: <s5hfxvyv5x4.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Matej Laitl wrote:
> > after upgrading from 2.6.24 to 2.6.25-rc1, I lost headphone-out sound
> > output of my Intel HDA card - it is quiet no matter what the mixer
> > settings are.
> >
> > (...)
> >
> > The box is Fujitsu-Siemens Esprimo Mobile M9400 laptop.
>
> Could you give the output of alsa-info.sh for both working and
> non-working kernels?

The locations of alsa-info.sh outputs:
no sound in headphones: http://pastebin.ca/901022
sound ok: http://pastebin.ca/901016

Both kernels are Linus' tree snapshots as of commit cc13e442952a347f7, the one 
with working sound has just the f889fa91ad47e commit reverted.

Matej Laitl
