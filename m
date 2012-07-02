From: Daniel Mack <zonque@gmail.com>
Subject: Re: Regression in sound/usb/
Date: Mon, 02 Jul 2012 14:10:55 +0200
Message-ID: <4FF18FCF.6020306@gmail.com>
References: <CADYPuQ75GAxGyZgiUwygvnQMmDcL9+NMHNo432kg1RYC7vbfQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 54A76245FB
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Jul 2012 14:11:00 +0200 (CEST)
Received: by bkcjg15 with SMTP id jg15so4001343bkc.38
	for <alsa-devel@alsa-project.org>; Mon, 02 Jul 2012 05:11:00 -0700 (PDT)
In-Reply-To: <CADYPuQ75GAxGyZgiUwygvnQMmDcL9+NMHNo432kg1RYC7vbfQA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philipp Dreimann <philipp@dreimann.net>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 01.07.2012 13:40, Philipp Dreimann wrote:
> Hello,
> 
> my usb webcam, which happens to have a microphone too, stopped working
> using usb2 since I tried kernel 3.5-rc2. (It works using usb3.)

Please try 3.5-rc5. A number of regressions were fixed just recently.

Let me know if that version still causes problems.


Daniel
