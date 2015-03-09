From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: RawMIDI behaviour with MidiFace 4x4
Date: Mon, 09 Mar 2015 19:40:52 +0100
Message-ID: <54FDE934.3060208@ladisch.de>
References: <6A72E9C91650BD49A6D9B305755BC04C42D801FA@mbs1.ad.jyu.fi>
 <alpine.DEB.2.02.1503090933530.7125@lnxricardw1.se.axis.com>
 <54FD5E2D.40801@ladisch.de>
 <alpine.DEB.2.02.1503091524320.7125@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 45CD12607FF
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 19:41:27 +0100 (CET)
In-Reply-To: <alpine.DEB.2.02.1503091524320.7125@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Kalvas,
 Taneli" <taneli.v.m.kalvas@jyu.fi>
List-Id: alsa-devel@alsa-project.org

Ricard Wanderlof wrote:
> On Mon, 9 Mar 2015, Clemens Ladisch wrote:
>> If the data is larger than the RawMIDI buffer size (4096 bytes), the
>> sequencer does not wait (like snd_rawmidi_write() would do), but just
>> drops data.
>
> I have noted though, that when sending data with snd_seq_ev_set_sysex()
> that the ALSA lib internally copies the data to an internal, malloced
> buffer, so I always thought that it would take care of any amount of data
> from there, but apparently not then?

The sequencer was designed for real-time events.  When events are scheduled
to be sent later, there is no good mechanism to let the current buffer fill
level influence the timing of events, or to report errors back.


Regards,
Clemens
