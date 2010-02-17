From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: What is the required accuracy of audio sampling
	rate?
Date: Tue, 16 Feb 2010 21:08:15 -0600
Message-ID: <6160a5131002161908m7c5278fas1291fbd50956f300@mail.gmail.com>
References: <e5baf3861002161558x1d36f74anf63c5db145762668@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 415AB103832
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 04:08:17 +0100 (CET)
Received: by pzk36 with SMTP id 36so7813787pzk.23
	for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2010 19:08:15 -0800 (PST)
In-Reply-To: <e5baf3861002161558x1d36f74anf63c5db145762668@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Yiliang Bao <yiliangb@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> I have a PCI-e audio card that does not give very accurate sampling rate
> (about -0.2% error, i.e., if I set the sampling rate to 8K, I got only 7984
> samples per second on average). It caused various synchronization problems
> in applications like gstreamer.

Can you be more specific on your sync issues? Generally the audio
clock is used as reference, and video adjusts to it.

> Since there will be some difference from one clock domain to another, I am
> wondering if there is any defined tolerance on the sampling rate, and where
> the right place is to correct this kind of error. I would really appreciate
> if someone can point me to the related documents/links.

It really depends on the standard, and if you are slave or master.
Each standard has its own requirements. For example an AES-EBU
interface will require 10ppm for professional uses as a source, and
less as a sink. HDAudio requires the nominal BCLK 24MHz frequency to
be between 23.9976 and 24.0024 MHz. I don't think on an I2S link there
are such requirements, the frequency will depend on how accurate the
audio PLL is.
Note that the actual frequency is only one of the parameters
influencing audio quality, jitter issues are much worse. If your clock
is slightly off but remains stable, you are usually good. If it varies
you'll have real audible quality issues.
- Pierre
