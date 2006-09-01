From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: hda_intel broken on my ATI SB450
Date: Fri, 1 Sep 2006 04:39:08 -0400
Message-ID: <200609010443_MC3-1-C9F8-E16F@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from liaag1ag.mx.compuserve.com (liaag1ag.mx.compuserve.com
	[149.174.40.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 409F925A
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Sep 2006 10:45:07 +0200 (MEST)
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Using 2.6.18-rc5 and trying to load snd-hda-intel.ko for this
(supported) device:

| 00:14.2 Audio device: ATI Technologies Inc Unknown device 437b (rev 01)
|        Subsystem: Acer Incorporated [ALI] Unknown device 009f
|        Flags: bus master, slow devsel, latency 64, IRQ 217
|        Memory at c0000000 (64-bit, non-prefetchable) [size=16K]
|        Capabilities: [50] Power Management version 2
|        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

I get:

| hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
| hda_intel: azx_get_response timeout, switching to single_cmd mode...

Followed by nearly-endless spew of:

| hda-intel: get_response timeout: IRS=0x0
| hda_codec: invalid dep_range_val 0:7fff
| hda_codec: invalid dep_range_val 0:7fff
| hda-intel: get_response timeout: IRS=0x0
| hda_codec: invalid dep_range_val 0:7fff
| hda-intel: get_response timeout: IRS=0x0
| hda-intel: get_response timeout: IRS=0x0

And finally:

| hda_generic: no proper input path found
| hda_generic: no proper output path found
| hda_generic: no PCM found

How can I debug this?

-- 
Chuck


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
