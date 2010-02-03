From: Jani Frilander <j.frilander@gmail.com>
Subject: Re: Zoom R16 (USB), will a quirk make it work
Date: Wed, 3 Feb 2010 14:07:18 +0200
Message-ID: <e53c6f621002030407o3fd3cd05w4936b98919fc37cf@mail.gmail.com>
References: <e53c6f621002012146n71ac0f7enb7e9f6e9c3b098d2@mail.gmail.com>
	<4B67DB5E.9080208@ladisch.de>
	<e53c6f621002021023s64f7cefct668505aa6ed72c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D91D24154
	for <alsa-devel@alsa-project.org>; Wed,  3 Feb 2010 13:07:20 +0100 (CET)
Received: by ewy23 with SMTP id 23so979580ewy.4
	for <alsa-devel@alsa-project.org>; Wed, 03 Feb 2010 04:07:18 -0800 (PST)
In-Reply-To: <e53c6f621002021023s64f7cefct668505aa6ed72c5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Current status of Zoom R16 quirk:

Control surface works, it sends midi events.

Audio doesn't work. When using plughw with aplay,
no sound can be heard. Aplay just seems to play the
file happily. Sample rate on the LCD changes accordingly.

When using plughw with mplayer, the device freezes. It
reacts the USB-disconnect button anymore. Mplayer also
starts playback happily, but no sound comes out.

I really would like to get this work. Thanks to everyone in
advance.

-Jani F.
