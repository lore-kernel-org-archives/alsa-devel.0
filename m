From: Trent Reed <treed0803@gmail.com>
Subject: SND_PCM_STREAM_CAPTURE and SND_PCM_NONBLOCK producing
	strange artifacts
Date: Tue, 28 Jun 2016 19:27:25 -0700
Message-ID: <CAL6pMWpW4VMPkaeqUS3DaU4d+fUB2s1i9kpTPkfNPeNjW4gHpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com
 [209.85.216.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AD082605D3
 for <alsa-devel@alsa-project.org>; Wed, 29 Jun 2016 04:27:26 +0200 (CEST)
Received: by mail-qt0-f174.google.com with SMTP id c34so17995109qte.0
 for <alsa-devel@alsa-project.org>; Tue, 28 Jun 2016 19:27:26 -0700 (PDT)
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

Hey All,

I've been banging my head against the wall for about a week on this bug.
The following gist shows my sample reproduction code:
https://gist.github.com/TReed0803/985c5d5c3d295245e19006a27be447c3

I'm simply opening up a non-blocking PCM capture stream and writing the
contents of the reads to stdout.
(Originally, I was writing to the playback stream, but I was hearing this
strange static occasionally!)

It's the static I'm trying to debug. It doesn't happen every time. In fact,
sometimes I'll go a few consecutive executions without hearing it.
I was able to capture some of the bad data, and I loaded it up in Audacity
for visualization:
https://drive.google.com/file/d/0B-1aumGKQcQTcUJoZzIwRWhYSFE/view?usp=sharing

It looks like the internal buffer occasionally is sending me more data than
it actually captured, and I end up either reading old PCM data from the
internal ring buffer, or (at the very beginning) a bunch of zeros.

Can anyone help me understand what is going on? What could cause these
definitely incorrect samples to be recorded? (I get the same effect
regardless of hardware, but I will list hardware just in case.)

I hope I have all the information you might need:
Hardware: Samson Meteor Mic (USB-Audio, USB Mixer) [Though, it even happens
with my built-in microphone]
ALSA version: Advanced Linux Sound Architecture Driver Version
k4.4.0-28-generic.
apt-cache policy (installed alsa-lib version): 1.1.0-0ubuntu1

Thanks,
- Trent Reed
