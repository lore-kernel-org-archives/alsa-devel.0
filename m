From: cuhl@eit.uni-kl.de
Subject: Fixed latency between multiple channels
Date: Wed, 23 Aug 2017 15:25:22 +0200
Message-ID: <be709368c93d9e0c7b13f52b0e75ac83.squirrel@postamt.eit.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw1.uni-kl.de (mailgw1.uni-kl.de [131.246.120.220])
 by alsa0.perex.cz (Postfix) with ESMTP id 72F0E2664EB
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 15:25:22 +0200 (CEST)
Received: from postamt.eit.uni-kl.de (postamt.eit.uni-kl.de [131.246.73.100])
 by mailgw1.uni-kl.de (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id
 v7NDPNdu026207
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 15:25:23 +0200
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
Cc: cuhl@eit.uni-kl.de
List-Id: alsa-devel@alsa-project.org

Hello Alsa-Developers,

currently I try to decide, if ALSA is useable for a certain multi-channel
signal processing task.
I've read, that even with a realtime kernel the input-output latency
varies with time - especially if USB is inbetween.
Even so this is not what I actually want, I think the application might be
sufficiently robust against this. However I expect to require a fixed
latency between multiple ( I2S ) channels. This shall include stereo, but
extend to all channels ( between 6 to 12 mono / 3 to 6 srereo channels
probably ). So every channel's signal shall be exactly determined to its
relative position with respect to the other channels, e. g. it shall be
known inside the system which events occured simultanously.

Likewise, the processed or generated signals shall be transferred to the
outputs in a way, that they occur there with intended and modifiable
relative latency to each other.

Is this ensured by the ALSA architecture or is it at least possible to
ensure  it, if it is used?

Any comments or answers are appreciated.

Kind regards

Christian
