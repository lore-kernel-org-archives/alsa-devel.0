From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: pcm_jack plugin attempt
Date: Thu, 6 Feb 2003 19:14:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0302061907410.4131-100000@pnote.perex-int.cz>
References: <20030206115419.457ff99c.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030206115419.457ff99c.mdeboer@iua.upf.es>
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

On Thu, 6 Feb 2003, Maarten de Boer wrote:

> Thanks for your reply.
> 
> > > As far as I understand, the easiest solution would be to have a pcm_plug
> > > plugin inbetween the alsa application and the pcm_jack plugin, to take
> > > care of sample rate and data format conversion. Then the pcm_jack plugin
> > > simply restrict it configuration space to the sample rate and data format
> > > (float) supplied by the jack server. Is this the right approach? Then,
> > 
> > Yep.
> 
> Okay, good to know I am on the right track. Now, as a first step, I thought
> I'd restrict myself to simple read/write (interleaved and non-interleaved)
> access, and mmap would come later. But if I set the access mask in my
> snd_pcm_jack_hw_refine to
> 
> snd_pcm_access_mask_set(&access_mask, SND_PCM_ACCESS_RW_INTERLEAVED);
> snd_pcm_access_mask_set(&access_mask, SND_PCM_ACCESS_RW_NONINTERLEAVED);
> 
> then the pcm_plug fails
> 
> ALSA lib pcm_plug.c:714:(snd_pcm_plug_hw_refine_schange) Unable to find
> an usable access for 'myplug'
> 
> Even though from the application I request non-mmap access (aplay), the
> plug plugin apparently requieres mmap access from it's slave. Is this
> correct?

Please, see to refine code in pcm_dmix.c. You cannot do it with your way. 
The refine means that it reduces given configuration and if no valid 
configuration for given parameter exists, then the result value has to be 
empty (or not set).

> If I do use mmap, a shmid is obtained from the pcm_jack plugin through
> the channel_info op. I looked at pcm_null, where the shmid is 
> set in the mmap op, but when I try to use the some construction, I run
> into problems, because (as in pcm_null.c:729)
> 
> 	if (!(pcm->info & SND_PCM_INFO_MMAP)) {
> 
> is false, so the shmid is not set, so after passing through
> snd_pcm_jack_mmap and  snd_pcm_jack_channel_info, I get a 
> ALSA lib pcm_mmap.c:367:(snd_pcm_mmap) shmat failed: Identifier removed
> 
> I don't understand how this works in pcm_null... Is the mmap op the correct
> place to set the shmid? And how come the channel_info op is called when 
> appearently we are using mmap?

The pcm_null ring buffer is allocated in pcm_mmap.c (snd_pcm_mmap 
function), because snd_pcm_null_channel_info function returns 
value snd_pcm_channel_info_shm(pcm, info, -1) where -1 means "allocate 
private shm ring buffer".

> > > what would be the right place to do this? In the hw_refine or in the
> > > hw_param function? Or somewhere else even? And how - what _snd_pcm helper
> > > functions should I best use?
> > 
> > Well, I think that it needs a bit deeper introduction to the alsa-lib 
> > plugin system. I'm actually working on dmix plugin and facing with same 
> > problems.
> 
> Yes... But there is no documentation that describes that plugin system
> internals, right?

Yes, that's true. I'm ready to answer all questions.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
