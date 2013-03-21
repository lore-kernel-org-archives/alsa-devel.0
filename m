From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Thu, 21 Mar 2013 23:21:30 +0200
Message-ID: <514B79DA.6030203@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 535F6265117
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2013 22:21:31 +0100 (CET)
In-Reply-To: <51471B51.4000006@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 03/18/2013 03:49 PM, Daniel Mack wrote:
> Yes. If at all, we should add a SND_PCM_FORMAT_DSD, and a quirk for that
> device. But given that there is no application for DSD in userspace
> either, we probably don't need to care.

Yes there is? At least my application. And I'd be happy to support any 
custom format created for the purpose... :)

(http://www.signalyst.com/consumer.html for those who are interested)

I would propose to create custom 8-bit sample formats for DSD purposes, 
similar to the ASIO formats. Practically two main ones, byte with oldest 
bit in MSB and byte with oldest bit in LSB. And maybe the "DSD-wide" one 
which is 8-bit DSD sample.


	- Jussi
