From: Roger E Critchlow Jr <rec@elf.org>
Subject: Re: Fwd: Re: USB Quattro Linux support
Date: Wed, 17 Apr 2002 20:25:48 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15550.11949.76618.122338@elf2.elf.org>
References: <20020417071207.05D6636FA@sitemail.everyone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020417071207.05D6636FA@sitemail.everyone.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: pshirkey@boosthardware.com
Cc: linux-audio-dev@music.columbia.edu, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey writes:
 > --- Paul Davis <pbd@op.net> wrote:
 > >Not at all. arecord(1) can capture audio, but it can't capture 26
 > >channels of audio at 64 frames/interrupt. Handling latency is partly
 > >an application issue, partly a kernel issue, and partly a requirement
 > >that libraries in the way don't get in the way. It has very little to
 > >do with whether you can do certain generic tasks or not.
 > >
 > 
 > Sure. But usb audio devices are limited to a pretty low channel count.
 > 
 > eg. this usb quattro can only capture 1 channel at 96000,24 bit
 > even though it has up to 4 channels. It would seem to be a limitaion
 > of usb as a transfer protocol.  
 > 

USB-1.1 devices are limited, but USB-2.0 controllers are already on
the market and will be replacing USB-1.1 on new motherboards as the
year progresses.  There's a 40 fold increase in raw bandwidth in
USB-2.0, from 12Mbit/s to 480Mbit/s, so one could imagine plugging
several CD-quality USB-1.1 audio devices into a USB-2.0 hub, or
getting multiple channels of DVD quality from a USB-2.0 audio
interface.

So, sooner or later, your driver,too, will get its chance to be a
latency bottleneck.

-- rec --
