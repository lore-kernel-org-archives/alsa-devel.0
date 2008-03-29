From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sat, 29 Mar 2008 13:09:34 +0100
Message-ID: <47EE317E.9030807@keyaccess.nl>
References: <20080329064227.58074DBA2@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <20080329064227.58074DBA2@gherkin.frus.com>
Sender: linux-alpha-owner@vger.kernel.org
To: Bob Tracy <rct@frus.com>
Cc: Tyson Whitehead <twhitehe@uwo.ca>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, Krzysztof Helt <krzysztof.h1@wp.pl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 29-03-08 07:42, Bob Tracy wrote:

>>> +#ifdef CONFIG_ALPHA
>>> +	if (!(status & (AUDIO1_IRQ | AUDIO2_IRQ))) {
>>> +		/* status = 0; */

> Unfortunately, this does nothing to fix the ES1888 on my system.  Same
> broken behavior as described previously.  I'll try something else in
> the queue later today after I get some sleep...

Okay. The thing that "fixed" Tyson was disabling mmap from the driver:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006911.html

It landed him in the same situation as you though, where that "asskickd.wav" 
mono, 8-bit 11025 file you sent me shows the same behaviour you reported. 
This might imply you weren't using mmap to begin with. You have no horribly 
obsolete alsa userland, nor an /etc/asound.conf or ~/.asoundrc?

No change with "aplay -M"? If there is a change, you'd expect it to be 
Tyson's old behaviour which means blowing up the machine on subsequent 
plays, so be a bit careful...

This one needs answer so as to possibly pin things down to format:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-March/006914.html

Rene.

