From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Setting hw constraints
Date: Fri, 13 Sep 2002 11:02:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209131058260.521-100000@pnote.perex-int.cz>
References: <5.1.1.6.1.20020913022555.4320e3d0@pop.alternex.com.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.1.1.6.1.20020913022555.4320e3d0@pop.alternex.com.br>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php=alsa-devel>
To: Haroldo Gamal <gamal@alternex.com.br>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Sep 2002, Haroldo Gamal wrote:

> Hi!
> 
> I am trying to improve the korg1212 driver and I am finding a difficult
> situation. Let me explain... The korg1212 card has a fixed size audio
> frame containing two different sample size, 16 bits and 32 bits, that
> are filled by the card at same time. Ten channels of this frame have 16
> bits (ADAT + analog channels), two others have 20 bits (SPDIF) and 32
> bits of ADAT Time-code information.
> I am trying to establish three different devices to support these
> different sample size and interface type (ADAT, analog and SPDIF). To do
> this, I will have a frame size greater than the number of samples times
> its size.

Nope. The frame size should be equal to real samples, but the physical
lenght might be greater. Simply, define your copy() and silence()
callbacks for standard read/write operations and override
SNDRV_PCM_IOCTL_CHANNEL_INFO with the right step and first value.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
