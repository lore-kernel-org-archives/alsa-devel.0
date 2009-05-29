From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>
Subject: Re: Roland/Edirol M-16DX
Date: Fri, 29 May 2009 13:53:04 +0300
Message-ID: <4A1FBE90.6040307@trn.iki.fi>
References: <487F10EE.6030405@trn.iki.fi>
	<48883AAC.6060101@ladisch.de>	<49BC62A5.9070103@trn.iki.fi>
	<s5hsklerlsa.wl%tiwai@suse.de>	<4A1DA767.1030909@trn.iki.fi>
	<s5hr5ya1cg3.wl%tiwai@suse.de>	<4A1E6F8B.3000308@trn.iki.fi>
	<s5hzlcwv2ke.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jenni2.inet.fi (mta-out.inet.fi [195.156.147.13])
	by alsa0.perex.cz (Postfix) with ESMTP id E339624368
	for <alsa-devel@alsa-project.org>;
	Fri, 29 May 2009 12:53:25 +0200 (CEST)
In-Reply-To: <s5hzlcwv2ke.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> So, what should we do now?  If you guys are OK to merge even a
> known-to-be-buggy (but somehow works), I'm going to add it.

Either that or remove playback support so that it doesn't offer broken 
functionality. I don't see what the broken playback would be good for, 
except maybe encouraging people to hack ALSA and fix the sync issue.

Most importantly make sure that hardware support databases don't mark 
this device as fully operational.
