From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: snd_pcm_poll_descriptors() error return
Date: Tue, 2 Oct 2018 08:32:10 +0900
Message-ID: <c078e4c7-68a0-62d8-5df4-2d687efafbc8@sakamocchi.jp>
References: <201810012223.09054.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EBAB2676A7
 for <alsa-devel@alsa-project.org>; Tue,  2 Oct 2018 01:32:14 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id c10-v6so71294pgq.4
 for <alsa-devel@alsa-project.org>; Mon, 01 Oct 2018 16:32:14 -0700 (PDT)
In-Reply-To: <201810012223.09054.gineera@aspect135.co.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Oct 02 2018 06:23, Alan Horstmann wrote:
> A user of the Portaudio library is reporting that from Alsa version 1.1.4 the
> function snd_pcm_poll_descriptors() can return -32 (Broken Pipe), and this
> fails an assert within Portaudio.  Earlier 1.1.3 does not seem to  show this
> issue.  For more details, see
> https://app.assembla.com/spaces/portaudio/support/tickets/268.
> 
> The Alsa docs don't mention any possible negative error code from this
> function - has the behaviour changed, or is it likely something else is
> triggering the difference?

Return values from a call of 'snd_pcm_poll_descriptors()' varies
depending on implementation of PCM plugins for used PCM node. Therefore
it's impossible to cover all of the values in documentation.

In a design of alsa-lib, 'snd_pcm_poll_descriptors()' is a thin wrapper
of '.poll_descriptors' callback of internal/external structure of PCM
plugins, therefore its behaviour is dynamically different depending on
each implementation.

For example, when using 'hw' PCM node directly, a call of this function
can returns '-ENOMEM' or '2':
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_hw.c;h=59a242009e9f5f1098759305499eaa27bef6c1ab;hb=HEAD#l227

When using 'dmix' PCM node, '-EIO', '0', '-EPIPE' and '1':
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_direct.c;h=2b07eff90ff6e12200e27a0d40378f29a7bf0d24;hb=HEAD#l668

When using PCM node with external PCM plugins such as 'pulse',
'snd_pcm_ioplug_create()' is called to instantiate plugin structure,
and a call of 'snd_pcm_poll_descriptors()' can return '-EIO', '0', '1',
and value depending on plugin implementation.
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm_ioplug.c;h=881a1a85adaf09b4732375e2161b0a1ebb53900f;hb=HEAD#l772

When having good discussion to investigate cause, discover solution for
this kind of issues, you need to identify which PCM node triggers the
issue, at least.


Regards

Takashi Sakamoto
