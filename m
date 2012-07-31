From: Daniel Mack <zonque@gmail.com>
Subject: Re: Alsa: USB Class 2 Audio soundcard device
 disappears suddenly
Date: Tue, 31 Jul 2012 07:24:49 +0200
Message-ID: <50176C21.4080203@gmail.com>
References: <1343687555.25545.YahooMailNeo@web121601.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 79A42265B57
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2012 07:24:52 +0200 (CEST)
Received: by wibhq4 with SMTP id hq4so2067055wib.2
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2012 22:24:53 -0700 (PDT)
In-Reply-To: <1343687555.25545.YahooMailNeo@web121601.mail.ne1.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joao Bonina <bonina_2001@yahoo.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 31.07.2012 00:32, Joao Bonina wrote:
> Hi,
> 
> I'm using an USB Class 2 Audio DAC (basically a soundcard) with my Linux box and MPD software.
> 
> It works great when playing files stored in a remote share, but when 
> playing files from an USB pen, it stops playing in a few minutes.
> 
> Mpd.log shows this:
> 
> Code:
> Jul 30 13:03 : output: "USB" [alsa] failed to play: No such device
> Jul 30 13:03 : output: closed plugin=alsa name="USB"
> ALSA lib pcm_hw.c:1401:(_snd_pcm_hw_open) Invalid value for card
> Jul 30 13:03 : output: Failed to open "USB" [alsa]: Failed to open ALSA device "hw:0,0": No such file or directoryIt seems to be somewhat related to the USB bus not being able to 
> cope with both PCM streaming to the soundcard and reading from the flash pen simultaneously, I guess.
> 
> So, anybody faced this issue previously and can provide some hints to solve this?
> 
> MPD is 0.17, kernel is 3.2.17, alsa-utils is 1.0.25.

Does the kernel log or 'dmesg' show anything weird what that happens?


Daniel
