From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: Re: Echo Indigo card on Sabayon Gentoo
Date: Tue, 19 Jan 2010 23:15:41 -0800 (PST)
Message-ID: <152312.48176.qm@web65610.mail.ac4.yahoo.com>
References: <898710.10745.qm@web65614.mail.ac4.yahoo.com>
	<20100117230438.33ca6692@Jay>
Reply-To: "S. Aguinaga" <sa_jr@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n6c.bullet.mail.ac4.yahoo.com (n6c.bullet.mail.ac4.yahoo.com
	[76.13.13.83]) by alsa0.perex.cz (Postfix) with SMTP id 6B4931037E3
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 08:15:42 +0100 (CET)
In-Reply-To: <20100117230438.33ca6692@Jay>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Hello Giuliano,

No luck, same behavior. I edited the first file listed listed below and recompiled it and installed it.
Then I restarted the system with the indigo card in place, and the VU meters show levels in the -120 to -100 dB?

I do have alsa-driver-1.0.22
my kernel is 2.6.31

// Salvador






________________________________
From: Giuliano Pochini <pochini@shiny.it>
To: S. Aguinaga <sa_jr@yahoo.com>
Sent: Sun, January 17, 2010 4:04:38 PM
Subject: Re: [alsa-devel] Echo Indigo card on Sabayon Gentoo

On Thu, 14 Jan 2010 12:13:55 -0800 (PST)
"S. Aguinaga" <sa_jr@yahoo.com> wrote:

> Hello Fellows, 
> Just downloaded the latest (released)  alsa-lib, alsa-driver, and alsa-utils, but my Indigo card does not work. It has been tested on the same system using the same drivers and on the same system using Fedora 10, that works fine.

First install a recent version of echomixer.

If you are using alsa-driver 1.0.22 or kernel 2.6.32, try to add this line:

#define ECHOCARD_HAS_LINE_OUT_GAIN

in

alsa-driver-1.0.22/alsa-kernel/pci/echoaudio/indigoio.c

or in

linux-2.6.32/sound/pci/echoaudio/indigoio.c

and recompile. It re-enables the line-out control that I removed last year
because it was not supposed to exist in that card.


-- 
Giuliano.
