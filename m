From: "Tellman, Steven" <Steven.Tellman@idt.com>
Subject: Re: HDMI v. ICH8 on Dell XPS M1330
Date: Thu, 28 Feb 2008 12:55:32 -0800
Message-ID: <16A430A423D62246A24C9A892622FE66048B88@CORPEXCH1.na.ads.idt.com>
References: <1204152070.12914.18.camel@localhost>
	<s5hablls40f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxout2.mainstreet.net (mxout2.mainstreet.net [204.69.220.25])
	by alsa0.perex.cz (Postfix) with ESMTP id 0794C10383D
	for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2008 22:11:50 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <s5hablls40f.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Armando Di Cianno <armando@goodship.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Actually, I've seen this as well, haven't really started to debug it. We
define in the verb table of that system this:

;#21# <STAC9228> (SPDIF Out:Pin48) Jack:Other Digital, Digital, Black,
A:A, S:0, Loc:Internal, Sp.8 (Bay, HDMI), Det:No, Imp:No
;#21#Config=0x185610A0

Notice we use the "Other Digital" as the jack. Is that possibly causing
a problem? IEC958 shows up, but doesn't provide output to HDMI devices
(that I've tested).

IDT PC Audio Demo/Linux/Test


-----Original Message-----
From: alsa-devel-bounces@alsa-project.org
[mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
Sent: Thursday, February 28, 2008 5:41 AM
To: Armando Di Cianno
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] HDMI v. ICH8 on Dell XPS M1330

At Wed, 27 Feb 2008 17:41:10 -0500,
Armando Di Cianno wrote:
> 
> I figured this was more appropriate for devel, and not user.  Sorry,
if
> that's wrong.
> 
> First, I'm using the 1.0.16 release tarballs.  They work better than
the
> in-kernel drivers, as they survive both suspend and hibernate, whereas
> the kernel drivers do not.
> 
> I'm eager to see audio over HDMI working on my Dell XPS M1330.  I'm
> pretty sure that this is /not supported/ at the moment -- if this
isn't
> the case, please stop reading, and let me know the particulars.  HDMI
> seems to be supported noted, but mainly for the ATI chips.
> 
> I'm pretty sure the m1330 has a STAC9228 setup.  None of the suggested
> model= module parameters succeeded in getting audio over HDMI, beyond
> what is autodetected without any parameter specified.  model=5stack
> seems to show a digital SPDIF device added.

The HDMI on HD-audio is currently handled equivalently with SPDIF.
So, this device is the HDMI.  Try to output this?  Don't forget to
adjust 'IEC958'-related mixer controls.

> If there is anyway I can help the core developers get HDMI audio
> working, I would be glad to help.  I will post all the relevant
> information I can think of following; please let me know if other
> information would be helpful.

Use alsa-info.sh.  This will contain far more information.

thanks,

Takashi
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
