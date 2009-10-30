From: ext-eero.nurkkala@nokia.com
Subject: [RFC 0/2] ASoC: remove io_mutex
Date: Fri, 30 Oct 2009 13:34:01 +0200
Message-ID: <1256902443-15492-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 3ECE2103893
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 12:36:03 +0100 (CET)
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com
	[10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id
	n9UBZo1u012887
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 06:36:01 -0500
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
Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

This RFC set addresses the existence of io_mutex.
A safer method is introduced - but it changes the
semantics quite a bit, as now all drivers calling
snd_soc_update_bits() will need to make sure the
codec mutex is taken.

snd_soc_test_bits() - function does not need to
take the io_mutex at all - all calls to it have
the codec mutex already taken.

Warning: Not even compile tested!

Possible drawback:

dapm_power_widgets() may hold the codec mutex for
a few ms, which may be too long; meanwhile,
calls to snd_soc_update_bits() are stalled.

Of course we wish optimal performance and maybe
the codec mutex should only be taken for such
registers that contain both volume and dapm bits...

Ideas, comments, all welcome.
