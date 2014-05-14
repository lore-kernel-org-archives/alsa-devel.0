From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
	a succesor to firewire-speakers
Date: Wed, 14 May 2014 23:15:33 +0900
Message-ID: <53737A85.4050506@sakamocchi.jp>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
 <20140513194302.128783a7@kant>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 7489A261B03
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 16:15:41 +0200 (CEST)
In-Reply-To: <20140513194302.128783a7@kant>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: clemens@ladisch.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, fenlason@redhat.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Stefan,

(May 14 2014 02:43), Stefan Richter wrote:
> Note, current mainline snd-firewire-speakers does _not_ support FireWave
> properly.

Oh...

> On one of the stereo channels, snd-firewire-speakers generates
> a high background hiss.

Do you know which combinations of channels/rate?

> Could be that Jay Fenlason had a solution for this which hadn't made it into the mainline still. Was it something
> about signedness of the PCM data?

I don't know exactly. So here I describe my guess.

As long as seeing responses from FireWave which you and Jay sent to me, 
FireWave has two stream format for the same sampling rate. They're:
  - 6 channels for Multi Bit Linear Audio
  - 2 channels for IEC 60958-3 Conformant data

[alsa-devel] Griffin FireWave stream format information
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073561.html


In detail,
 > - 6ch PCM at 32.0/44.1/48.0/96.0kHz
 > - 2ch IEC 60958-3 at 32.0/44.1/48.0kHz

[alsa-devel] PCM rules for FireWave in speaker.c
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-February/073562.html


I guess that 6ch PCM mode is primary and 2ch IEC 60958-3 mode is 
secondary. So I think that 'firewire-speakers' driver was merged with 
wrong idea that FireWave is 'two playback-only' FireWire device.

ALSA: add LaCie FireWire Speakers/Griffin FireWave Surround driver
http://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/firewire/speakers.c?id=31ef9134eb52636d383a7d0626cbbd345cb94f2f


For the way to switch these two modes, we've already revealed to use 
'CONTROL' ctype of EXTENDED STREAM FORMAT INFORMATION' command with 
'SINGLE' subfunction in 'AV/C Stream Format Infomation Specification'.

But in this RFC, I don't implement this. As long as 'firewire-speakers' 
works fine, FireWave can detect mode automatically, typically by reading 
data block size in CIP headers.

...But if all of 2ch playbacks are failed, I should change codes to use 
this command...

...And current firewire-lib is not conformant to IEC 61883-6 data 
channel because firewire-lib transfers data with wrong AM824 label to 
this channel. I have two reasons for this implementation: one is 
Fireworks/BeBoB seems to ignore labels and eventually can handle data 
correctly, another is to keep the codes simply. If this issue is due to 
this implementation, I should do further work for firewire-lib...

Anyway, I wait for testers' report.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
