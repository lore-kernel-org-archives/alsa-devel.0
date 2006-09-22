From: Junji Umeno <umeno@elwsc.co.jp>
Subject: Re: Can't set less than 48k rate in the Intel-ICH4
 (AD1981B)
Date: Fri, 22 Sep 2006 13:23:55 +0900
Message-ID: <20060922132355.601db1ab@localhost.localdomain>
References: <20060921130546.02f871fe@localhost.localdomain>
	<1158824382.14818.271465641@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1158824382.14818.271465641@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens, thanks for you comment to see may poor understandings.

I thought pcm means virtual interfaces;

$cat /proc/asound/pcm 
00-00: Intel ICH : Intel 82801DB-ICH4 : playback 1 : capture 1
00-01: Intel ICH - MIC ADC : Intel 82801DB-ICH4 - MIC ADC : capture 1
00-02: Intel ICH - MIC2 ADC : Intel 82801DB-ICH4 - MIC2 ADC : capture 1
00-03: Intel ICH - ADC2 : Intel 82801DB-ICH4 - ADC2 : capture 1
00-04: Intel ICH - IEC958 : Intel 82801DB-ICH4 - IEC958 : playback 1

So, what does ADC2 means ?
I don't understand what these interfaces are mapped to well.
Because the AC97 codec (Analog Devices AD1981B) seems to have two ADC circits, each left or right,
so the two ADC were thought to be mapped with each ADC/ADC2 in the alsa mapping.

ICH4 is just a hub to RAM, I understand.
Putting aside how the codec is connected to ICH4 interface,
does ADC2 are mapped each side of the codec's stereo ADCs?


It seems unable to work duplex only with the pcm 00-00.
I can do alsa work duplex with the pcm 00-00 and 00-03.
Also, can do 00&03 pcm work both for capture at the same time, uselessly captureing from the same mic port.
It's confused me very much that ADC2, I mean alsa's pcm 00-03, works only if set less than 48k sampling rate.

hmm...

Regards,
Junji

On Thu, 21 Sep 2006 09:39:42 +0200
"Clemens Ladisch" <cladisch@fastmail.net> wrote:

> Junji Umeno wrote:
> > I can't set less than 48kHz rate for capture sampling.
> > In my case,
> > Alsa prepares 4 pcm devices, 
> > and I use the first 0-0 and the 4th 0-3, each playback and capture.
> 
> So your system has more than one codec?
> 
> > But when I set to the 3rd less than 48k rate, 
> > Alsa shows error,"cannot set sample rate".
> > On the other way, 
> > the 1st can be set less than 48k rate as a capture port. 
> 
> I'd guess the codec connected to the ICH4's 4th DMA input is another
> model.
> 
> 
> Regards,
> Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
