From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: caiaq driver: audio 4 dj and jackd
Date: Sun, 01 Dec 2013 19:02:27 -0800
Message-ID: <529BF843.6000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A043B26165F
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 04:02:36 +0100 (CET)
Received: by mail-pd0-f178.google.com with SMTP id y10so16952774pdj.23
 for <alsa-devel@alsa-project.org>; Sun, 01 Dec 2013 19:02:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>, Daniel Mack <zonque@gmail.com>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org


Is it possible to make all 4 ins/outs in the Audio 4 DJ available 
through the first substream device?

A user was having trouble using the NI Audio 4 DJ device with jackd. 
When jack connected, this 4-in/4-out device would appear as 2-in/2-out. 
This was the result of the fact that the channels are split up into 
stereo substreams.  I.e. the first two channels are found in hw:x,0,0 
and the last two channels are in hw:x,0,1.

The work-around was to use the `multi' plug-in to make these 2 PCM's 
appear as a single PCM.

There's several situations where this is a Good Thing, because it makes 
it easy for the user to treat the streams independently.

BUT... in the pro-audio case this is not a good thing at all.

Ideally, substream 0 would support 1, 2, or 4 channels (for both 
playback and capture).  When substream 0 is using more than 2 channels, 
then substream 1 would return EBUSY when in use.

So... would it be possible to do this in the caiaq driver?

-gabriel
