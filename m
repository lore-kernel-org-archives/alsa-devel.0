From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Tue, 29 Jul 2008 16:37:08 +0200
Message-ID: <488F2B14.7050704@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>	<4883632A.8090106@keyaccess.nl>	<4887A28F.90506@keyaccess.nl>	<20080724072620.4197510c.krzysztof.h1@poczta.fm>	<48884BD4.3010308@keyaccess.nl>	<s5hy73maula.wl%tiwai@suse.de>	<488E1249.7020401@keyaccess.nl>	<s5hd4kwdeso.wl%tiwai@suse.de>	<488F25EE.4080104@keyaccess.nl>
	<s5hsktsbw3v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 57562103920
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Jul 2008 16:34:37 +0200 (CEST)
In-Reply-To: <s5hsktsbw3v.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@poczta.fm>
List-Id: alsa-devel@alsa-project.org

On 29-07-08 16:31, Takashi Iwai wrote:

>> 2) debug printks
>>
>> For one example here, see:
>>
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2008-July/008978.html
>>
>> /snd_wss_debug
>>
>> Bad, bad, triply bad.
> 
> This change is actually buggy.  Each second printk should have no
> KERN_* prefix.  KERN_* prefix is only for the beginning of the line.

See how these formatting "fixes" made me miss that? ;-)

> A more better fix would be to rewrite this to use a loop, BTW.

Rene.
