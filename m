From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack plugin attempt
Date: Fri, 7 Feb 2003 11:39:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030207113906.51fd8d58.mdeboer@iua.upf.es>
References: <20030206115419.457ff99c.mdeboer@iua.upf.es>
	<Pine.LNX.4.44.0302061907410.4131-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0302061907410.4131-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org


> Please, see to refine code in pcm_dmix.c. You cannot do it with your way. 
> The refine means that it reduces given configuration and if no valid 
> configuration for given parameter exists, then the result value has to be 
> empty (or not set).

Okay, so, where I tried to do something like (not complete code)

	snd_pcm_format_mask_t format_mask = { SND_PCM_FMTBIT_FLOAT };
	snd_pcm_format_mask_t access_mask;
	err = _snd_pcm_hw_param_set_mask(params, SND_PCM_HW_PARAM_FORMAT,
					 &format_mask);
	snd_pcm_access_mask_none(&access_mask);
	snd_pcm_access_mask_set(&access_mask, SND_PCM_ACCESS_MMAP_INTERLEAVED);
	snd_pcm_access_mask_set(&access_mask, SND_PCM_ACCESS_MMAP_NONINTERLEAVED);
	err = _snd_pcm_hw_param_set_mask(params, SND_PCM_HW_PARAM_ACCESS,
					 &access_mask);
	err = _snd_pcm_hw_param_set_minmax(params, SND_PCM_HW_PARAM_RATE,
					   44100, 0, 
					   44100, 1);

(which does seem to work though!)

I should do something like:

	static snd_mask_t access = { .bits = { 
					(1<<SNDRV_PCM_ACCESS_MMAP_INTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_MMAP_NONINTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_RW_INTERLEAVED) |
					(1<<SNDRV_PCM_ACCESS_RW_NONINTERLEAVED),
					0, 0, 0 } };

	snd_interval_t t;

	snd_pcm_format_mask_t format_mask = { SND_PCM_FMTBIT_FLOAT };

	t.openmin = 0;
	t.openmax = 0;
	t.empty = 0;
	t.integer = 1;
	t.min = 44100;
	t.max = 44100;

	snd_mask_refine(hw_param_mask(params, SND_PCM_HW_PARAM_ACCESS), &access);
	snd_mask_refine(hw_param_mask(params, SND_PCM_HW_PARAM_FORMAT),&format_mask);
	snd_interval_refine(hw_param_interval(params,SND_PCM_HW_PARAM_RATE),&t);

? 

This doesn't work for the rate though:

aplay: interval_inline.h:79: snd_interval_max: Assertion `!snd_interval_empty(i)' failed

What am I doing wrong?

What I have now working is a plugin the has no slave and that writes the data to file (later
this will be jack, now it's just for testing), in refined the format and rate.

Maarten


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
