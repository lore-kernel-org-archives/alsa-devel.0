From: "Cosmin Humeniuc" <cosmin@mandrivausers.ro>
Subject: How to cont the sound cards?
Date: Mon, 19 Nov 2007 09:12:51 +0200
Message-ID: <d067a0840711182312n4922bae2q6ac6e39c39b5d8fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 951A724443
	for <alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 08:12:53 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id m33so2147517wag
	for <alsa-devel@alsa-project.org>; Sun, 18 Nov 2007 23:12:52 -0800 (PST)
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

I am trying to develop an application using the ALSA library. I read
in a book about the snd_cards function, but it doesn't seem to be
defined anywhere. (The book is rather old, though, it talks about the
0.5.x series).

The compiler doesn't complain, but the linker gives me an "undefined
reference to `snd_cards'" error. I assume this function is deprecated,
but what can I use instead?

Cosmin
