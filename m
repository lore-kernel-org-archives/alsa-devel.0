From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 2/2] wss: use stuct snd_wss instead
	of	snd_ad1848
Date: Thu, 03 Jul 2008 12:42:00 +0200
Message-ID: <486CACF8.7010607@keyaccess.nl>
References: <20080701201411.e7715d83.krzysztof.h1@poczta.fm>
	<s5hprpvs2l6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 6671E248B1
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 12:40:50 +0200 (CEST)
In-Reply-To: <s5hprpvs2l6.wl%tiwai@suse.de>
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

On 03-07-08 12:07, Takashi Iwai wrote:

> At Tue, 1 Jul 2008 20:14:11 +0200,
> Krzysztof Helt wrote:

>> ---
>> Another step toward unification of all WSS compatible
>> chips handling.
> 
> Right, and without the unification, these patches have little merits.
> So far, it's more addition than deletion in total.
> [Your work is greatly appreciated, of course.  I just want to tell
>  that it can't be applied alone without the unification.]

Yes these should probably grow as a series with somewhat of a (semi-) 
final result being apparent after applying patch N of N. I'm importing 
Krzysztof' patches into a "wss" branch in my local git tree and will be 
testing them as they come in though -- and frankly, I think it's better 
if they come in as he does them a few at a time rather than a large 
number at once as it's easier for review purposes.

(by the way, Krzysztof, if them not being applied immediately anyway 
means you'd rather work the series against for example current mainline 
that's fine by me as well)

> BTW, the first patch seems too big for ML, and it can't be applied as
> is (wss.h doesn't exist, etc), in addition to missing Kconfig and 
> Makefile changes.  Could you fix and split to several patches?

They depended on his first two patches:

http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008766.html
http://mailman.alsa-project.org/pipermail/alsa-devel/2008-June/008669.html

But as far as I'm concerned you could just sit back until the series is 
somewhat "complete".

Rene.
