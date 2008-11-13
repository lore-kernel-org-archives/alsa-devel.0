From: Andrei Tanas <andrei@tanas.ca>
Subject: Re: Asus P5QL-EM motherboard (ALC1200 codec) - no
 sound through S/PDIF
Date: Thu, 13 Nov 2008 09:35:42 -0500
Message-ID: <c9f2936074ce510b2b140aa3a1efde33@localhost>
References: <668af2a1e877d41c059f6c84fa462476@localhost>
	<1226564212.605116.29828@de>
	<9b7acddf9b27fdc3fea4444c2db912cf@localhost>
	<dfbb90e1b88698b6b74f8d59fa20600c@localhost>
	<s5hljvnhfde.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tanas.ca (tanas.ca [206.248.136.31])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B61824572
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 15:35:44 +0100 (CET)
Received: from tanas.ca (localhost [127.0.0.1])
	by tanas.ca (Postfix) with ESMTP id 073461C68472
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 09:35:43 -0500 (EST)
Received: from mail.unchanged.net (localhost [127.0.0.1])
	by tanas.ca (Postfix) with ESMTP id DF51B1C68471
	for <alsa-devel@alsa-project.org>; Thu, 13 Nov 2008 09:35:42 -0500 (EST)
In-Reply-To: <s5hljvnhfde.wl%tiwai@suse.de>
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

On Thu, 13 Nov 2008 15:25:49 +0100, Takashi Iwai <tiwai@suse.de> wrote:
> This should be a bug of alsa-lib.  The latest version shouldn't show
> this entry any more.

Yes, you're right. This is "aplay -L" with alsa-lib 1.0.18
default:CARD=Intel
    HDA Intel, ALC1200 Analog
    Default Audio Device
front:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    Front speakers
surround40:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    4.0 Surround output to Front and Rear speakers
surround41:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Analog
    7.1 Surround output to Front, Center, Side, Rear and Woofer speakers
iec958:CARD=Intel,DEV=0
    HDA Intel, ALC1200 Digital
    IEC958 (S/PDIF) Digital Audio Output
null
