From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [FT C400, PATCH RFC,
 v3 7/9] usb-audio: Fast Track C400 mixer ranges
Date: Tue, 27 Nov 2012 18:44:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211271745290.996@xoschi>
References: <1354032058-668-1-git-send-email-eldad@fogrefinery.com>
 <1354032058-668-8-git-send-email-eldad@fogrefinery.com>
 <50B4E650.90609@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 382192615B5
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 18:44:36 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so5008335bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 09:44:36 -0800 (PST)
In-Reply-To: <50B4E650.90609@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org, Chris Cavey <chris-alsa@rauros.net>, Takashi Iwai <tiwai@suse.de>, Grant Diffey <gdiffey@gmail.com>, Felix Homann <linuxaudio@showlabor.de>, George Willian Condomitti <georgecondomitti@gmail.com>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


On Tue, 27 Nov 2012, Clemens Ladisch wrote:
> Eldad Zack wrote:
> > Add ranges for various Fast Track C400 controls, as observed
> > while using the vendor's mixer control software (res values
> > are an estimation).
> >
> > +			snd_printk(KERN_INFO
> > +				"usb-audio: set quirk for C400 Effect Duration\n");
> 
> > +			snd_printk(KERN_INFO
> > +				"usb-audio: set quirks for C400 Effect Feedback/Volume\n");
> 
> > +			snd_printk(KERN_INFO
> > +				"usb-audio: set quirks for C400 %s\n", kctl->id.name);
> 
> > +			snd_printk(KERN_INFO
> > +				"usb-audio: set quirk for Fast Track C400 %s\n",
> > +				kctl->id.name);
> 
> Are these messages really needed?

I followed the example of ftu code and didn't give it much thought, 
but now that I think about it, they are just logspam. I'll remove it for 
v4. Thanks!

Cheers,
Eldad 
