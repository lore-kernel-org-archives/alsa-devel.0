From: Robert Krakora <rob.krakora@messagenetsystems.com>
Subject: Re: ALSA 1.0.23 Kernel Panic in
	snd_hda_codec_idt:stac92xx_add_jack
Date: Thu, 6 May 2010 13:19:59 -0400
Message-ID: <h2zb24e53351005061019w247fd664h1e952be03fe528d3@mail.gmail.com>
References: <i2gb24e53351005030547p5a8e5d67ya6fa14fccb6488e6@mail.gmail.com>
	<s5hfx25uwpy.wl%tiwai@suse.de>
	<j2sb24e53351005060849rcae4fce1re559a753f3054cb@mail.gmail.com>
	<s5hljbx0ztf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f178.google.com (mail-iw0-f178.google.com
	[209.85.223.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 965081037EA
	for <alsa-devel@alsa-project.org>;
	Thu,  6 May 2010 19:20:01 +0200 (CEST)
Received: by iwn8 with SMTP id 8so222141iwn.16
	for <alsa-devel@alsa-project.org>; Thu, 06 May 2010 10:20:00 -0700 (PDT)
In-Reply-To: <s5hljbx0ztf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

CentOS 5.4 with 2.6.18-164.15.1.el5 kernel

I will try to get you more lines ASAP.

On Thu, May 6, 2010 at 12:17 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 6 May 2010 11:49:46 -0400,
> Robert Krakora wrote:
>>
>> All:
>>
>> I am seeing a kernel panic with ALSA Drivers 1.0.23 in
>> snd_hda_codec_idt:stac92xx_add_jack on
>> my Dell Studio 1737 running stock CentOS 5.4. =A0Before I file a bug
>> report I just wanted to make sure that you did not already have a
>> patch for this problem. =A0Please see the attached .jpg for the trace.
>> I took a picture as this is a hard failure with a backtrace (keyboard
>> blinks).
>
> Which kernel version is it? =A0Also, any chance to see more lines?
> It'd be helpful if you can narrow down the position it oopses...
>
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>



-- =

Rob Krakora
Senior Software Engineer
MessageNet Systems
101 East Carmel Dr. Suite 105
Carmel, IN 46032
(317)566-1677 Ext. 206
(317)663-0808 Fax
