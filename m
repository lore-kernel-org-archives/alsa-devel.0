From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: USB MIDI Regression? - - Was: Small Regression in
 midi for M-Audio Fast Track Ultra.
Date: Mon, 18 Apr 2011 10:37:51 +0200
Message-ID: <4DABF85F.1040408@showlabor.de>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 380BF10380C
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Apr 2011 10:37:54 +0200 (CEST)
In-Reply-To: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>
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

Hi,

Am 16.04.2011 04:29, schrieb Grant Diffey:
> In 2.6.33/34 when support originally was put in alsa mainline the MIDI ports
> were functional today they're not for me and I get the following in the
> kernel log when using this card. (Audio all works acceptably.)

I can confirm Grant's issue.

They are not related to any code specific to the M-Audio Fast Track 
Ultra (FTU) series:

Even after removing the FTU patches from current ALSA (git) the MIDI 
ports of the device will not be recognized.

Switching back to my oldest installed kernel (2.6.32) the FTU will be 
recognized as a MIDI interface (but as expected the PCM ports will not 
be recognized.)

Just to make sure, that I'm not missing anything:

* I've used 'amidi - l' to look for MIDI ports
* Due to the deprecation of OSS in the kernel my Alsa configure line now 
includes '--with-oss=no --with-pcm-oss-plugins=no' which shouldn't have 
an effect but I mention it anyway

Any ideas?

Regards,

Felix
