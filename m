From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1 multichannel support
Date: Wed, 19 Jan 2005 11:59:26 -0500
Message-ID: <1106153966.3082.2.camel@krustophenia.net>
References: <200501191438.OAA11750@orthoset.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200501191438.OAA11750@orthoset.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: William <walsac3@orthoset.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2005-01-19 at 14:38 +0000, William wrote:
> Lee Revell wrote:
> >
> > As promised, here's an updated patch to add real multichannel playback
> > support (and improved multichannel capture) to the emu10k1 driver.
> > 
> > http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v001.patch
> > 
> > Please test it and report any problems.
> 
> I tested it on 2.6.10 with alsa 1.0.8 and have found what looks like
> a possible problem with the emu10k1 synth support.
> Soundfonts still load ok but despite mixer levels being ok
> ("Music=Master=...etc...=100%") there is no sound at all when using the
> emu10k1 wavetable synth, e.g. with aplaymidi.

Ok, found the bug.  snd_emu10k1_voice_alloc now takes the number of
voices as the third parameter, previously it took 1 or 0 depending on
whether 1 or 2 voices were needed.

Does this fix the problem?

Lee

Index: alsa-cvs/alsa-kernel/pci/emu10k1/emu10k1_callback.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/emu10k1/emu10k1_callback.c,v
retrieving revision 1.12
diff -u -r1.12 emu10k1_callback.c
--- alsa-cvs/alsa-kernel/pci/emu10k1/emu10k1_callback.c	29 Jun 2004 16:10:33 -0000	1.12
+++ alsa-cvs/alsa-kernel/pci/emu10k1/emu10k1_callback.c	19 Jan 2005 16:57:06 -0000
@@ -291,7 +291,7 @@
 			if (vp->ch < 0) {
 				/* allocate a voice */
 				emu10k1_voice_t *hwvoice;
-				if (snd_emu10k1_voice_alloc(hw, EMU10K1_SYNTH, 0, &hwvoice) < 0 || hwvoice == NULL)
+				if (snd_emu10k1_voice_alloc(hw, EMU10K1_SYNTH, 1, &hwvoice) < 0 || hwvoice == NULL)
 					continue;
 				vp->ch = hwvoice->number;
 				emu->num_voices++;





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
