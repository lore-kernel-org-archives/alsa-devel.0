From: Smery <luca_ing@libero.it>
Subject: Re: Problems or bugs in snd-usb-audio.ko
Date: Thu, 1 Sep 2005 11:08:45 +0000
Message-ID: <200509011108.46288.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Lee Revell <rlrevell@joe-job.com>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 01, 2005 at 10:11:48AM +0200, Clemens Ladisch wrote:
> > On Wed, 2005-08-31 at 19:26 +0000, Smery wrote:
> > > I have an USB 2.0 device with one Audio Class interface.
> > > snd_snd-usb_audio.ko detects it and register the corresponding card.
> > > But there seems to be some problems with in snd-usb-audio module when
> > > reading from this device, (while another USB 1.1 device work fine).
> > >
> > > My kernel version is: 2.6.12-1.1372_FC3 (I also tried many other kernels)
>
> Please make sure you're using 2.6.13 and the latest ALSA (1.0.10rc1).

Okay. I'll try.

>
> Lee Revell wrote:
> > Because your device probably doesn'y support 8 bit mono at 8000Hz, which
> > is the default format of arecord.
>
> As it happens, this is the only format supported by this device.
> arecord would have complained if the format wasn't supported.

Yes, that's the only supported format.

Thanks


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
