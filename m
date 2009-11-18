From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: Status of ALSA support for MacBook Pro 5,
	2 in 	kernel 2.6.32
Date: Wed, 18 Nov 2009 06:50:48 -0500
Message-ID: <604760770911180350h6a4e8cd6we2c23f3189bf368f@mail.gmail.com>
References: <200911181223.16905.adolf.j.winterer@inn-salzach.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id 83DC8245F6
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 12:50:49 +0100 (CET)
Received: by pwj11 with SMTP id 11so1303849pwj.32
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 03:50:48 -0800 (PST)
In-Reply-To: <200911181223.16905.adolf.j.winterer@inn-salzach.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adolf Winterer <adolf.j.winterer@inn-salzach.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 18, 2009 at 6:23 AM, Adolf Winterer
<adolf.j.winterer@inn-salzach.de> wrote:
> Some sources stated that the patches for the MacBook Pro 5,1 would
> support the MacBook Pro 5,2 as well, others disagreed.

The patches that have been applied for 2.6.32 only add a model quirk
so that you don't have to manually pass model=mbp5 to snd-hda-intel.

> Fact is that with kernel 2.6.30-2, which has ALSA 1.0.20, from Debian
> testing my MacBook Pro 5,2 is not working. There is no sound at all.

This is, of course, unrelated to 2.6.32, which has a fairly different
patch_realtek.c to 2.6.30's.

> Compilation of ALSA sources 1.0.21 using the module assistant fails with
> an error message regarding a missing curly bracket. There is a bug
> report in the Debian bug tracker regarding this, but no progress is
> visible.

Again, unrelated to 2.6.32.

> Compiling the sources directly using the 1.0.21 sources from the ALSA
> project page goes through, but the resulting modules do not load, give
> an error message about an unknown symbol. Therefore I was not able to
> find out if ALSA 1.0.21 supports the MacBook Pro 5,2.

You need to unload *all* the previous ALSA modules. Debian provides
/usr/sbin/alsa to do that:

# /usr/sbin/alsa force-unload

> * Will the support for the MacBook Pro 5,2 be part of the soon to be
> released kernel 2.6.32?

Limited support. For instance, jack sensing doesn't work; you need to
manually adjust the 'Headphone' mixer control, among other things.

> * Or is it already present in kernel 2.6.31?

To some degree support is already present in 2.6.31. You just need to
provide model=mbp5 manually after applying a patch.

> * What is the correct parameter for the loading of the module? Is it
> just "auto" or "mb5"? Or anything else?

See above.

HTH,
Dan
