From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Recording devices opened mono still sending stereo
 causing corrupt audio
Date: Fri, 11 Oct 2013 14:33:33 +0200
Message-ID: <5257F01D.3040908@ladisch.de>
References: <52575722.7060208@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2C4F6261A1B
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 14:33:36 +0200 (CEST)
In-Reply-To: <52575722.7060208@mixxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>, Portaudio Mailing List <portaudio@music.columbia.edu>, alsa-devel@alsa-project.org
Cc: mixxx-devel <mixxx-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Sean M. Pappalardo - D.J. Pegasus wrote:
> the problem occurs when PA is asked to open just one channel of
> a sound input device yet the device seems to stream two anyway.

Many devices do not support mono streams.

> I'm suspecting there's a miscommunication between PA and ALSA

The communication between ALSA and PA works just fine; ALSA reports the
minimum number of channels, and PA saves this value.

What does not work is the communication between PA and the application;
PA has no mechanism to report the minimum number of channels.

Even worse, if some application tries to use a channel count that is too
low, PA cleverly replaces it with the minimum support channel count:

  self->numHostChannels = PA_MAX( params->channelCount, StreamDirection_In == streamDir ? devInfo->minInputChannels
          : devInfo->minOutputChannels );

and then does not bother to tell anybody about this.

This bug is especially egregious because PA does later check whether the
number of channels is actually supported by the device; the code above
ensures that this checks uses the wrong channel number.


Regards,
Clemens
