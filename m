From: Daniel Mack <zonque@gmail.com>
Subject: Re: GR-55 Driver
Date: Mon, 16 May 2011 09:05:54 +0200
Message-ID: <BANLkTimD7pPS6ErrWA6rVKzjV1KoOj-yWw@mail.gmail.com>
References: <1305224448.5083.37.camel@TrinaryDragon>
	<BANLkTimvr7TkmTiCeeNOeOH66++sHnCfbg@mail.gmail.com>
	<1305233604.8214.2.camel@TrinaryDragon>
	<BANLkTikGVDWxShJOsfspETPVwKDqcJtNOg@mail.gmail.com>
	<1305253856.5076.65.camel@TrinaryDragon>
	<BANLkTi=jj7cjxgmOpH+EHnUMuazqLOEsZA@mail.gmail.com>
	<1305441562.2850.7.camel@TrinaryDragon>
	<BANLkTik-m+BmV0+vQyVfPPDSmCgXspCuAg@mail.gmail.com>
	<1305501208.7165.13.camel@TrinaryDragon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B095103899
	for <alsa-devel@alsa-project.org>;
	Mon, 16 May 2011 09:05:56 +0200 (CEST)
Received: by pzk26 with SMTP id 26so2382748pzk.38
	for <alsa-devel@alsa-project.org>; Mon, 16 May 2011 00:05:55 -0700 (PDT)
In-Reply-To: <1305501208.7165.13.camel@TrinaryDragon>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeffrey Scott Flesher Gmail <jeffrey.scott.flesher@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 16, 2011 at 1:13 AM, Jeffrey Scott Flesher Gmail
<jeffrey.scott.flesher@gmail.com> wrote:
> Still no luck; I spent most of the day researching and trying things.
>
> This is a file of what information I could dig up; it should be useful
> http://vetshelpcenter.com/media/trouble-shoot-gr-55.txt
>
> Are there any programs/scripts I can install/run that will help trouble
> shoot this?

You most probably just have a confusion about the four cards connected
to your computer.

As you can see from your output of /proc/asound/cards, the GR55 is not
the first one, and hence not the default picked by tools like aplay or
amixer. However, it is present, which is a good sign. For further
parsing the contents of /proc/asound, you need to refer to the device
number, which is not 1 (as in "card1") but 3. What does "cat
/proc/asound/card3/stream0" show?

Just try "alsamixer -D hw:GR55" to control the volume levels, or
"amixer -D hw:GR55 controls" to dump them.

And then, try "aplay -D plughw:GR55,0,0 file.wav" for a first output test.

Does that help?


Daniel
