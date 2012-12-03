From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH sound-unstable] usb-audio: sync ep init fix
 for audioformat mistmatch
Date: Mon, 3 Dec 2012 19:48:16 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1212031932420.1485@xoschi>
References: <s5hk3t4alc0.wl%tiwai@suse.de>
 <1354402226-2392-1-git-send-email-eldad@fogrefinery.com>
 <50BC7225.4050204@gmail.com> <s5hr4n71nf8.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C1C0B2616DD
 for <alsa-devel@alsa-project.org>; Mon,  3 Dec 2012 19:48:30 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so1161194bkc.38
 for <alsa-devel@alsa-project.org>; Mon, 03 Dec 2012 10:48:30 -0800 (PST)
In-Reply-To: <s5hr4n71nf8.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Daniel Mack <zonque@gmail.com>
Cc: Grant Diffey <gdiffey@gmail.com>, Chris Cavey <chris-alsa@rauros.net>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, George Willian Condomitti <georgecondomitti@gmail.com>, Jeffrey Barish <jeff_barish@earthlink.net>
List-Id: alsa-devel@alsa-project.org


Hi Daniel, Takashi,

On Mon, 3 Dec 2012, Takashi Iwai wrote:
> At Mon, 03 Dec 2012 10:34:29 +0100,
> Daniel Mack wrote:
> > On 01.12.2012 23:50, Eldad Zack wrote:
> > 
> > Thanks for fixing this up, and sorry for the late response on this.

It was fun to write, so I'm glad you were busy with other things :)

> > > +	if (!(fp->formats && pcm_format)) {
> > 
> > That should be a binary &, no?
> 
> Oh yeah, this must be
> 
> 	if (!(fp->formats && (1ULL << pcm_format)))

Oh, I see now I managed to somehow concoct two bugs in one line.
At least it worked because of the logical & ...

Fixed now, and of course the nr_rates.
I'll test and submit soon.

Many thanks to both of you, I appreciate it!

Cheers,
Eldad
