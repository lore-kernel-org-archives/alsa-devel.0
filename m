From: d <dieb13@klingt.org>
Subject: Re: hdsp9652+alsamixer -> kernel panic
Date: Thu, 29 May 2003 18:46:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ED63954.2070603@klingt.org>
References: <E19LQBJ-00080C-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19LQBJ-00080C-00@sc8-sf-list1.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Kai Vehmanen <kai.vehmanen@wakkanet.fi>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Paul Davis wrote:
>>>ah. are you running on an SMP system with current ALSA CVS? if so, its
>>>broken within the "core" of ALSA. you will need to back up to April
>>>27th to get a working SMP version. nobody has a fix for this at this
>>>time, despite the fact that it makes ALSA unusable on an SMP system.
>>
>>Hmm, anyway to easily and reliably reproduce the bug?

sorry for all the noise on the list.
i am running a singleprocessor system, but forgot to turn off the smp 
support in the kernel config. now - after recompiling everything- the 
kernel doesn't panic any more when i adjust the output-levels, but i 
still get nothing but silence from my card.

regards
d13b





-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
