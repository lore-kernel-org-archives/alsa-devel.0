From: thomas.besser@ngi.de
Subject: Re: no sound anymore... (alsa & ac97 & intel8x0)
Date: Thu, 10 Aug 2006 16:16:41 +0200
Message-ID: <ebff4k$lol$1@sea.gmane.org>
References: <ebf2vj$ajv$1@sea.gmane.org> <s5hwt9gwwx4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Takashi Iwai wrote:
> At Thu, 10 Aug 2006 12:49:12 +0200,
> thomas.besser@ngi.de wrote:
> Please elaborate what do you mean "sound doesn't work".

I can simply not hear any sound. Devices are there:

ThessyMobil:~# ls -l /dev/dsp*
crw-rw----  1 root audio 14, 3 Aug 10 11:04 /dev/dsp
ThessyMobil:~# ls -l /dev/mixer*
crw-rw----  1 root audio 14, 0 Aug 10 11:04 /dev/mixer

No error message from kde or other programs that there is no sound device.

If I plug in knoppix 5 cd sound works fine, so no hardware issue.

> In most cases, it's a mixer configuration issue.

All 'governors' are IMO unmuted and turned on with alsamixer. Is there any
command line tool to verify that?

>> Error messages:
>> ALSA sound/pci/ac97/ac97_codec.c:1898: AC'97 2 does not respond - RESET
>> ALSA sound/pci/ac97/ac97_codec.c:1907: AC'97 2 access is not valid
>> [0xffffffff], removing mixer.
>> ALSA sound/pci/intel8x0.c:2129: Unable to initialize codec #2
>> 
>> Whats going wrong there?
> 
> This message might be harmless, indicating only a modem codec.

Ok, a modem is integrated, but I don't use it and so I've not compiled this
kernel module.

Thomas


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
