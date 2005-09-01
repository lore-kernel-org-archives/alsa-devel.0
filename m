From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems or bugs in snd-usb-audio.ko
Date: Thu, 1 Sep 2005 10:11:48 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509011008210.24687-100000@studcom.urz.uni-halle.de>
References: <1125547912.19563.74.camel@mindpipe>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1125547912.19563.74.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Smery <luca_ing@libero.it>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> On Wed, 2005-08-31 at 19:26 +0000, Smery wrote:
> > I have an USB 2.0 device with one Audio Class interface.
> > snd_snd-usb_audio.ko detects it and register the corresponding card.
> > But there seems to be some problems with in snd-usb-audio module when
> > reading from this device, (while another USB 1.1 device work fine).
> >
> > My kernel version is: 2.6.12-1.1372_FC3 (I also tried many other kernels)

Please make sure you're using 2.6.13 and the latest ALSA (1.0.10rc1).

Lee Revell wrote:
> Because your device probably doesn'y support 8 bit mono at 8000Hz, which
> is the default format of arecord.

As it happens, this is the only format supported by this device.
arecord would have complained if the format wasn't supported.


HTH
Clemens



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
