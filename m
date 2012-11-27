From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [FT C400, PATCH RFC,
 v3 6/9] usb-audio: M-Audio Fast Track C400 quirks table
Date: Tue, 27 Nov 2012 17:44:01 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211271742360.996@xoschi>
References: <1354032058-668-1-git-send-email-eldad@fogrefinery.com>
 <1354032058-668-7-git-send-email-eldad@fogrefinery.com>
 <50B4E64C.9000804@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FF9E265255
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 17:44:07 +0100 (CET)
Received: by mail-bk0-f51.google.com with SMTP id ik5so4971515bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 08:44:07 -0800 (PST)
In-Reply-To: <50B4E64C.9000804@ladisch.de>
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
> > Adds a quirks table for the M-Audio Fast Track C400.
> >
> > +++ b/sound/usb/quirks-table.h
> > @@ -2296,6 +2296,77 @@ YAMAHA_DEVICE(0x7010, "UB99"),
> >  		}
> >  	}
> >  },
> > +{
> > +	USB_DEVICE_VENDOR_SPEC(0x0763, 0x2030),
> 
> The table should be sorted.

Thanks! Fixed locally (I will post a v4 later).

Cheers,
Eldad
