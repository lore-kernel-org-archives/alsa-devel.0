From: Alan Bennett <abennett@miltope.net>
Subject: Intel HDA - AD1883 Codec - Jack Sense / Detect
Date: Tue, 3 Nov 2009 08:32:55 -0700
Message-ID: <599c22f00911030732g7907d4c0w748d14a986454c74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 89ABB103902
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 16:32:55 +0100 (CET)
Received: by ewy21 with SMTP id 21so9166400ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2009 07:32:55 -0800 (PST)
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

Hello;
  We have a custom motherboard Intel HDA / AD1883.  For output, we connect
the headphone jack and the mono / front speaker.

  We are unable to get audio in Linux (Windows is fine) that activates the
front/mono speaker.   The headphones work without a problem.  However, none
of the 4 "model=" strings improve the situation.  The headphones always
work, but no configuration will activate the onboard front/mono speaker.

  Is there a way to query the live status of the AD1883 / jack-detect/sense?


-Alan
