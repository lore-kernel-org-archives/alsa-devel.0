From: Giuliano Pochini <pochini@denise.shiny.it>
Subject: Re: [PATCH 1/2] Echoaudio: Add support for Indigo
 express cards
Date: Wed, 18 Mar 2009 13:06:53 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0903181305360.6253@denise.shiny.it>
References: <20090315213642.6a841b73.pochini@shiny.it>
	<s5hk56psygs.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0903160908170.22078@denise.shiny.it>
	<s5hy6v3m7qi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	by alsa0.perex.cz (Postfix) with ESMTP id 42FED1037EC
	for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2009 13:06:51 +0100 (CET)
In-Reply-To: <s5hy6v3m7qi.wl%tiwai@suse.de>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



On Wed, 18 Mar 2009, Takashi Iwai wrote:

> Hi Giuliano,
>
> At Mon, 16 Mar 2009 09:14:20 +0100 (CET),
> Giuliano Pochini wrote:
>>
>> On Mon, 16 Mar 2009, Takashi Iwai wrote:
>>
>>>> This patch adds support for IndigoIOx and IndigoDJx.
>>>>
>>>> Signed-off-by Giuliano Pochini <pochini@shiny.it>
>>>
>>> The code looks almost good, but could you do the following?
>>>
>>> - split to two patches, one for kernel tree and one for alsa-driver
>>>  tree
>>
>> There is a little problem: since about a month ago the git server is
>> SLOWWW. It takes ages to download the alsa-kernel repository at 5KB/s :(
>> I'll try from some server at work which stay on 24/7.
>>
>>
>>> - run checkpatch.pl against the patch and fix issues reported there
>>
>> Ok !
>
> Any progress on this?  I'm asking it because 2.6.29 kernel will likely
> go out soon, and all patches should be merged before the merge-window
> is opened.
>
> If you have no time, either we skip it or I'll do a quick fix.

I have little time except in the week end. Btw, I'll try to do the work 
this night.


--
Giuliano.
