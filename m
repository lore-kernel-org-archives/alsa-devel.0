From: Stephen Hassard <steve@hassard.net>
Subject: Re: Updated: via8233 driver -- testers wanted
Date: Mon, 27 May 2002 07:29:07 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.1.2.2.20020527072432.00aa3078@www.angiotech.com>
References: <s5hit59emm8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hit59emm8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

I just tried from CVS (within the last 20 mins) on my MSI KT266A chipset 
with VT8233 southbridge and have a few problems. I've compiled and 
modprobe'd all the req'd modules. The VT8233 detected properly, I've setup 
OSS emulation and /dev/dsp exists. I try playing an mp3 stream thru xmms 
and everything looks okay (no errors), but when I run any of the alsa apps 
(alsactl store, alsamixer) I get a "function snd_ctl_open failed for 
default: Sound protocol is not compatible" error .. I'm definitely using 
the right lib and utils from the cvs ..

later,
Steve

At 03:39 PM 27/05/2002 +0200, Takashi Iwai wrote:
>Hi,
>
>with help of VIA tech, i've changed via8233 drivers to support VT8233A
>chip, which has been not working so far.
>the changes were already commited to cvs.
>
>so, if someone has VIA8233 chipsets, please test the latest cvs
>version, and report back to this ML.  (please check via8233.c has
>rev.1.16.)
>
>this change affects not only to VT8233A but also VT8233 and VT8233C
>chips.  it'd be appreciated if owners of these chips can test the
>driver.
>
>also, if your hardware supports multiple channels (4/6 playbacks) or
>spdif i/o, please let me know.  these features are not implemented,
>but could be done relatively easily.
>
>
>thanks,
>
>Takashi
>
>_______________________________________________________________
>
>Don't miss the 2002 Sprint PCS Application Developer's Conference
>August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
>
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel



_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
