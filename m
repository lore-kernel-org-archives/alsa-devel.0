From: "Liu, Wolke" <Wolke.Liu@amd.com>
Subject: Re: HDMI Status
Date: Fri, 25 Jan 2008 16:54:33 +0800
Message-ID: <A35A391979401F439803C1CB5F04C4EF1C2FFB@sshaexmb1.amd.com>
References: <s5h3asrfny5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound3-va3-R.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by alsa0.perex.cz (Postfix) with ESMTP id 42D1C24468
	for <alsa-devel@alsa-project.org>; Fri, 25 Jan 2008 09:55:25 +0100 (CET)
Content-class: urn:content-classes:message
In-Reply-To: <s5h3asrfny5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Zsolt Barat <zsolt@softmonsters.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It can work with ATI proprietary graphic driver - fglrx driver. It needs
the graphic driver to initialize the audio module. 

I tried it a few months ago on my SB600+RS690 platform, it can work :)

Regards,
Wolke
-----Original Message-----
From: alsa-devel-bounces@alsa-project.org
[mailto:alsa-devel-bounces@alsa-project.org] On Behalf Of Takashi Iwai
Sent: Monday, January 21, 2008 6:55 PM
To: Zsolt Barat
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] HDMI Status

At Fri, 18 Jan 2008 21:32:25 +0100,
Zsolt Barat wrote:
> 
> hi list,
> since i don't got any response on the users list, i try it here.
> i own a MSI board, K9AGM2, with north bridge S690G/690V and a as 
> southbridge SB600. the hda-intel driver works perfectly for the most
part.
> i just want to ask, how complete is the support for hdmi-audio. it
seems 
> that the hdmi-hardware is at least detected since alsamixer shows me
as 
> chip: Generic 1002 ATI RS690/780 HDMI. is it also supposed to put out 
> some audio? i couldn't test it cause of lack of hdmi-sound capable
hardware.

Me, too.  It's been untested by developers due to lack of hardware.


Takashi
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
