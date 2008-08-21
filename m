From: Manuel Schneider <manuel.schneider@kanal-ratte.de>
Subject: Re: Swissonic TS22PCI / Teratec Phase 22
 /	driver	problems with ice1724
Date: Thu, 21 Aug 2008 11:34:19 +0200
Message-ID: <48AD369B.1080805@kanal-ratte.de>
References: <48A4332E.4070704@kanal-ratte.de>	<s5habff1zft.wl%tiwai@suse.de>	<48A43A2A.7050701@kanal-ratte.de>	<s5h63q31yoh.wl%tiwai@suse.de>	<48A43C11.10904@kanal-ratte.de>	<s5hzlnfznty.wl%tiwai@suse.de>	<48ABBEFB.7050406@kanal-ratte.de>
	<s5h7iaabuhl.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mastersmail.com (mx1.mastersmail.com [195.114.98.122])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D76F24473
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 11:34:22 +0200 (CEST)
In-Reply-To: <s5h7iaabuhl.wl%tiwai@suse.de>
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

Takashi Iwai schrieb, Am 21.08.2008 11:14:

> 
> OK, then I can add TS22PCI entry as phase22 compatible.




yes, you can do that. On x86 both recording and playback is just fine.

>> Suspecting a hardware problem with this individual card I replaced it, 
>> but the problem persists with other cards which worked fine in the x86 
>> systems. I also copied over /etc/modules.d/alsa, /etc/asound.conf and 
>> /var/lib/alsa/asound.state from the other system - just to be sure.
> 
> How is the problem?  Still only the recording doesn't work while
> playback is OK as you described before?
> 
> And which "other cards"?  Another TS88PCI?



Another TS22PCI. I've got three of them - one to replace the broken
Phase 22 in the server (which doesn't work) and two others for x86
systems which work fine.
To exclude a hardware problem with this specific card I've put into the
server I replaced the three cards but the server still has the same problem.
Unfurtunatly it is a problem for me to check playback due to missing
equipment at the server rack to plug into the sound card to check it. I
will look for a solution. The server is at a remote place so I mostly
have only ssh access to it.

Is there any other information I can provide for you to help finding the
problem?

Greets,


Manuel

-- 
Kanal Ratte 104,5 MHz
...das Freie Radio im Wiesental

Hauptstrasse 82
79650 Schopfheim

Tel: +49 7622 6692-53
Fax: +49 7622 6692-54
