From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: Re: Mic + Headphone Problem in Samsung R540
Date: Fri, 08 Oct 2010 18:37:34 +0600
Message-ID: <4CAF108E.9040602@gmail.com>
References: <87aams5t14.fsf@alamut.ozu.edu.tr>
	<87vd5cew6b.fsf@alamut.ozu.edu.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id C03FB243C6
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Oct 2010 14:37:38 +0200 (CEST)
Received: by ewy8 with SMTP id 8so463660ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 08 Oct 2010 05:37:38 -0700 (PDT)
In-Reply-To: <87vd5cew6b.fsf@alamut.ozu.edu.tr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Volkan YAZICI <yazicivo@ttmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

Looks like your Capture switch is disabled. Run alsamixer, find Capture 
(press F4) and then press Space to start capturing sound. Obviously, you 
will need to run arecord after that (I recommend using -vv to see the 
bar moving as you speak anything into mic).

P.S. You shouldn't send messages to alsa-devel-request email, it is 
intended for list management functions.

Regards,
Valentine Sinitsyn
