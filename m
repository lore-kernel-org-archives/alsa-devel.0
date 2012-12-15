From: =?UTF-8?Q?Nicolas_Ma=C3=AEtre?= <nimai@skynet.be>
Subject: Re: Fwd: Request for HW auto-recognition: HP Pavilion
 dv7 with STAC92xx
Date: Sat, 15 Dec 2012 23:31:57 +0100
Message-ID: <CACd4Q03Vy4DBVVM5gyo9NF+aOaBAPoKig8hG7SahMdNhq=smjQ@mail.gmail.com>
References: <CACd4Q01r1Oa=ds0+eskdkvnMJytuLRj5FPYyNjbdnx5WNWWZvQ@mail.gmail.com>
 <CACd4Q01r58JL3hD49mtT97+7Jkdpr8Sgfni88wHfsE79_dTP6A@mail.gmail.com>
 <s5hr4mrpqek.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f53.google.com (mail-wg0-f53.google.com [74.125.82.53])
 by alsa0.perex.cz (Postfix) with ESMTP id B66DA261981
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2012 23:32:17 +0100 (CET)
Received: by mail-wg0-f53.google.com with SMTP id ei8so2066743wgb.20
 for <alsa-devel@alsa-project.org>; Sat, 15 Dec 2012 14:32:17 -0800 (PST)
In-Reply-To: <s5hr4mrpqek.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 15, 2012 at 11:21 AM, Takashi Iwai <tiwai@suse.de> wrote:
> So in this case you need to figure out the exact pin configurations on
> your machine.  hda_analyzer and hdajackretask programs would be a
> great help for that.

Well, I don't know how to do that efficiently. I have spent some time
trying to play with hda analyzer and hda-jack-retask but I think it
was just a waste of time.
I've used "speaker-test -c 6" as test for each change. Here are my
notes on my attempts to make something work by overriding the pins in
hda-jack-retask, in case is could be useful anyway:
http://pastebin.com/HVgURDuA
I've realized it was probably not the good way to go when I've seen
that the fact that pulseaudio were running actually changed the
mapping.

So, do you know some guide/howto I could follow to do something useful
with my issue?

Thanks.


--
nimai
