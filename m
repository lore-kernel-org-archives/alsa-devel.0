From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: ALSA API as standards
Date: Fri, 30 Nov 2007 08:34:00 +0100
Message-ID: <1196408040.2130.1224047259@webmail.messagingengine.com>
References: <s5h3auzwof5.wl%tiwai@suse.de> <s5hy7cprp01.wl%tiwai@suse.de>
	<20071129205523.GA11372@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 26FA824549
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 08:34:02 +0100 (CET)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EF74050403
	for <alsa-devel@alsa-project.org>; Fri, 30 Nov 2007 02:34:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20071129205523.GA11372@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lennart Poettering wrote:
> Just a few random comments:
> 
> > /* I/O */
> > 
> > snd_input_stdio_open
> > snd_input_stdio_attach
> > snd_input_buffer_open
> > snd_input_close
> > snd_input_scanf
> > snd_input_gets
> > snd_input_getc
> > snd_input_ungetc
> > 
> > snd_output_stdio_open
> > snd_output_stdio_attach
> > snd_output_buffer_open
> > snd_output_buffer_string
> > snd_output_close
> > snd_output_printf
> > snd_output_vprintf
> > snd_output_puts
> > snd_output_putc
> > snd_output_flush
> 
> May I ask why these are exported at all? The seem to be some kind of
> STDOUT/STDIN abstraction, and have no place in a sound API I would
> say. Especially not in any "standardized" version of it.

The configuration code uses these functions to read and write .conf
files.

It might be useful for an application to have some private ALSA config
and to let ALSA read it from a file or from a string, but I don't think
this is something that belongs in LSB.

> > snd_pcm_dump
> > snd_pcm_dump_hw_setup
> > snd_pcm_dump_sw_setup
> > snd_pcm_dump_setup
> > snd_pcm_hw_params_dump
> > snd_pcm_sw_params_dump
> > snd_pcm_status_dump
> 
> And these? They are not even documented, or am I blind?

Well, their documentation isn't less useful than that of most other
functions.  ;-(

These functions are very valuable when debugging.  I wouldn't want to
discourage anybody from using them.

If we include these functions, we'll have to include some of the
snd_output_* functions.


Regards,
Clemens
