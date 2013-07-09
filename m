From: Adam Williamson <awilliam@redhat.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Tue, 09 Jul 2013 11:52:01 -0700
Message-ID: <e5ca1ccabde8f87ee5d2dd6d83eaf90c@www.happyassassin.net>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
 <51D6B56D.8050909@gmail.com> <s5h1u7dchqh.wl%tiwai@suse.de>
 <020e0ad5107eb4c2bb333468be58d7d3@www.happyassassin.net>
 <51D9F543.2070605@gmail.com> <s5hfvvpbhq1.wl%tiwai@suse.de>
 <91b0aa0dcd8a1402fe547271f7464b25@www.happyassassin.net>
 <s5hr4f8vp4q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by alsa0.perex.cz (Postfix) with ESMTP id C359726561E
 for <alsa-devel@alsa-project.org>; Tue,  9 Jul 2013 20:52:08 +0200 (CEST)
In-Reply-To: <s5hr4f8vp4q.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Tormen <my.nl.abos@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 2013-07-08 12:16, Takashi Iwai wrote:

>> Typo: "exiting" instead of "existing" near the end.
> 
> Thanks, I'll fix it in the final commit.
> 
>> I'll test this on my affected system if I can get it to apply against
>> 3.9 - thanks!
> 
> Let me know if it really works.  It seems working on emulator, at
> least :)

Unfortunately it's turning out not to be simple: the patch doesn't apply 
cleanly against 3.9. It applies fine against 3.10, but I can't use a 
Rawhide-derived 3.10 kernel on F18 very easily for 
$BORING_FEDORA_REASONS. I could sort this out, it's just a bit more of a 
PITA than I want to deal with right ATM. If Tormen can't test soon I'll 
work around it somehow.
-- 
Adam Williamson
Fedora QA Community Monkey
IRC: adamw | Twitter: AdamW_Fedora | identi.ca: adamwfedora
http://www.happyassassin.net
