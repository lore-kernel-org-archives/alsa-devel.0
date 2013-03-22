From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Fri, 22 Mar 2013 12:15:16 +0200
Message-ID: <514C2F34.6020307@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net>
 <7.0.0.16.2.20130321181551.0605bc60@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 52A6626515C
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 11:15:17 +0100 (CET)
In-Reply-To: <7.0.0.16.2.20130321181551.0605bc60@akdesigninc.com>
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

On 03/22/2013 03:27 AM, Andreas Koch wrote:
> I wouldn't worry about DSD wide, because that is a dead format that I
> was involved in launching for professional recording applications more
> than 10 years ago. It never took off.

I just need it for my own purposes, but I can make custom stuff as 
necessary if there's no interest from others.

Right now I'm just hoping to see a well defined common sample formats 
defined for ALSA that can be utilized by drivers. DoP could be 
implemented inside the driver or at ALSA layer instead of applications 
doing it. Not that I would mind, but I would find it cleaner than the 
current approach... :)

Currently, ASIO is the only API to support DSD sample formats. I 
understand that Microsoft or Apple is a slow to turn giant, but I'd hope 
ALSA wouldn't be such. ;)

There are already those IEC958 and DD/dts things being used for movie 
playback, so this wouldn't be such a big difference afterall.


	- Jussi
