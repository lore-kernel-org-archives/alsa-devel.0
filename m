From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Mon, 10 Mar 2008 20:29:35 +0100
Message-ID: <47D58C1F.7020805@keyaccess.nl>
References: <20080310162130.AFFD3DBA2@gherkin.frus.com>	<47D56851.2000509@keyaccess.nl> <s5h3aqywlf0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <s5h3aqywlf0.wl%tiwai@suse.de>
Sender: linux-alpha-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Bob Tracy <rct@frus.com>, ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 10-03-08 18:14, Takashi Iwai wrote:

>> Takashi? Wasn't there an OSS emulation on Alpha thing a while ago?
> 
> No, I don't know of.  OSS emulation code is written fairly independently
> from architectures.  Maybe just a missing CONFIG_SND_PCM_PLUGINS kconfig?

Could've sworn...

The bug seems not present on x86. I'm testing with a ES1968 and ES1898 (his 
is a 18888) and playback through ALSA native nor OSS emulation is giving me 
trouble up to now.

Bob? How short are "short" wav files by the way?

Rene.


