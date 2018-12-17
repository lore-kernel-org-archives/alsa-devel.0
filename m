From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Mon, 17 Dec 2018 13:53:16 +0200
Message-ID: <6d49609e-e7e9-3786-a321-ac974c20ca6e@gmail.com>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
 <20181126140200.GC9715@sirena.org.uk>
 <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
 <20181213173735.GT10669@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 639D526789E
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 12:53:22 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id q26so12265446wmf.5
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 03:53:22 -0800 (PST)
In-Reply-To: <20181213173735.GT10669@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 12/13/18 7:37 PM, Mark Brown wrote:
> That's not the end of the world, there's plenty of hardware that just
> doesn't physically have a way to mute in hardware at all and a software
> mute isn't particularly complex.

Removing the mute switch, is going to leave many users of DACs
with this CODEC driver without a way to mute their cards.  (I
know there are several boards for the Raspberry Pi platform
alone, some of which have external muting circuits, so they
wouldn't even experience any benefit from the patch.)  I'm not
sure how or where the software muting would be implemented, but
removing the switch would seem like a substantial inconvenience
at the very least, and I can't justify causing it (and deprive
the user of access to the hardware mute functionality of the
board), just to save a few relatively straightforward lines of
code.

That said, the patch seems to have been accepted, so now I'm
confused.  Do I have to make any changes to the patch, or is it
accepted as is?
