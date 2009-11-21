From: "Alonso Quiroz H." <quiroz.alonso@gmail.com>
Subject: Sigmatel STAC 9228
Date: Sat, 21 Nov 2009 11:19:48 -0300
Message-ID: <6e37b7cd0911210619y170b6fa2qceab4529382ec945@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id B2599245C3
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 15:19:49 +0100 (CET)
Received: by pwj11 with SMTP id 11so5614214pwj.32
	for <alsa-devel@alsa-project.org>; Sat, 21 Nov 2009 06:19:48 -0800 (PST)
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

Hey guys!, this is my first mail to the list. Excuse me if this is not
the better way to send my request.
I have a Dell XPS M1530 laptop, with a Sigmatel soundcard... well,
read it for yourselves:

http://pastebin.ca/1679794

By default (in Ubuntu 9.10) the card doesn't work in 5.1 mode, and
that is my problem... by default it doesn't show the option "Surround
5.1"

I have tried a lot of combinations of model=XXXXX in
/etc/modprobe.d/alsa-base.conf, starting by the ones in
/usr/share/doc/alsa-base/driver/HD-Audio-Models.txt. The better result
is with "3stack": It 's possible to select the 5.1 option, but I don't
get sound at all. The weird thing is that de volume control of Pulse
shows bars moving.

Thanks in advance. Sorry about my english.

Alonso Quiroz H.
