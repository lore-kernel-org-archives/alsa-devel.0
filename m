From: "Martin van Es" <mrvanes@gmail.com>
Subject: Vostro 1400 patch
Date: Wed, 26 Mar 2008 20:54:01 +0100
Message-ID: <eccab77d0803261254v60632b15m612efb6cd437979f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.186])
	by alsa0.perex.cz (Postfix) with ESMTP id C44BE24355
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 20:54:04 +0100 (CET)
Received: by mu-out-0910.google.com with SMTP id i10so6086478mue.3
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 12:54:01 -0700 (PDT)
Content-Disposition: inline
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

Hi,

I recently bought a Dell Vostro 1400 and thought I'd let you know my
experiences with Alsa:

I use Kubuntu Gutsy distribution as a base, but follow kernel at a
close pace so I use compiled 2.6.24. This didn't support the hda-intel
as I expected (don't remember exactly, but master/front/pcm/surround
were all in the game but not as expected and I couldn't get built-in
mic to work, but this may be due to too little testing).

So I decided to google around and found the model=3stack, dell-3stack
options and tried those. Still no luck.

Next I dl'ed alsa 1.0.16 and noticed a mail describing a vostro 1400
PCI quirck patch (model dell-bios). So I tried that, but no luck.
After that I experimented with all 3stack variants I could find in the
code and concluded that dell-3stack is the best. I now have sound,
master/front/pcm volume sliders that work but above all: built-in mic
(Digital 1) recording (and skype) works!

I don't know if it's of any value: I immediately flashed the standard
A06 Bios to A07 when I found the update on the Dell site and can not
tell if the dell-bios model worked for the preloaded A06 version bios.

Hope this helps. If there's anything else I can provide I'd be more
than happy to collect the data.

Regards,
Martin
-- 
if but was of any use, it would be a logic operator
