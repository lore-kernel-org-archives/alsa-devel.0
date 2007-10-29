From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Testers Wanted: OPL3 hwdep loader interface
Date: Mon, 29 Oct 2007 19:30:01 +0100
Message-ID: <472626A9.4050509@keyaccess.nl>
References: <s5hfxzyoxvf.wl%tiwai@suse.de>	<47223817.7060508@keyaccess.nl>	<472273AC.9020702@keyaccess.nl>	<1193643700.13559.1218328069@webmail.messagingengine.com>	<s5hir4qnvcr.wl%tiwai@suse.de>	<47260F8B.5010406@keyaccess.nl>
	<s5hd4uylzt3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 84655244E5
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 19:33:15 +0100 (CET)
In-Reply-To: <s5hd4uylzt3.wl%tiwai@suse.de>
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

On 10/29/2007 04:12 PM, Takashi Iwai wrote:

>> Do you by the way know of other, nicer and/or better patches than the 
>> supplied std and drums? Couldn't find any, at least not in the correct 
>> format it seems.
> 
> Hm, I don't know of others.  It'd be fun to play with OPL3 parameter
> adjustment, though ;)

I was thinking of whether or not the standard patches shouldn't simple be 
builtin but anyone playing with an OPL3 these days is sort of by definition 
going for the geekness factor I guess. From that viewpoint, external patches 
do sound better...

>> [ README ]
>>
>>> -	sbiload --opl3 std.o3 drums.o3 
>>> +	% sbiload std.o3 drums.o3
>> Should the example indeed lose the --opl3?
> 
> With the patch in the previous mail, yes, it's needed.
> But my latest version that will be committed doesn't need --opl3
> option.  You can invoke like
> 
> 	% sbiload std drums
> 
> and the format and the extension will be chosen automatically
> according to the hwdep iface type.

Sounds great (assuming that I'll still be able to load the .sb patches into 
my OPL3 by just specifying std.sb and drums.sb ofcourse).

I believe that at that point you by the way might also make a simple 
"sbiload" enough, with the names defaulting to "std" and "drums"...

(and a -2 switch to pick std.sb and drums.sb even on an OPL3)

Rene.
