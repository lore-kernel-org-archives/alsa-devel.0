From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Clock Drift between hardware sound card and
 snd_aloop
Date: Wed, 12 Jul 2017 08:43:08 +0200
Message-ID: <6b74985c-d550-42f8-f76f-8df826d16503@ladisch.de>
References: <CALAeOVN7aFT36peds7ML4B2i0s-gpKz8L+_fAi8ud4MRzyRM-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D88A266B7E
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 08:43:11 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 965385581A30
 for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2017 08:43:10 +0200 (CEST)
In-Reply-To: <CALAeOVN7aFT36peds7ML4B2i0s-gpKz8L+_fAi8ud4MRzyRM-Q@mail.gmail.com>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Rob Nertney wrote:
> I have successfully built a sound capture card that runs at a given rate
> off its own clock. I receive the stream and do some post-processing on it,
> and I want to present this modified data to the user as a capture pcm.

Then you probably want to create an external filter plugin:
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_external_plugins.html

> I initially thought that snd_aloop would be the best idea, as I can pipe my
> post-processed data directly into it. However, the driver is apparently
> calculating exact timing of what "should" be the rate based off of CPU
> ticks/jiffies and the requested period/sample rate/etc in the requested
> output stream.

Yes; the timing is not synchronized with any other sound card.


Regards,
Clemens
