From: Knut Petersen <Knut_Petersen@t-online.de>
Subject: Re: [PATCH] rme96 synchronization support
Date: Tue, 13 Aug 2013 12:32:12 +0200
Message-ID: <520A0B2C.7060500@t-online.de>
References: <51FF9C55.80701@t-online.de> <51FFA643.7060504@ladisch.de>
 <52013579.7020304@t-online.de> <s5h4nb2asg5.wl%tiwai@suse.de>
 <52037864.9000205@t-online.de> <s5h61vacb25.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout01.t-online.de (mailout01.t-online.de [194.25.134.80])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EC932619DB
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 12:32:23 +0200 (CEST)
In-Reply-To: <s5h61vacb25.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 13.08.2013 09:19, Takashi Iwai wrote:
> Well, looking at rme96.c, the rme96 driver code can be cleaned up and
> lots of redundant checks can be reduced, then the sync-support patch
> will be the half size.  For example, it's almost useless to check
> RME96_ISPLAYING() in trigger, or doing in close or prepare callback.
> (It's still valid to do it in snd_rme96_create(), though, since the
>   register values are unknown at the first initialization state,
>   though.)
>
> But it's no serious problem, and we can live with the current code.
> So the only problem is the coding-style issues in your patch.

Ok, I admit that I never used scripts/checkpatch.pl ;-) Alsa, feeding the c=
urrent
rme96.c code to scripts/checkpatch.pl gives  235 errors and 205 warnings:

99 * ERROR: trailing whitespace
88 * ERROR: code indent should use tabs where possible
76 * WARNING: please, no spaces at the start of a line
72 * WARNING: line over 80 characters
39 * WARNING: braces {} are not necessary for single statement blocks
21 * ERROR: do not use assignment in if condition
18 * ERROR: that open brace { should be on the previous line
13 * WARNING: braces {} are not necessary for any arm of this statement
8 * ERROR: space required after that ',' (ctx:VxV)
3 * WARNING: quoted string split across lines
1 * ERROR: space prohibited after that '!' (ctx:BxW)
1 * WARNING: Use #include <linux/io.h> instead of <asm/io.h>
1 * WARNING: Avoid CamelCase: <snd_BUG>

Comments to the list of errors and warnings:

The CamelCase snd_BUG() isn=B4t a problem of rme96.c.

I don=B4t agree that code like "if ((err =3D pci_request_regions(pci, "RME9=
6")) < 0)"
is a problem.

I don=B4t agree with the script that lines over 80 characters are _always_ =
a problem.

Nevertheless, I really don=B4t like code alternating between different styl=
es, that=B4s the reason
for some unnecessary braces {} I used in the submitted patches.

So I suggest that I will (re)submit three patches:
- first a patch cleaning the current rme96.c source
- the PM and SYNC patches based on the first patch.

After that additional patches removing useless checks, etc could follow. Bu=
t this
should be patch 4(+) as it=B4s not always obvious for me if a check is real=
ly useless.

Do you agree?

cu,
  Knut
