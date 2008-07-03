From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 2/2] wss: use stuct snd_wss instead
	of	snd_ad1848
Date: Thu, 03 Jul 2008 19:07:38 +0200
Message-ID: <486D075A.1090409@keyaccess.nl>
References: <20080701201411.e7715d83.krzysztof.h1@poczta.fm>	<s5hprpvs2l6.wl%tiwai@suse.de>	<486CACF8.7010607@keyaccess.nl>
	<s5hk5g3rv7v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FC9B24956
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jul 2008 19:06:25 +0200 (CEST)
In-Reply-To: <s5hk5g3rv7v.wl%tiwai@suse.de>
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

On 03-07-08 14:46, Takashi Iwai wrote:

> At Thu, 03 Jul 2008 12:42:00 +0200,
> Rene Herman wrote:

>> Yes these should probably grow as a series with somewhat of a (semi-) 
>> final result being apparent after applying patch N of N. I'm importing 
>> Krzysztof' patches into a "wss" branch in my local git tree and will be 
>> testing them as they come in though -- and frankly, I think it's better 
>> if they come in as he does them a few at a time rather than a large 
>> number at once as it's easier for review purposes.
> 
> Well, I can keep it in a branch if you prefer.  Just let me know.

If that is to me specifically, I don't really care. "git am" is a very 
useful tool.

>> But as far as I'm concerned you could just sit back until the series is 
>> somewhat "complete".
> 
> OK.  As 2.6.26 will come out soon, it's a bit too late to include
> such a big change for 2.6.27.  So we have still some time :)

If Krzysztof is anything like me, he's not mucking around with ISA stuff 
due to compatibility with deadlines, so there's even going to be kernels 
after 2.6.28 I'd say... :-)

Rene.
