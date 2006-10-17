From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: aplay: set_params:1005: unable to install sw params
Date: Tue, 17 Oct 2006 10:05:26 +0100
Message-ID: <1161075926.3236.77.camel@localhost.localdomain>
References: <45344F94.6070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45344F94.6070701@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: DAMWID <damwid@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-10-17 at 11:35 +0800, DAMWID wrote:
> hi all,
> 
> I'm trying to get alsa work with kernel 2.6.18.1 on PXA270 platform, 
> after rebuild kernel with CONFIG_SND_PXA2XX_AC97 enabled and boot, 
> device is found. then I build alsa-lib and alsa-utils, and run aplay to 
> play a wav file, but get the following error:
> 
> # aplay Front_Center.wav
> Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate 
> 48000 Hz, Mono
> aplay: set_params:1005: unable to install sw params:
> start_mode: DATA
> xrun_mode: STOP
> tstamp_mode: NONE
> period_step: 1
> sleep_min: 0
> avail_min: 0
> xfer_align: 10
> silence_threshold: 0
> silence_size: 0
> boundary: 1434451968
> 
> What does this error mean? Can anybody help?
> 

This is probably to do with this ARM gcc bug:-

http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27363

and this is now fixed in gcc. :)

Fwiw, Open Embedded (http://www.openembedded.org/) builds an ARM EABI
toolset without this bug. It can also cross compile alsa-lib and all the
audio utilities for you as well.

Liam 




Privacy & Confidentiality Notice 
------------------------------------------------- 
This message and any attachments contain privileged and confidential information that is intended solely for the person(s) to whom it is addressed. If you are not an intended recipient you must not: read; copy; distribute; discuss; take any action in or make any reliance upon the contents of this message; nor open or read any attachment. If you have received this message in error, please notify us as soon as possible on the following telephone number and destroy this message including any attachments. Thank you.
-------------------------------------------------
Wolfson Microelectronics plc 
Tel: +44 (0)131 272 7000 
Fax: +44 (0)131 272 7001 
Web: www.wolfsonmicro.com

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
