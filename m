From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2] Add M2Tech hiFace USB-SPDIF driver
Date: Fri, 22 Feb 2013 14:31:26 +0100
Message-ID: <20130222143126.68267a07cd55a405133bb56a@studenti.unina.it>
References: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
 <1360775505-13106-1-git-send-email-ao2@amarulasolutions.com>
 <20130222114832.c37bd43cf284944a7dbb8752@studenti.unina.it>
 <s5hvc9kecix.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp208.alice.it (smtp208.alice.it [82.57.200.104])
 by alsa0.perex.cz (Postfix) with ESMTP id 7730A2617AA
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2013 14:31:44 +0100 (CET)
In-Reply-To: <s5hvc9kecix.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, fchecconi@gmail.com, Pietro Cipriano <p.cipriano@m2tech.biz>, alberto@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 22 Feb 2013 13:52:38 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 22 Feb 2013 11:48:32 +0100,
> Antonio Ospite wrote:
> > 
> > On Wed, 13 Feb 2013 18:11:45 +0100
> > Antonio Ospite <ao2@amarulasolutions.com> wrote:
> > 
> > > Add driver for M2Tech hiFace USB-SPDIF interface and compatible devices.
> > > 
> > > M2Tech hiFace and compatible devices offer a Hi-End S/PDIF Output
> > > Interface, see http://www.m2tech.biz/hiface.html
> > > 
> > > The supported products are:
> > > 
> > >   * M2Tech Young
> > >   * M2Tech hiFace
> > >   * M2Tech North Star
> > >   * M2Tech W4S Young
> > >   * M2Tech Corrson
> > >   * M2Tech AUDIA
> > >   * M2Tech SL Audio
> > >   * M2Tech Empirical
> > >   * M2Tech Rockna
> > >   * M2Tech Pathos
> > >   * M2Tech Metronome
> > >   * M2Tech CAD
> > >   * M2Tech Audio Esclusive
> > >   * M2Tech Rotel
> > >   * M2Tech Eeaudio
> > >   * The Chord Company CHORD
> > >   * AVA Group A/S Vitus
> > > 
> > > Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
> > > ---
> > > 
> > > Changes since v1:
> > > 
> > >   * Change the first sentence of the Kconfig entry into "Select this..."
> > >   * Remove a useless sentence from the Kconfig entry
> > >   * Don't set alsa_rt->hw.rates in hiface_pcm_open()
> > >   * Style cleanup, no braces needed in single statement conditional
> > >   * Remove the rate field from pcm_runtime
> > >   * Use the hiFace name with the lowercase 'h' everywhere
> > >   * List actually supported devices in MODULE_SUPPORTED_DEVICE()
> > >   * Cosmetics, align values in the rates array
> > >   * Use an explicit switch instead of the rate_value array in
> > >     hiface_pcm_set_rate()
> > >   * Use usb_make_path() when building card->longname
> > >   * Use again the implicit mechanism to allocate the card private data
> > >   * Downgrade a pr_info to pr_debug in hiface_chip_probe()
> > >   * Make device_table const
> > >   * Rename PCM_MAX_PACKET_SIZE to PCM_PACKET_SIZE
> > >   * Rename MAX_BUFSIZE to PCM_BUFFER_SIZE
> > >   * Cosmetics, align symbolic constant values
> > >   * Add SNDRV_PCM_RATE_KNOT only when needed
> > >   * Declare memcpy_swahw32() as static
> > >   * Protect snd_pcm_stop() with snd_pcm_stream_lock_irq()
> > >   * Make hiface_pcm_playback() not returning anything
> > >   * Move the period elapsed check into hiface_pcm_playback()
> > >   * Handle the case of failing URBs in hiface_pcm_out_urb_handler()
> > >   * Fix a couple of checkpatch.pl issues
> > > 
> > > The incremental changes can be seen individually at
> > > https://github.com/panicking/snd-usb-asyncaudio/commits/master
> > > Commits from Feb. 10th and later.
> > >
> > 
> > Ping.
> > 
> > Hi, I don't see this one in:
> > http://git.kernel.org/?p=linux/kernel/git/tiwai/sound.git
> > 
> > If the code is OK, are we still in time for 3.9?
> 
> Sorry, I haven't reviewed the code yet (since I thought Clemens would
> re-review at first :)  I'm inclined to merge only fix patches at this
> point for 3.9, so the merge will be postponed to 3.10.
> 
> I'll take a look at the v2 patch.
> 

Thanks Takashi,

I'll reply to your review in the next days, since we are now targeting
3.10 I'll take some more time to think about your comments.

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
