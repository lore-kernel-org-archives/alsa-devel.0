From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: pcm_plug.c:882: snd_pcm_plug_hw_params: Assertion `err >= 0' failed.
Date: Thu, 1 Jan 2004 19:40:20 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040102004020.GA27227@zewt.org>
References: <20031224003200.GB25270@zewt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20031224003200.GB25270@zewt.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 23, 2003 at 07:32:00PM -0500, Glenn Maynard wrote:
> The attached program results in:
> 
> ./a.out
> a.out: pcm_plug.c:882: snd_pcm_plug_hw_params: Assertion `err >= 0' failed.
> zsh: 22948 abort      ./a.out
> 
> This is with CVS alsa-utils (and 0.9.6 or 0.9.8), whatever is in 2.6.0 test9,
> and an SBLive.  It goes away if the sample rate block is uncommented.

I've tested this on a different machine; it's happening on both
snd_intel8x0 and snd_emu10k1, with 2.6.0 (final) and current CVS
alsa-lib.

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
