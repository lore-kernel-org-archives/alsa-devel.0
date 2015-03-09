From: "Kalvas, Taneli" <taneli.v.m.kalvas@jyu.fi>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Mon, 9 Mar 2015 11:37:26 +0000
Message-ID: <6A72E9C91650BD49A6D9B305755BC04C42D804EA@mbs1.ad.jyu.fi>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>
 <alpine.DEB.2.02.1503090933530.7125@lnxricardw1.se.axis.com>,
 <54FD5E2D.40801@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from posti5.jyu.fi (posti5.jyu.fi [130.234.4.34])
 by alsa0.perex.cz (Postfix) with ESMTP id F23042605C6
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 12:37:28 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by posti5.jyu.fi (8.13.8/8.13.8) with ESMTP id t29BbSie006538
 for <alsa-devel@alsa-project.org>; Mon, 9 Mar 2015 13:37:28 +0200
Received: from posti5.jyu.fi ([127.0.0.1])
 by localhost (posti5.jyu.fi [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tW9Cweb1r2XX for <alsa-devel@alsa-project.org>;
 Mon,  9 Mar 2015 13:37:28 +0200 (EET)
Received: from exmail.jyu.fi (cas2.ad.jyu.fi [130.234.8.30])
 by posti5.jyu.fi (8.13.8/8.13.8) with ESMTP id t29BbQ6b006532
 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
 for <alsa-devel@alsa-project.org>; Mon, 9 Mar 2015 13:37:28 +0200
In-Reply-To: <54FD5E2D.40801@ladisch.de>
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>> I am developing a patch librarian for a synthesizer. Because the
>>> communication happens with Midi sysex and timing is not relevant I chose
>>> RawMIDI interface and not the alsa sequencer. The problem I have
>>> encountered is that writing to the midi port with snd_rawmidi_write()
>>> seems to broken. The function accepts any size of data block and claims
>>> to have sent everything. In reality only a part of the message is sent.
>>> For a large block size I can see the activity light blinking for
>>> fraction of a second. This happens both in blocking and non-blocking
>>> mode. I would expect the snd_rawmidi_write() to accept only a part of
>>> the message.
>>
>> Can't help with rawmidi, but I can at least report that my experience
>> using the sequencer interface has been that it is rather straightforward
>> to use, even if just using it to send and transmit sysex data, even when
>> the data is longer than 300 bytes.
>
>If the data is larger than the RawMIDI buffer size (4096 bytes), the
>sequencer does not wait (like snd_rawmidi_write() would do), but just
>drops data.

This is just my question. You say snd_rawmidi_write() SHOULD cause a wait, but in my case it does not. Do you have any idea why this happens and how I could further diagnose the problem, possibly finding a fix?

Taneli
