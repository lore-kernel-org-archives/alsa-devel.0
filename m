From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: Jack insertion
Date: Tue, 18 Nov 2008 14:53:09 +0530
Message-ID: <5d5443650811180123i7ad22df5j5e7ff8dc6dd28bfe@mail.gmail.com>
References: <ef0d8a250811172246i411bd978h7d252b6d536e6de7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <ef0d8a250811172246i411bd978h7d252b6d536e6de7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-omap-open-source@linux.omap.com, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Naveen,

On Tue, Nov 18, 2008 at 12:16 PM, naveen krishna ch
<naveenkrishna.ch@gmail.com> wrote:
> Hello Alsa Devels
>
> I am working on a OMAP3 + TWL4030 combination for audio (alsa soc)
> I could develop the ASOC drivers with limited kcontorls and DAPM widgets for
> the setup.
>
> Now my issue is is there any work regarding the Headset JACK
> insertion/detection.

Check Jack Abstraction layer by Mark, it is already mainlined:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=include/sound/jack.h;h=b1b2b8b59adbe67d7efb817b09f7b985ad0422e7;hb=HEAD

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
