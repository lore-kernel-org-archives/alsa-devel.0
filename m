From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Problem with buffer/period sizes.
Date: Sat, 11 Oct 2003 17:03:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8829C1.10302@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have code that looks like the following: -

err = snd_pcm_hw_params_get_buffer_size_min(params, &buffer_size_min);
err = snd_pcm_hw_params_get_buffer_size_max(params, &buffer_size_max);
dir=0;
err = snd_pcm_hw_params_get_period_size_min(params, &period_size_min,&dir);
dir=0;
err = snd_pcm_hw_params_get_period_size_max(params, &period_size_max,&dir);

<snip> some calculations happen here

err = snd_pcm_hw_params_set_buffer_size_near(audio_fd, params, 
&buffer_size);
dir=0;
err = snd_pcm_hw_params_set_period_size_near(audio_fd, params, 
&period_size, &dir);

For a snd_intel8x0 driver with INTEL ICH5 chip with
PCI IDs of 0x8086, 0x24d5
Displays: -
buffer_size_min/max = 64 / 16384
period_size_min/max = 16 / 16384

We then try to set: -
buffer_size = 16384
period_size =  2048
And it accepts those settings, and works.

For a snd_intel8x0 driver with NVIDIA NFORCE chip with
PCI IDs of 0x10de, 0x01b1
Displays: -
buffer_size_min/max = 67 / 15052
period_size_min/max =  7 / 15053

We then try to set: -
buffer_size = 15048
period_size =  1881
But, this sets a period size = buffer_size = 15048 which then fails to 
work due to not having 2 periods or more.

What is causing the NFORCE chip to suggest such strange values, and then 
to not accept those values.

Cheers
James



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
