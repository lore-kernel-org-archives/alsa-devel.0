From: Steven Wawryk <stevenw@acres.com.au>
Subject: Hopelessly confused by channel mapping
Date: Fri, 22 Jan 2016 20:00:20 +1030
Message-ID: <56A1F6AC.7050400@acres.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.acres.com.au (mail.acres.com.au [150.101.238.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 790FC260439
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 10:30:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by loki.acres.com.au (Postfix) with ESMTP id 7E74AC3509
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 20:00:26 +1030 (CST)
Received: from mail.acres.com.au ([127.0.0.1])
 by localhost (loki.acres.com.au [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DVeMEgg93sJu for <alsa-devel@alsa-project.org>;
 Fri, 22 Jan 2016 20:00:20 +1030 (CST)
Received: from [192.0.2.164] (krill.acres.com.au [192.0.2.164])
 by loki.acres.com.au (Postfix) with ESMTP id 8DEA9C29FC
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2016 20:00:20 +1030 (CST)
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


Hi,

I've been developing a soundcard driver for an embedded picozed bearing 
carrier card with 4 Cirrus CS42448 codecs.  Each codec has 6 ADCs and 8 
DACs, and is used in TDM mode, meaning there are 8 channel time slots on 
both the input and output serial audio data lines (DAIs).  Wired to 
connectors (and so accessible to me) are all 6 analog inputs and 1 
analog output, for each codec.

Each codec and its DAI link come up as a separate device.  I used the 
devices hw:2,n where n is the codec number.  (hw:0 and hw:1 are the 
dummy and loopback devices)

For each device/codec/DAI link, everything is as expected when using 
arecord and aplay when I either pipe the arecord output to aplay, or 
when arecord writes to WAV file and aplay outputs it.  That is, an 
analog signal applied to input channel 1 then appears on the output 
channel (1) for the same codec.

The first weird thing is when I use speaker-test.  If there were only 1 
device/codec/DAI link I wouldn't notice anything odd.  As expected only 
1 channel shows a signal because only channel 0 is wired to a 
connector.  But with 4 codecs, when I output via codec n, the output I 
see is on the channel that speaker-test thinks is channel n (ie. same 
number as the codec), not channel 0, which it should be!  Is this a 
possible channel mapping bug in speaker-test?

The second weird thing is when I apply a signal to 1 channel at a time, 
producing 24 WAV files output from arecord (4 codecs x 6 channels, but 
each contains only 8 channels of data - 6 inputs for a given codec and 2 
dummy channels).  I copied the files to my desktop, played them through 
vlc (as 7.1 surround) and used the PulseAudio Volume Meter to see which 
channels have signal on it. Note that these files behaved completely as 
expected when played through aplay on the embedded system.  The result 
was that the output channels were all over the place, seemingly random 
with no apparent pattern.  For some files the signals appeared on more 
than 1 channel.

It appears that vlc or PulseAudio Volume Meter must do some kind of 
remapping.  What I don't get is that the WAV files only have 8 channels, 
from a single codec, and should be independent of which codec the inputs 
were read from.  So even if the output channels were all over the place 
(and repeatably all over the place), they should be all over the place 
in the same way for each codec.  This was not what I got.  Each codec 
was all over the place in its own unique but repeatable way!!!

So can anyone suggest a way I can visualize which channels have signal 
in the WAV files, without the bizarre remapping done by vlc or 
PulseAudio Volume Meter?

Steve
