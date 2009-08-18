From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: Using 8bit mono at 8000Hz with arecord and aplay
Date: Tue, 18 Aug 2009 12:00:08 +0200
Message-ID: <4A8A7BA8.9050906@gmail.com>
References: <33A0EEB8D50198449794A1AB9DEB1E0186642A95DC@copuex01.coreobjects.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from netfinity.tbmn.org (mail.tbmn.org [88.117.197.126])
	by alsa0.perex.cz (Postfix) with ESMTP id 820C724400
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 12:00:21 +0200 (CEST)
In-Reply-To: <33A0EEB8D50198449794A1AB9DEB1E0186642A95DC@copuex01.coreobjects.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shilpa Kedar Walvekar <shilpa.walvekar@coreobjects.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Shilpa Kedar Walvekar wrote:
> Hello,
> 
> We tried to record and play the recorded file using arecord and aplay as follows:
> arecord -f cd /home/test.wav
> aplay -f cd /home/test.wav
> 
> The file gets recorded and played correctly.
> 
> But if I try to record file of format S8 or U8, I get error:
> 
> # arecord -f U8 /home/test_alsa_record_2
> Recording WAVE '/home/test_alsa_record_2' : Unsigned 8 bit, Rate 8000 Hz, Mono
> arecord: set_params:979: Sample format non available
> 
> # arecord -f S8 /home/alsa_record_2
> Recording WAVE '/home/alsa_record_2' : Signed 8 bit, Rate 8000 Hz, Mono
> arecord: set_params:979: Sample format non available
> 
> Is there any other way to set the format as S8 or U8? Or only cd/cdr/dat formats can be played using alsa?

Basically it should be possible to play these formats.
If you look at the aplay help output, it also lists the recognized
sample formats (which include U8 and S8).

However, it also says "Some of these may not be available on selected
hardware".

For this reason I assume that your hardware (or at least the driver)
does not support these formats.

A workaround is to use one of the ALSA format conversion plugins.
(see here: http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html)

Specifically have a look at the rate or plug plugin.

The idea is that you can play arbitrary formats and the plugin
automatically converts the PCM streams to a fixed format that your
hardware can deal with (e.g. 16 bit at 48 kHz).

cheers,
stefan
