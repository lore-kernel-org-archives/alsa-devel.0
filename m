From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Pull request for alsa-plugins
Date: Wed, 3 Sep 2008 21:17:41 +0200
Message-ID: <20080903191741.GA13536@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id F38E3244F4
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Sep 2008 21:17:41 +0200 (CEST)
Content-Disposition: inline
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

Takashi, Jaroslav,

please pull and merge a series of 26 patches for alsa-plugins'
PulseAudio driver which I prepared in this repository of mine:

    git://git.0pointer.de/alsa-plugins.git

gitweb is here:

    http://git.0pointer.de/?p=alsa-plugins.git

There are quite a few bug fixes and feature enhancements among those
patches. It also includes some clean-ups in the coding
style. i.e. previously the indenting of the PA driver was pure chaos,
every single patch seemed to introduce a new indentation width. The
first patch in this series simply reindents the driver to Linux
style. All other patches are on top of that one.

Here's the shortlog:

Lennart Poettering (26):
      Reindent to Linux kernel style
      Add Emacs-style /*-*- linux-c -*-*/ header comment
      Make pulse_new() a proper C function
      Don't modify the SIGPIPE handler
      Call pa_context_disconnect() explicitly
      use SNDERR instead of fprintf to print error messages
      Support S32 sample types
      Add trailing NUL character to snprintf output
      Get rid of pulse_poll_revents()
      Add more error checking
      Remove fix for bug 0003470
      Rework hardware parameter selection
      A bag of minor clean ups for ctl_pulse.c
      Make pulse_ext_callback const
      Drop our own implementation of the poll() callbacks
      A bag of minor clean-ups for pulse.c
      Split out O_NONBLOCK setting into seperate function
      Save a byte of memory
      Adjust buffering metrics to match what PA internally uses
      Make sure we always have a sensible channel mapping
      Use PA_STREAM_EARLY_REQUESTS if available
      Use S32/FLOAT32 only where available in the PA libs
      Add const to our snd_pcm_ioplug_callback_t instances
      Don't implement our own poll handlers, we can use the default
      ones
      Remove our own poll handler implementation entirely
      A bag of clean-ups for pcm_ctl.c

Those patches only touch the pulse/ subdir. 

The tree is freshly rebased against current alsa-plugins master.

May I ask you to make me the "semi-official" maintainer of this
driver? I.e. I'd like to be consulted (as in 'Signed-Off-by') before
any patches for it are merged?

If requested I can also mail this as series of 26 seperate patches.

Thank you,

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
