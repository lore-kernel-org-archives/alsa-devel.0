From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Tests of the hda-jack branch
Date: Wed, 30 Nov 2011 10:43:37 +0800
Message-ID: <CAN8cciY42ifiBKQ1jDz76GHi0NeHNSgAD1KptuXedxfrgnd=YA@mail.gmail.com>
References: <4ED535CA.1080108@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A2DA010399B
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 03:43:39 +0100 (CET)
Received: by bkat8 with SMTP id t8so176078bka.38
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 18:43:38 -0800 (PST)
In-Reply-To: <4ED535CA.1080108@canonical.com>
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

2011/11/30 David Henningsson <david.henningsson@canonical.com>:
> Hi Takashi,
>
> I've done some more tests of your branch now, and the new names seems to
> work for my machine here.
>
> I'm attaching two patches - one adds a "device index" for mapping against
> pcm devices on HDMI, the other one is a backport for the driver-build tree.
>
> What are your thoughts on how to proceed, when do you think this is ready to
> be merged into the topic/hda branch?
>
> // David
>

http://git.alsa-project.org/?p=alsa-kernel.git;a=blob_plain;f=Documentation/sound/alsa/HD-Audio-Controls.txt

Does it handle "Independent HP" ?

VIA codecs
----------

* Independent HP
  When this enum control is enabled, the headphone output is routed
  from an individual stream (the third PCM such as hw:0,2) instead of
  the primary stream.  In the case the headphone DAC is shared with a
  side or a CLFE-channel DAC, the DAC is switched to the headphone
  automatically.

Analog codecs
--------------

* Independent HP
  When this enum control is enabled, the headphone output is routed
  from an individual stream (the third PCM such as hw:0,2) instead of
  the primary stream.
