From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: io_remap_page_range (was Re: [Alsa-devel] alsa-driver will
	not	compile with kernel  2.6.9-rc2-mm4-S7)
Date: Fri, 08 Oct 2004 15:23:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1097263396.1442.28.camel@krustophenia.net>
References: <1096675930.27818.74.camel@krustophenia.net>
	 <32868.192.168.1.8.1096677269.squirrel@192.168.1.8>
	 <1096678268.27818.84.camel@krustophenia.net> <s5hmzz2zeqn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S263770AbUJHTZz@vger.kernel.org>
In-Reply-To: <s5hmzz2zeqn.wl@alsa2.suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2004-10-04 at 11:26, Takashi Iwai wrote:
> At Fri, 01 Oct 2004 20:51:08 -0400,
> Lee Revell wrote:
> > 
> > On Fri, 2004-10-01 at 20:34, Rui Nuno Capela wrote:
> > > Lee Revell wrote:
> > > Good grief! I'm having this too, and I was desperate thinking I was the
> > > only one, and ultimately offering the blame to gcc 3.4.1 which is what I'm
> > > test-driving now on my laptop (Mdk 10.1c).
> > > 
> > > Now I remember that -mm4 has some issue about remap_page_range kernel
> > > symbol being renamed to something else, which is breaking the build of
> > > outsider modules (i.e. not the ones bundled under the kernel source tree).
> > > Or so it seems.
> > 
> > Looking through my archives I cannot find a report of this exact issue,
> > but you are probably right.  Looks like ALSA drivers need to be updated.
> 
> The alsa-kernel code there (pcm_native.c) is ok but the patch in
> alsa-driver looks broken for the recent change of remap_pfn_range().
> 
> Also, there was another API brekage about pci_save/restore_state().
> 
> Fixed both on CVS now.

I think this is still broken.  Same problem when I went to configure
ALSA for -mm3-T3.  The configure script gets
CONFIG_HAVE_OLD_REMAP_PAGE_RANGE wrong; I have the new version but
configure fails to detect it.

AFAICT the test in configure is a NOOP and
CONFIG_HAVE_OLD_REMAP_PAGE_RANGE always gets set to 1.

Lee
