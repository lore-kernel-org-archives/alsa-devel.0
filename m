From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm_jack plugin attempt
Date: Mon, 10 Feb 2003 20:26:39 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302102017260.2505-100000@pnote.perex-int.cz>
References: <20030210180156.438c4321.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030210180156.438c4321.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 10 Feb 2003, Maarten de Boer wrote:

> > There was a problem with refine code for pcm_plug, please, try again with 
> > latest CVS sources. Also, look to updated pcm_dmix plugin for implementing 
> > the "right" refine function.
> 
> Okay, this works fine now.
> 
> I am trying to do the following, using the mmap functionality. Let's
> start with playback.
> 
> As I understand, I can simple do a snd_pcm_mmap_hw_forward(pcm, size) in
> my snd_pcm_jack_mmap_commit op. Then, in the jack process callback, I

Nope. The snd_pcm_mmap_appl_forward(pcm, size) is the appropriate.

> can copy data from the areas = snd_pcm_mmap_areas(pcm) to the jack

Right.

> callback buffer. For this, I use the appl_ptr as the offset in the
> mmap_areas, and snd_pcm_mmap_appl_forward(pcm,n_jack_frames); to
> increase the appl_ptr. Said differently, I use the hw_ptr as the write
> index, and the appl_ptr as the read index. Is this approach correct?

I think that it should be opposite:

appl_ptr should be increased when application writes samples (commit) and
hw_ptr should be increased when jack callback processes samples

> Now, my problem is: how should I calculate the value returned my
> snd_pcm_jack_avail_update ? There are a lot of helper functions
> (mmap_avail, mmap_hw_avail, mmap_playback_avail, etc), which I suppose
> are ment for tasks like this, but I don't really understand how. I'm
> particularly confused my buffer_size vs boundary... Could you help me
> out with this?

I think that snd_pcm_mmap_avail() is ok. The boundary is a wrapper limit 
for the pointers. The pointer (appl_ptr or hw_ptr) is defined as offset in 
the ring buffer plus count of interrupts multiple the ring buffer size.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
