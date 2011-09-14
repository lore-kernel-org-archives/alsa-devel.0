From: Mike Crowe <drmikecrowe@gmail.com>
Subject: Re: OSS emulation and hardware configuration
Date: Wed, 14 Sep 2011 12:20:04 -0400
Message-ID: <CA+jNppm327XnUPQ85XSE9NAWkuyD5KeUxoEZc=r0pxZcQzz=ig@mail.gmail.com>
References: <CA+jNppn4QPrNb_Jg00En1WZ0Gp97fJzfrFC9DCY2Qa6u004ymg@mail.gmail.com>
	<4E70C260.3040001@ladisch.de>
	<CA+jNppnG5UbUOuxqDc-kmR5-pO1n7BX4922d109XV66jXyR-Jg@mail.gmail.com>
	<CAPAActeAqyEW_YtYm-aK8u-c=Ej9qsc4o5QHaj-nM9i9LX8+hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f49.google.com (mail-vw0-f49.google.com
	[209.85.212.49]) by alsa0.perex.cz (Postfix) with ESMTP id 18F20243F8
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 18:20:27 +0200 (CEST)
Received: by vws8 with SMTP id 8so2323685vws.22
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 09:20:26 -0700 (PDT)
Received: by gwj16 with SMTP id 16so1872969gwj.9
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2011 09:20:24 -0700 (PDT)
In-Reply-To: <CAPAActeAqyEW_YtYm-aK8u-c=Ej9qsc4o5QHaj-nM9i9LX8+hQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sean McNamara <smcnam@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sean,

> Right, but if you're using the in-kernel OSS emulation, it bypasses
> the userspace ALSA-lib plug layer! You'll have to resample it in
> userspace within the OSS application, probably.
>
> Or, you can use osspd (sometimes referred to as ossp or oss-proxy):
> http://sourceforge.net/projects/osspd/

I had started to look at aoss.  Any thoughts on comparing the two?
Memory is tight, so I'm looking for the smallest memory footprint
possible.


Otherwise, thanks for all your comments.  Very helpful.  A next task
on my list was tackling mixing, and it sounds like removing OSS
Emulation and moving to one of the above is a better solution.

Thanks!
Mike
