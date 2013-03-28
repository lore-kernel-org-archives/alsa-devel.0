From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Thu, 28 Mar 2013 02:10:01 +0200
Message-ID: <51538A59.1020909@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
 <514E0A2A.1000201@sonarnerd.net>
 <7.0.0.16.2.20130323183543.0605ddb0@akdesigninc.com>
 <514EDA91.9000305@sonarnerd.net> <5151F85C.7070204@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id CEF2B265344
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 01:10:02 +0100 (CET)
In-Reply-To: <5151F85C.7070204@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, Andreas Koch <andreas@akdesigninc.com>
List-Id: alsa-devel@alsa-project.org

On 03/26/2013 09:34 PM, Daniel Mack wrote:
> What protocol is that? Is there a driver for Linux?

Just a custom flow-controlled bulk-mode byte stream. I have some hacks 
to make things work for my own prototype purposes, but I haven't got 
time to make anything clean and worth releasing.

There's not much point in releasing a driver that nobody else has 
hardware for... :)

I was hoping to discuss the ALSA sample format topic already earlier in 
context of getting DSD support to the RigiSystems USBPAL Linux driver, 
but it doesn't seem to be proceeding anywhere and I don't have necessary 
documentation (nor time)...
https://github.com/lintweaker/mytekusb2
I have the hardware though, so I can test & develop things at 
application side.


	- Jussi
