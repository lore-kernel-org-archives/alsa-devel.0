From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [alsa-devel] [PATCH 1/2] [media] sound: simplify au0828 quirk
	table
Date: Thu, 30 Oct 2014 12:16:13 +0100
Message-ID: <54521DFD.5030402@ladisch.de>
References: <cover.1414666159.git.mchehab@osg.samsung.com>
	<63287e8b3f1e449376666b55f9174df7d827b5b0.1414666159.git.mchehab@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <63287e8b3f1e449376666b55f9174df7d827b5b0.1414666159.git.mchehab@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, stable@vger.kernel.org, Daniel Mack <zonque@gmail.com>, Mauro Carvalho Chehab <mchehab@infradead.org>, Eduard Gilmutdinov <edgilmutdinov@gmail.com>, Vlad Catoi <vladcatoi@gmail.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: alsa-devel@alsa-project.org

Mauro Carvalho Chehab wrote:
> Add a macro to simplify au0828 quirk table. That makes easier
> to check it against the USB IDs at drivers/media/usb/au0828-card.c
>
> +++ b/sound/usb/quirks-table.h
> ...
> + * This should be kept in sync with drivers/media/usb/au0828-card.c

The file does not exist in that directory.  And when you want to
keep two files in sync, you need such reminders in both of them.


Regards,
Clemens
