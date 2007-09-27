From: "Ma Begaj" <derliebegott@gmail.com>
Subject: Asus M2NPV-VM (AD1986A) - Surround does work,
	snd-hda-intel dies on volume change
Date: Fri, 28 Sep 2007 00:09:45 +0200
Message-ID: <a72d33330709271509r4291e18dtf7339045858b7816@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 38DC7243A9
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Sep 2007 00:09:47 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so2072113rvb
	for <alsa-devel@alsa-project.org>; Thu, 27 Sep 2007 15:09:45 -0700 (PDT)
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

Sorry if this email is not for devel mailing list, but this sounds to
me like a bug or development problem. If I am wrong, I will post it on
the user list.

And for the long email ... I just wanted to describe everything I tried.


I found a lot of messages about problems with sound chip AD1986A on
motherboard Asus M2NPV-VM. It is almost always the same problem,
surround does not work and sound mutes (module dies) when the user
change volume. That is my problem too.

I found a lot of solutions by using "model=3stack", sometimes with
"position_fix=1", but that does not work for all the users. I checked
the list, I read dozens of emails, but nothing helped.

I found a few patches on the list, but all of them were for kernels < 2.6.22.

I used Slackware 12.0 and model=3stack caused a terrible "weeping"
sound on the rear left speaker, but the stereo worked. I read a lot of
success stories with this motherboard and Ubuntu and after playing
whole week long on Slackware (kernel 2.6.21.5 and 2.6.22.6), I decided
to try it with Ubuntu Feisty (2.6.20 and 2.6.22.9), although I did not
believe that Ubuntu should help. It actually helped partly because the
weeping sound disappeared, but I had only stereo.

When I changed the "Channel Mode" jack in alsamixer from 2ch to 6ch,
sound muted and module died. The only way to get the sound back was to
stop playing file, and rmmod/modprobe snd_hda_intel again.

Using model=6stack gives me surround sound by using "speaker-test -c6
..." (nice female voice guessed right every speaker)  but module was
still dying as soon as I changed volume.


Does someone have an idea what to do with this chip ... I am really
desperate and beginning to hate this great motherboard ...

Thanks a lot.

M.
