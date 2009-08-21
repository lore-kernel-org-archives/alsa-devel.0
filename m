From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: ALSA synchronization
Date: Fri, 21 Aug 2009 14:37:15 +0700
Message-ID: <c697747b0908210037g341b0a52mdff52c955d5814a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f187.google.com (mail-iw0-f187.google.com
	[209.85.223.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BF741038E8
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 09:37:16 +0200 (CEST)
Received: by iwn17 with SMTP id 17so217485iwn.16
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2009 00:37:15 -0700 (PDT)
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

Hi all,

We are developing a AES based speech encryption module using beagleboard. We
have two beagleboard: one for encryption and other for decryption. We use
audio-in/audio-out for sending speech. We have problem with synchronization
of audio stream from encryption board to decryption board. Since AES is
block cipher, the buffer content received by decryption board must be the
same as sent from encryption board. Right now, we want to use some bytes as
data header, but we don't now how to make this work. Any idea how to solve
synchronization in ALSA?

Best Regards,

Arif
