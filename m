From: Matthias Lemke <m@box.li>
Subject: Re: problem with alsa on Sony UX-90s
Date: Fri, 10 Nov 2006 13:19:41 +0100
Message-ID: <45546E5D.7090805@box.li>
References: <45534939.8000803@box.li> <s5hlkmjcz3p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hlkmjcz3p.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Takashi Iwai schrieb:
> At Thu, 09 Nov 2006 16:28:57 +0100,
> Matthias Lemke wrote:
>> Hello,
>>
>> i tried the last days linux on a sony UX90.
>> It is a very small notebook computer.
>>
>> Sound works perfekt with headphones, but the internal speaker does not
>> his job.
>> I use als 1.0.13.
>>
>> from dmesg:
>> [17179590.068000] hda_codec: Unknown model for ALC262, trying auto-probe
>> from BIOS...
> 
> First of all, try the latest ALSA version from HG tree, especially for
> HD-audio.  If it doesn't work, try to choose different model option
> found in ALSA-Configuration.txt.  Some model might match with your
> device. 
> 
I updated to 1.0.13...
is it not "latest" enough?
So please give me (non developer) some hints how to get the latest code
please. which components (driver, utils, lib?) I have to update?

> If none of the existing model matches with yours, we'd need to create
> a new model.  Load the driver without model option, and show the
> content of /proc/asound/card0/codec#* file.  If we have luck, the BIOS
> sets up a speaker pin...

I added this output to my bug:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2605

After upgrading I can try the different models...

thanks

math

> 
> 
> Takashi

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
