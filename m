From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [RFC] Addition of sysfs file for PCM
Date: Tue, 08 Aug 2006 18:51:18 +0200
Message-ID: <m2k65j41dl.fsf@vador.mandriva.com>
References: <s5hvep3ntsf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hvep3ntsf.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
	08 Aug 2006 17:14:56 +0200")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> Hi,
> 
> I've discussed with HAL guys about the current problem of sound
> configuration over HAL.  One issue is that both audio and modem PCM
> devices appear on the same card (e.g. HD-audio), and can't be
> distinguished from the device name itself.
> 
> For solving this, I made a patch to add a sysfs file in
> /sys/class/sound/pcm* directories indicating the PCM device class.

I'd suggest discussing this with Greg Kroah-Hartman.
 
> If anyone has better idea or implementation, let me know.
> 
> Another qustion regarding this is whether we push it to the public
> HG repo right now, or wait until 1.0.12-final is released.
> As usual, I have no idea when we reach 1.0.12-final, hence I prefer
> pushing it as soon as possible, but this would bring of course a
> possibility of regression (especially for building with the older
> kernels).

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
