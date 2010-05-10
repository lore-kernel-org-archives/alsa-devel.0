From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Fix 0 dB for Packard Bell
	models using Conexant CX20549 (Venice)
Date: Mon, 10 May 2010 12:29:56 +0200
Message-ID: <AANLkTinJUJ5t2YB85ba8AjZrJnNwNXvW8Kr4NHeFcBlJ@mail.gmail.com>
References: <x2n604760771004281507x5464161frd1f09b6cd4c8a7fc@mail.gmail.com>
	<s5hiq72vkt7.wl%tiwai@suse.de> <hs8bra$53h$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EC360103821
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 12:29:57 +0200 (CEST)
Received: by pvg4 with SMTP id 4so214253pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 03:29:56 -0700 (PDT)
In-Reply-To: <hs8bra$53h$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Starling <tstarling@wikimedia.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 10, 2010 at 9:15 AM, Tim Starling <tstarling@wikimedia.org> wrote:
> Can you please also add vendor ID 0x17aa (Lenovo)? I have the same
> problem on my Thinkpad R61. I compiled my kernel with a 0x17aa case
> added where Daniel's patch indicates and tested it with dbverify, it
> seems to fix the problem.

Please attach your alsa-info.sh output.
