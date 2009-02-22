From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Distortion in SND_PCM_FORMAT_S32 playback with Intel
	HDA
Date: Sun, 22 Feb 2009 05:35:42 +0200
Message-ID: <49A0C80E.3060302@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jenni1.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 181421037EB
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 04:35:45 +0100 (CET)
Received: from trn.iki.fi (84.250.38.215) by jenni1.inet.fi (8.5.014)
	id 48FC59C7055ED054 for alsa-devel@alsa-project.org;
	Sun, 22 Feb 2009 05:35:44 +0200
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id DFF9A45B863E2
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 05:35:43 +0200 (EET)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Sun, 22 Feb 2009 05:35:43 +0200 (EET)
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

This problem only occurs when samples very close to min/max limits is 
played. Sounds like integer overflows to the other side. My sample data 
is correct (not overflowing itself), but apparently ALSA has stricter 
limits.

I'm using device hw:Intel, so ALSA shouldn't be doing any sample format 
conversions. Thus I suspect that this might be a fault (a feature) of 
the hardware itself.

Can anyone confirm this?

Playing in 16 bit mode there is no problem and even -32768 seems to be 
playing properly.
