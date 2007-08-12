From: LCID Fire <lcid-fire@gmx.net>
Subject: Alsa principles
Date: Sun, 12 Aug 2007 22:44:06 +0200
Message-ID: <46BF7116.7070408@gmx.net>
References: <8e4fc8270708111546k328a0575h9e362ee01a2917ec@mail.gmail.com>
	<200708121502.09106.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id B1544103844
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Aug 2007 22:44:49 +0200 (CEST)
In-Reply-To: <200708121502.09106.linux@audioscience.com>
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

Programming alsa is confusing at the point that there is basicly no
documentation. So since I get more and more confused I hope someone can
help me out here.

First - I didn't find any complete description about interleaved and
non-interleaved transport. What is actually (in a nutshell) the
difference and what the consequences of either approach?

Second - when capturing I do the following:

snd_pcm_hw_params_set_format:
So this is setting some kind of format!? I mean first off - which format
should one set? There are a few dozens to choose from and the hardware
will most likely not support all of them. So how does one retrieve a
list of the hardware supported formats? And which one should be
considered superior? I assume it does affect the buffer size eventually
needed!?

snd_pcm_hw_params_get_channels_max:
This one should IMO output the channels - but for a capture device
(where often there is just a single stereo input) this would normally
just return 2, right?

snd_pcm_hw_params_set_channels:
This is pretty self explanatory - aside from the effect this one has.
Eventually there will be gotten some data via a buffer. Would there be 6
channels (dolby stuff) does a filled buffer look like the following?

Channel1
Channel2
Channel3
Channel4
Channel5
Channel6
Channel1
Channel2
.
.
.

snd_pcm_hw_params_set_rate:
This one is also pretty self explanatory - aside from pure digital
devices - which I'm lucky not to have.

snd_pcm_hw_params_set_periods:
And we are at the REAL confusing stuff. Here one can set "periods". But
what is meant by a period? Is it a frame or how would sane people call
this? And there's a count of periods set - what is this count used for?

snd_pcm_hw_params_get_period_size:
Ok from the previous periods I can get the size. I assume this is
somewhat usefull to estimate the buffer size but since I don't know
exactly what periods are or do - I dunno.

snd_pcm_hw_params_set_buffer_size:
This one sets the buffer size. I'm kind of confused here because you
have to set the periods AND the buffer size. So are the periods just the
slices for the buffer? So I think the buffer can be calculated as
following!?:

<periods> * <periodSize> * <formatTypeWTF> * <channels>
So is the buffer size the actual byte size, a frame size the period size
or whatever?

snd_pcm_readi:
Since the buffer is a void* I assume that the format does affect the
data needed for the buffer. But having a buffer in userspace and a
buffer set in alsa means it does copy at least twice. I fear for direct
copying one has to get in touch with this mmap method nobody wants to
talk about :(

If you read to this point thank you ;)
