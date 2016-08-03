From: Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [PATCH] sound: Fix empty menuconfig SND_ARM
Date: Wed, 3 Aug 2016 08:34:44 +0200
Message-ID: <20160803063444.GA7891@eugeniu-X230>
References: <20160730140019.20305-1-rosca.eugeniu@gmail.com>
 <87eg6byzzz.fsf@belgarion.home>
 <20160730151413.GA25440@eugeniu-X230>
 <87a8gyyy7w.fsf@belgarion.home> <s5htwf4wpd1.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BA5E26655E
 for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2016 08:34:46 +0200 (CEST)
Received: by mail-wm0-f66.google.com with SMTP id o80so34654099wme.0
 for <alsa-devel@alsa-project.org>; Tue, 02 Aug 2016 23:34:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5htwf4wpd1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: alsa-devel@alsa-project.org

Thanks Robert, Takashi.

On Mon, Aug 01, 2016 at 04:11:38PM +0200, Takashi Iwai wrote:
> [..] the real problem is rather
> the syntax of menuconfig, which ambiguously defines the suboptions [..]

Proposed some kconfig-language improvement below:
http://www.spinics.net/lists/linux-kbuild/msg13171.html

Regards,
Eugeniu.
