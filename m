From: Giuliano Pochini <pochini@shiny.it>
Subject: Re: Echo Indigo card on Sabayon Gentoo
Date: Sat, 16 Jan 2010 01:57:33 +0100
Message-ID: <20100116015733.0fef5bf0@Jay>
References: <898710.10745.qm@web65614.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out01.alice.it (smtp-out01.alice.it [85.33.2.12])
	by alsa0.perex.cz (Postfix) with ESMTP id CD66D1037F3
	for <alsa-devel@alsa-project.org>; Sat, 16 Jan 2010 01:58:13 +0100 (CET)
In-Reply-To: <898710.10745.qm@web65614.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "S. Aguinaga" <sa_jr@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 14 Jan 2010 12:13:55 -0800 (PST)
"S. Aguinaga" <sa_jr@yahoo.com> wrote:

> Hello Fellows, 
> Just downloaded the latest (released)  alsa-lib, alsa-driver, and alsa-utils, but my Indigo card does not work. It has been tested on the same system using the same drivers and on the same system using Fedora 10, that works fine.

Kernel or alsa version ?


> Do you know what I might have to do to get it working on Gentoo (sabayon)?

Same version ?


> Using aplay to list the device:
> card 2: IO [Indigo IO], device 0: PCM [Indigo IO]
>   Subdevices: 8/8
> .... etc.
> 
> Using aplay to test the card here is the command:
> aplay -D plughw:2,0  <wav file>
> 
> And this does not work, I have checked that things are ok with alsamixer, but still!

Do you mean aplay works but there is no sound ?
Do you see anything in the vu-meter or in the mixer meters ?



-- 
Giuliano.
