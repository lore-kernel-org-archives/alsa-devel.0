Return-Path: <SRS0=JS7s=PG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D955C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 20:43:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41581600CC
	for <alsa-devel@archiver.kernel.org>; Mon, 18 Oct 2021 20:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41581600CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 098361691;
	Mon, 18 Oct 2021 22:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 098361691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634589788;
	bh=pMhaQFjpTIWsyXPbHLde5KiM0dc6AJI3Q72oQ6xe2VA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YA6oHtGkieiniONn7XYULvTkGdcEsPSKYiORh8yhKy5roWBh0dMRlylwCoXBNT43q
	 ihWq557pm3KbqilnI0wDXShdN5pdUHcJSYGlWCL4zIrj8WVToK1fObtIBsYrUQYNvO
	 kcx2iQFD8+3oDVFUIxW0DGiB/s/nOwOf2TkUKcFA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E622F80217;
	Mon, 18 Oct 2021 22:42:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6675FF80224; Mon, 18 Oct 2021 22:42:15 +0200 (CEST)
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F0A6F801DB
 for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2021 22:42:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F0A6F801DB
Date: Mon, 18 Oct 2021 16:42:04 -0400
From: Rich Felker <dalias@libc.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [musl] Re: [alsa-devel] [PATCH v7 8/9] ALSA: add new 32-bit
 layout for snd_pcm_mmap_status/control
Message-ID: <20211018204203.GM7074@brightrain.aerifal.cx>
References: <20211007165158.GC7074@brightrain.aerifal.cx>
 <s5h5yu79aab.wl-tiwai@suse.de>
 <CAK8P3a0qxNLv3_RcR5COcRGPcTnYMcfbOjdWKiT2hKdcof9WUg@mail.gmail.com>
 <s5hv9277oux.wl-tiwai@suse.de>
 <20211008120736.GF7074@brightrain.aerifal.cx>
 <s5hsfx95n99.wl-tiwai@suse.de>
 <20211018144259.GK7074@brightrain.aerifal.cx>
 <s5hlf2q4byc.wl-tiwai@suse.de>
 <20211018150824.GL7074@brightrain.aerifal.cx>
 <CAK8P3a1RAk5WRtMjqV6QZ1eHtFu_sxhSBJn0Uv-MhRA5WGiJqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1RAk5WRtMjqV6QZ1eHtFu_sxhSBJn0Uv-MhRA5WGiJqQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Baolin Wang <baolin.wang@linaro.org>, Takashi Iwai <tiwai@suse.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 musl@lists.openwall.com, Takashi Iwai <tiwai@suse.com>,
 Michael Forney <mforney@mforney.org>,
 y2038 Mailman List <y2038@lists.linaro.org>, Mark Brown <broonie@kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Oct 18, 2021 at 05:26:35PM +0200, Arnd Bergmann wrote:
> On Mon, Oct 18, 2021 at 5:08 PM Rich Felker <dalias@libc.org> wrote:
> > On Mon, Oct 18, 2021 at 04:58:03PM +0200, Takashi Iwai wrote:
> > > On Mon, 18 Oct 2021 16:43:00 +0200, Rich Felker wrote:
> >
> > No, I don't think so. The musl translator is to translate between the
> > time64 ioctl structures and the old time32 ones for the sake of
> > executing on an old kernel. Up til now, it has been broken comparably
> > to how 32-bit binaries running in compat mode on a 64-bit kernel were
> > broken: the code in musl translated the time64 structure to (and back
> > from) the time32 one assuming the intended padding. But the
> > application was using the actual kernel uapi struct where the padding
> > was (and still is) illogical. Thus, nothing was built with the wrong
> > ABI; it's only the musl-internal translation logic that was wrong (and
> > only pre-time64 kernels are affected).
> >
> > The attached patch should fix it, I think.
> >
> > + int adj = BYTE_ORDER==BIG_ENDIAN ? 4 : 0;
> > + if (dir==W) {
> > +     memcpy(old+68, new+72+adj, 4);
> > +     memcpy(old+72, new+72+4+2*adj, 4);
> 
> I think that should be "new+72+4+3*adj": the "2*adj" would
> be what the code does already for the originally intended
> format.

Well for little endian either would work (because adj is 0 :) but yes
there are 3 such paddings before the second member on big endian, so
it should be 3.

Rich
