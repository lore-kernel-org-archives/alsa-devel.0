From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH] alsa-lib:Make snd_atomic_write_* truly
 atomic
Date: Tue, 17 May 2016 17:28:43 +0200
Message-ID: <alpine.DEB.2.02.1605171718010.31333@lnxricardw1.se.axis.com>
References: <570E2279.7060809@axis.com> <s5hwpo14o0n.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121446220.31333@lnxricardw1.se.axis.com>
 <s5h37pnctrf.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605121556390.31333@lnxricardw1.se.axis.com>
 <s5hmvnvbafu.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605131426000.31333@lnxricardw1.se.axis.com>
 <s5hposq9lsi.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605171053010.31333@lnxricardw1.se.axis.com>
 <s5hr3d07u48.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1605171440470.31333@lnxricardw1.se.axis.com>
 <s5hy478u7nu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id C685A2619FA
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 17:28:52 +0200 (CEST)
In-Reply-To: <s5hy478u7nu.wl-tiwai@suse.de>
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
Cc: =?ISO-8859-15?Q?Arvid_Nihlg=E5rd_Lindell?= <arvidnl@axis.com>, Andreas x Larsson <andrelan@axis.com>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 17 May 2016, Takashi Iwai wrote:

> No, my proposal is to make all snd_atomic_*() NOP unless a configure
> option is passed.

Ok, I must honestly say I hadn't studied the actual pcm_plugin.c code in =

great detail before (I didn't create the patch but was in the train of =

discussion at the time). I had just assumed that the w->begin and w->end =

variables were some form of counters used outside the atomic functions, =

but I can see now that they are not.

Looking at it now it appears that all this atomic stuff is trying to =

accomplish is to avoid the (sole) read in snd_pcm_plugin_status() from =

happening during one of the many potential writes in the other functions =

in the file, and the only reason for that in turn seems to be to get the =

acceses to *pcm->appl.ptr and *pcm->hw.ptr as well as other things needed =

for the return snd_pcm_status_t* consistent.

But that in turn means that fixing the atomicity of the w->begin and =

w->end accesses as proposed in the patch just glosses over that particular =

implementation issue; if indeed something is calling the functions doing =

the writes concurrently, something else is bound to get screwed up, unless =

by chance the two calls touch different variables, or the timing is such =

that two things aren't touched at the same time.

Right now it feels a bit uncomfortable to fix it in this way. It's just =

luck if it doesn't die somewhere else. Or am I missing something (highly =

likely)?

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
