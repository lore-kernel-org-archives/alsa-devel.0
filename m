From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Problem with buffer/period sizes.
Date: Sun, 12 Oct 2003 14:37:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F895936.8000707@superbug.demon.co.uk>
References: <3F8829C1.10302@superbug.demon.co.uk> <Pine.LNX.4.53.0310121049320.6682@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0310121049320.6682@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Sat, 11 Oct 2003, James Courtier-Dutton wrote:
> 
> 
>>I have code that looks like the following: -
>>
>>err = snd_pcm_hw_params_get_buffer_size_min(params, &buffer_size_min);
>>err = snd_pcm_hw_params_get_buffer_size_max(params, &buffer_size_max);
>>dir=0;
>>err = snd_pcm_hw_params_get_period_size_min(params, &period_size_min,&dir);
>>dir=0;
>>err = snd_pcm_hw_params_get_period_size_max(params, &period_size_max,&dir);
>>
>><snip> some calculations happen here
>>
>>err = snd_pcm_hw_params_set_buffer_size_near(audio_fd, params,
>>&buffer_size);
>>dir=0;
>>err = snd_pcm_hw_params_set_period_size_near(audio_fd, params,
>>&period_size, &dir);
>>
>>For a snd_intel8x0 driver with INTEL ICH5 chip with
>>PCI IDs of 0x8086, 0x24d5
>>Displays: -
>>buffer_size_min/max = 64 / 16384
>>period_size_min/max = 16 / 16384
>>
>>We then try to set: -
>>buffer_size = 16384
>>period_size =  2048
>>And it accepts those settings, and works.
>>
>>For a snd_intel8x0 driver with NVIDIA NFORCE chip with
>>PCI IDs of 0x10de, 0x01b1
>>Displays: -
>>buffer_size_min/max = 67 / 15052
>>period_size_min/max =  7 / 15053
>>
>>We then try to set: -
>>buffer_size = 15048
>>period_size =  1881
>>But, this sets a period size = buffer_size = 15048 which then fails to
>>work due to not having 2 periods or more.
>>
>>What is causing the NFORCE chip to suggest such strange values, and then
>>to not accept those values.
> 
> 
> It appears that the NFORCE chip is clocked with 44.1kHz. Thus alsa-lib is
> trying to do the resampling from 44.1kHz to 48kHz. Unfortunately, we're
> fighting with some rounding errors so that we cannot guarantee that all
> hw parameter combinations will work.
> 
> Because this situation is quite common for cheap motherboards where the
> hardware engineers are so clever to spare one clock crystal thus make the
> audio chips work with absolutely non-standard frequencies, I suggest to
> find a working combination of values and use it as last resort.
> 
> Note that we will solve these hardware dependand things with the new
> "ordinary" PCM. We will guarantee that you'll have always working
> setup for given hardware there.
> 
> 						Jaroslav
> 
Thanks. In the mean time, I found a solution be reversing the order in 
which I set period and buffer sizes, setting period size first, as 
suggested by yourselves in previous mailing list items.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
