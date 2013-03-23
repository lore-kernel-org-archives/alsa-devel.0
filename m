From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Sat, 23 Mar 2013 22:01:46 +0200
Message-ID: <514E0A2A.1000201@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id B7BA52652B9
 for <alsa-devel@alsa-project.org>; Sat, 23 Mar 2013 21:01:46 +0100 (CET)
In-Reply-To: <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Koch <andreas@akdesigninc.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

On 03/22/2013 06:05 PM, Andreas Koch wrote:
> The 8-bit raw format is for 2.8MHz DSD and the 16-bit format is for
> 5.6MHz DSD. In both cases the driver sets the sample rate to 352.8kHz on
> the DAC,

I see, this is different from how I've been dealing with it. Since I 
always use uint8 format, but instead vary the rate to 352.8/705.6/etc...

Just because it's much more straightforward form the application's 
perspective -> output rate is always bit rate divided by eight (=packet 
rate). And switch between uint8 / uint32 sample format equals to switch 
between DSD <-> PCM.


	- Jussi
