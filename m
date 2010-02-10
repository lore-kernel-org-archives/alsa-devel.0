From: Donald Tournier <d.tournier@brain.org.au>
Subject: IEC958 / SPDIF raw capture
Date: Thu, 11 Feb 2010 10:14:35 +1100
Message-ID: <325dd9ac1002101514u73929570l51a12d28ecddd7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 86C0710382B
	for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2010 00:14:36 +0100 (CET)
Received: by ewy23 with SMTP id 23so198219ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2010 15:14:35 -0800 (PST)
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

We have an application in our institute that will require recording of
a digital signal via an optical cable. We have to be able to guarantee
perfect bitwise reproduction of the signal (the odd bit error is not a
problem). We're thinking of using SPDIF and ALSA to capture the signal
(obviously we'll have to make sure the signal is properly encoded to
begin with).

However, after some initial attempts, it's becoming clear that ALSA
can't necessarily guarantee bitwise perfect capture. ALSA might change
the format, or resample the signal after capture (although I've heard
that can be turned off with "snd_pcm_hw_params_set_rate_resample
(capture_handle, hw_params, 0)"). Also, the card that we've been
playing with so far (SB Audigy2 ZS) apparently performs some low-pass
digital filtering on the input stream anyway, and is therefore no use
to us.

So my question is: can this be done? Is there a way of setting up ALSA
to produce an unaltered version of the SPDIF input stream? This will
undoubtedly require a particular combination of hardware and driver.
If so, which card/driver would be recommended? Ideally, we would like
to capture the raw SPDIF subframes. Is that possible, and if so, how?

Any help would be greatly appreciated!
Thanks,

Donald.


-- 
Jacques-Donald Tournier (PhD)
Brain Research Institute, Melbourne, Australia
Tel: +61 (0)3 9496 4078
