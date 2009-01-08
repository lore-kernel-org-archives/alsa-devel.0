From: Daniel Mack <daniel@caiaq.org>
Subject: Re: snd_usb_caiaq bug?
Date: Thu, 8 Jan 2009 23:14:42 +0100
Message-ID: <20090108221442.GC31383@buzzloop.caiaq.de>
References: <s5hk597t6pm.wl%tiwai@suse.de>
	<31e66c9e0901071046v36112db7s757788bcf5beaeeb@mail.gmail.com>
	<907c05c70901071206y4bba38bej47f3eba51e6106d3@mail.gmail.com>
	<s5hy6xmhgp3.wl%tiwai@suse.de>
	<31e66c9e0901071659p63219af1wb392f50541cda7a0@mail.gmail.com>
	<31e66c9e0901071734t70c980a8t87f668f973b54635@mail.gmail.com>
	<s5h4p0at563.wl%tiwai@suse.de>
	<907c05c70901080626x83c3e2fn158d2938c4c8cbfd@mail.gmail.com>
	<s5h7i559845.wl%tiwai@suse.de>
	<907c05c70901080643k3c1ecf39g3495e839fafdd238@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 846EE103807
	for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2009 23:14:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <907c05c70901080643k3c1ecf39g3495e839fafdd238@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mysth-R <mysthr21@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Marco Santamaria <marco.santamaria@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 08, 2009 at 03:43:22PM +0100, Mysth-R wrote:
> > Please let me know if you still encounter relevant problems.
> >
> > No problem... Thank you again for your help.
> By the way is there any plan to make buttons and lights to work on the Audio
> Kontrol 1 ? It could be a really cool feature.

That's done already: Buttons are exported as Linux input device (if
enabled in kernel config) and LEDs can be controlled using the ALSA
controllers API (amixer and friends). Did you try that?

Best regards,
Daniel
