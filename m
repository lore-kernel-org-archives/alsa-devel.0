From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] ALSA: hda - Add PCI quirks for MSI
 all-in-one computers NetOn AP1900 and Wind Top AE2220
Date: Mon, 15 Mar 2010 15:59:42 +0100
Message-ID: <20100315155942.2e5d8301@destiny.ordissimo>
References: <20100310191746.5ff22c1b@destiny.ordissimo>
	<s5haaudn4m0.wl%tiwai@suse.de>
	<20100312184747.19462a29@destiny.ordissimo>
	<s5h3a02j92g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DC958103821
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 16:00:01 +0100 (CET)
Received: by pwj7 with SMTP id 7so1196555pwj.38
	for <alsa-devel@alsa-project.org>; Mon, 15 Mar 2010 07:59:59 -0700 (PDT)
In-Reply-To: <s5h3a02j92g.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
On Mon, 15 Mar 2010 09:14:15 +0100, Takashi Iwai <tiwai@suse.de> wrote :

> At Fri, 12 Mar 2010 18:47:47 +0100,
> Anisse Astier wrote:
> > 
> > On Fri, 12 Mar 2010 12:47:51 +0100, Takashi Iwai <tiwai@suse.de> wrote :
> > 
> > > At Wed, 10 Mar 2010 19:17:46 +0100,
> > > Anisse Astier wrote:
> > I didn't know what kernel tree you meant by alsa-driver, but I went ahead and built
> > git://git.alsa-project.org/alsa-kernel.git
> 
> The latest code is found in
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> But the above is almost same regarding HD-audio.
I built sound-2.6 with and without the patch, and it doesn't work without,
so you're right.

> 
> > I tested it on both computers, and speakers were not working, I only had sound on the external output.
> > 
> > > 
> > > Anyway, it'd be helpful if you give alsa-info.sh outputs (run with
> > > --no-upload option).
> > 
> > Anyway, I attached the AE2220 alsa-info.sh output, followed by AP1900's.
> 
> OK, applied the patch now.
Thanks!

Anisse
