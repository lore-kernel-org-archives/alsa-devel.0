From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: ALSA API as standards
Date: Thu, 29 Nov 2007 21:55:24 +0100
Message-ID: <20071129205523.GA11372@tango.0pointer.de>
References: <s5h3auzwof5.wl%tiwai@suse.de> <s5hy7cprp01.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id CC196244F8
	for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2007 21:55:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy7cprp01.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 23.11.07 15:54, Takashi Iwai (tiwai@suse.de) wrote:

Just a few random comments:

> /* I/O */
> 
> snd_input_stdio_open
> snd_input_stdio_attach
> snd_input_buffer_open
> snd_input_close
> snd_input_scanf
> snd_input_gets
> snd_input_getc
> snd_input_ungetc
> 
> snd_output_stdio_open
> snd_output_stdio_attach
> snd_output_buffer_open
> snd_output_buffer_string
> snd_output_close
> snd_output_printf
> snd_output_vprintf
> snd_output_puts
> snd_output_putc
> snd_output_flush

May I ask why these are exported at all? The seem to be some kind of
STDOUT/STDIN abstraction, and have no place in a sound API I would
say. Especially not in any "standardized" version of it.

> snd_config
[...]
> snd_config_iterator_entry

Same here, why does parsing config files of ALSA need to be part of
the audio API? I see no need for this.

> snd_pcm_dump
> snd_pcm_dump_hw_setup
> snd_pcm_dump_sw_setup
> snd_pcm_dump_setup
> snd_pcm_hw_params_dump
> snd_pcm_sw_params_dump
> snd_pcm_status_dump

And these? They are not even documented, or am I blind?

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
