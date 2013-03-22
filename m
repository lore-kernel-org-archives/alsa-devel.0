From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 0/3] ALSA: snd-usb: Some small fixes to
 make Playback Design products work
Date: Fri, 22 Mar 2013 21:37:06 +0200
Message-ID: <514CB2E2.9050003@sonarnerd.net>
References: <1363522047-7515-1-git-send-email-zonque@gmail.com>
 <s5hehfduld0.wl%tiwai@suse.de> <5146DB40.2060000@gmail.com>
 <s5h620pukb4.wl%tiwai@suse.de> <51471B51.4000006@gmail.com>
 <514B79DA.6030203@sonarnerd.net> <514C1215.9010708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id A8EE8266588
 for <alsa-devel@alsa-project.org>; Fri, 22 Mar 2013 20:37:09 +0100 (CET)
In-Reply-To: <514C1215.9010708@gmail.com>
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

On 03/22/2013 10:11 AM, Daniel Mack wrote:
> Ah, interesting. So what *are* you using right now for your transport in
> userspace? Is your application abusing standard PCM interfaces that are
> 'known' to be in fact DSD? How do other DACs expose their interfaces in
> the Linux world, and which ones did you test your application with?

Yes, it's abuse of PCM (hw) interface, I'm using the DoP specification 
as referred to in another post. All the DSD DACs that currently work 
with Linux support this. Quite many at the moment in fact and more 
coming all the time.

There's at least devices from Mytek, Fostex, Benchmark and Sonore/exD 
that work with this setup. And I believe also Chord, but I haven't got 
chance to test it yet.

Mytek has a vendor specific interface (RigiSystems USBPAL) that could 
utilize a separate raw DSD sample format.

Plus I have some of my own experiments implementing DSD on an ARM based 
SoC where there's no need use DoP, but now I need to use custom hack for 
the raw data. Thus sooner there's some officially defined ALSA formats, 
less likely it becomes fragmented set of different incompatible hacks. 
That would be a headache and nightmare for application developers.


	- Jussi
