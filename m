From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Separate default devices for playback and capture
Date: Wed, 19 Sep 2007 03:41:08 +0300
Message-ID: <46F07024.5040903@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pne-smtpout4-sn1.fre.skanova.net
	(pne-smtpout4-sn1.fre.skanova.net [81.228.11.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 927C4243B0
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 02:41:14 +0200 (CEST)
Received: from trn.iki.fi (84.250.48.139) by pne-smtpout4-sn1.fre.skanova.net
	(7.2.075) id 45C775BA00A5DDCF for alsa-devel@alsa-project.org;
	Wed, 19 Sep 2007 02:41:14 +0200
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 550F57A188A72
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 03:41:13 +0300 (EEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 03:41:13 +0300 (EEST)
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

I've been reading the library source code and from what I gather, it
seems that it just fundamentally cannot support separate config sections
for playback and capture.

What should the fix be? I can see three options:

1. allow specifying in asound.conf whether a section is for recording or
playback (needs major redesign of conf.c and some changes in pcm.c).

2. if the name is "default", use "capture" (for example) instead, in
snd_pcm_open_noupdate, maybe reverting to "default" if the other device
cannot be found (dirty, but very easy to implement)

3. tell application developers to use some other device name for
capture: "capture", instead of "default", for example (needs a little
change in every application program that uses ALSA capture).
