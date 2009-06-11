From: bill@tellytopia.com
Subject: Re: SB X-Fi driver fixes (Re: Testers wanted:
Date: Wed, 10 Jun 2009 23:14:00 -0700
Message-ID: <20090610231400.511367190d6e5c5c661eac68a9a86d95.17a4937c08.wbe@email.secureserver.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpoutwbe04.prod.mesa1.secureserver.net
	(smtpoutwbe04.prod.mesa1.secureserver.net [208.109.78.206])
	by alsa0.perex.cz (Postfix) with SMTP id 4970C1037F4
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Jun 2009 08:14:20 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I am using the snd-ctxfi driver on a 64-bit version of fedora code 7.
Is there anyone else working on a 64-bit system?

There are some compile warnings during the compilation of the driver,
but no errors.
But no sound, either, so far.

I have also taken the 1.0.20 library, utils and tools sources from the
Alsa main downloads.

In order to compile the utils I had to link the 64-bit sound libraries
to /usr/lib/libasound.2.0.0, in other words:
(cd /lib64; ln -s /usr/lib/libasound.2.0.0 libasound.2.0.0; ln -s
/usr/lib/libasound.2.0.0 libasound.2)
There is no /lib64/libasound.la

Also had to install xmlto (yum install xmlto).

So far I have added the snd-hda-intel driver to the blacklist but still
the Soundcard Detection shows snd-hda-intel.

Any ideas, anyone?

Regards
Bill
