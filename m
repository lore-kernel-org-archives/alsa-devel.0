From: Sergey 'Jin' Bostandzhyan <jin@mediatomb.cc>
Subject: Re: Surround speaker connection on Acer 8951G
Date: Mon, 19 Aug 2019 21:57:14 +0200
Message-ID: <20190819195714.GA2737@xn--80adja5bqm.su>
References: <20190404192430.GA24729@xn--80adja5bqm.su>
 <20190719111231.GA26592@xn--80adja5bqm.su>
 <s5hzhla9j8b.wl-tiwai@suse.de>
 <20190720165435.GA5855@xn--80adja5bqm.su>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.xn--80adja5bqm.su (xn--80adja5bqm.su [45.62.210.217])
 by alsa1.perex.cz (Postfix) with ESMTP id 5B038F802FB
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 21:57:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20190720165435.GA5855@xn--80adja5bqm.su>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Sat, Jul 20, 2019 at 06:54:35PM +0200, Sergey 'Jin' Bostandzhyan wrote:
> On Fri, Jul 19, 2019 at 04:44:52PM +0200, Takashi Iwai wrote:
> > It might be some other external stuff like an external amp that is
> > missing.  Often it's managed via GPIO or EAPD (that is controlled by
> > HD-audio itself), but sometimes via a vendor-specific verb, or even
> > over a completely different i2c...
> > 
> > In the case of vendor verbs, you can take a look at other quirks for
> > similar models that touches lots of COEF stuff.
> 
> thanks for the pointers, does not sound simple, let's see if I get anywhere,
> I will for sure try.

I am going at a slow pace, but I did not give up and I'd be happy if you or
anyone else from the list would find the time to answer some questions from 
time to time.

Right now I am mostly studying patch_realtek.c, as a first step I want to
make sure that at least my known pins get set up by the driver without
having to go via hdajackretask.

I got my build set up, I also dug up hda-decode-pincfg from the hda-emu
sources and made it compile (very useful if one wants to understand and
compare the pin configurations in patch_realtek.c), so now I am trying
things out every other evening.

One part that is not quite clear to me: what the heck is ALC669X?

Could someone please explain the meaning of alc_codec_rename_pci_table ?

Entry for my vendor id looks like this:
    { 0x10ec0670, 0x1025, 0, "ALC669X" },

If I search for that vendor id further in the code, I see that it gets
patched as ALC662?

    HDA_CODEC_ENTRY(0x10ec0670, "ALC670", patch_alc662),

At the same time the documentation in models.rst lists those numbers
together:

ALC66x/67x/892

I already looked at the hda-audio specification from Intel to get a general
understanding, but I was also pulling some Realtek specs which do describe
implemented verbs and things like that (my hope was to see something
vendor related which could hint me how to enable the subwoofer).

I was not able to find any 669 Realtek datasheets, I did however find
the ones for ALC665 and ALC892. How specific is all of this, i.e. should I
keep looking for the exact one or am I on the wrong path here?

Kind regards,
Jin
