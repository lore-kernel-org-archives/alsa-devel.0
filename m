From: "Matt Hirsch" <matthew.hirsch@gmail.com>
Subject: Re: Fwd: surround51 lfe/center/front channel
	cross-talk with intel8x0 board
Date: Tue, 15 Jan 2008 09:13:42 -0500
Message-ID: <975d09800801150613o532aba8br31e930d876e22cb3@mail.gmail.com>
References: <975d09800801042220v5efde614g8ccc18a5f59b0e82@mail.gmail.com>
	<975d09800801141311v14debf13g79e83e6aa2d0c95@mail.gmail.com>
	<1200388427.20323.1231298919@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by alsa0.perex.cz (Postfix) with ESMTP id 441B32433E
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 15:13:44 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 55so799349wri.2
	for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2008 06:13:43 -0800 (PST)
In-Reply-To: <1200388427.20323.1231298919@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Jan 15, 2008 4:13 AM, Clemens Ladisch <cladisch@fastmail.net> wrote:
> Matt Hirsch wrote:
> > I have an AC'97 based onboard sound card in my system (snd_intel8x0
> > driver).
>
> This looks like a flaw in your hardware.

I was hoping not :( Is there a way to tell for sure?

> What codec are you using? (see /proc/asound/cards)
>

$ cat /proc/asound/cards
 0 [SI7012         ]: ICH - SiS SI7012
                      SiS SI7012 with AD1980 at irq 3

Thanks,
Matt
