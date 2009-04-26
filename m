From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Problem bringing up new alsa driver
Date: Sun, 26 Apr 2009 15:13:34 -0400
Message-ID: <9e4733910904261213t58823435pc08bdbe0f7c11ee7@mail.gmail.com>
References: <9e4733910904231050p76caeeacn89d65c17f0c12408@mail.gmail.com>
	<9e4733910904251428r678cd32fkc6c56e4f43a1887b@mail.gmail.com>
	<s5hljpnwtst.wl%tiwai@suse.de>
	<9e4733910904260842g991f476ib112d12c0f481e5d@mail.gmail.com>
	<s5hws97xsau.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0904261926470.25064@eeebox2.perex-int.cz>
	<9e4733910904261112l488b30b1s6180d651ff2f47f9@mail.gmail.com>
	<alpine.LNX.2.00.0904262020010.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E6E024353
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 21:13:36 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1567765qwk.56
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2009 12:13:35 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904262020010.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 2:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Sun, 26 Apr 2009, Jon Smirl wrote:
>
>> If I take this out I get these errors...
>> ALSA sound/core/pcm_lib.c:264: PCM: hw_ptr skipping! [Q] (pos=3D11026,
>> delta=3D5513, period=3D5513, jdelta=3D33/37/0)
>
> It means that the period DMA operation is too quick in your case and does
> not correspond to the timing specified by rate. It might be that the FIFO=
 on
> path is large or rate set to the codec is not correct. What's HZ value on
> your system and FIFO size? There is HZ/100 margin in the check now.

FIFO is 512 bytes, HZ is 300.

>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
