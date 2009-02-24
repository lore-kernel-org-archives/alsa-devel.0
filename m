From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Timer instability
Date: Tue, 24 Feb 2009 04:21:40 +0100
Message-ID: <20090224032140.GA17705@tango.0pointer.de>
References: <20090219024611.GA7930@tango.0pointer.de>
	<s5hy6w2hqap.wl%tiwai@suse.de>
	<20090220012220.GA11526@tango.0pointer.de>
	<s5h1vtty3f8.wl%tiwai@suse.de>
	<20090220203417.GA19093@tango.0pointer.de>
	<s5hhc2nu4qy.wl%tiwai@suse.de>
	<20090222031453.GA24365@tango.0pointer.de>
	<20090223024233.GA1901@tango.0pointer.de>
	<20090223025610.GA7062@tango.0pointer.de>
	<20090223192045.GA19543@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 75487244BB
	for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2009 04:21:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090223192045.GA19543@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Mon, 23.02.09 20:20, Lennart Poettering (mznyfn@0pointer.de) wrote:

> On Mon, 23.02.09 03:56, Lennart Poettering (mznyfn@0pointer.de) wrote:
> 
> > Hmm, for now my little testing experiment I've now found es1969,
> > ens1371, intel8x0, snd-emu10k1 and some intel-hda to have unreliable
> > _avail() or _delay().
> 
> And here's the output for HDA STAC92xx:
> 
> http://pastebin.mandriva.com/7149
> 
> The first dump is the interesting one: when audio starts to play the
> buffer abruptly runs empty in just 20us after the device started. (The
> rightmost column is the state btw, 3 == playing).
> 
> A quick overview of cards where _delay() and/or _avail() are unreliable:
> 
>  es1969
>  ens1371
>  intel8x0
>  emu10k1
>  intel-hda on STAC92xx
>  intel-hda on AD1989B

And here's another one, for intel-hda on ALC883:

Sometimes snd_pcm_avail() returns values like 4611686018427387098.

Smells like another overflow to me. 

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
