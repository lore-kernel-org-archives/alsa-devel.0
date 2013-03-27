From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Wed, 27 Mar 2013 10:45:36 +0100
Message-ID: <5152BFC0.9080601@ladisch.de>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
 <7.0.0.16.2.20130322082602.0605cbc0@akdesigninc.com>
 <514E0A2A.1000201@sonarnerd.net>
 <7.0.0.16.2.20130323183543.0605ddb0@akdesigninc.com>
 <5151FDCD.2080103@gmail.com>
 <7.0.0.16.2.20130326224120.13b063e0@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E7B9B26506D
 for <alsa-devel@alsa-project.org>; Wed, 27 Mar 2013 10:45:39 +0100 (CET)
In-Reply-To: <7.0.0.16.2.20130326224120.13b063e0@akdesigninc.com>
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
Cc: Jussi Laako <jussi@sonarnerd.net>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

Andreas Koch wrote:
> ... your driver would send the DSD data in whatever format the DAC
> requests via its descriptors. [...] The only potential fly in the
> ointment is that we assume that the raw data format means DSD.

Add some vendor-specific descriptor to specify that raw means DSD.


Regards,
Clemens
