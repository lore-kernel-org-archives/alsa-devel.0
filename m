From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ascenario: Add scenario support to alsa-lib
Date: Wed, 7 Oct 2009 11:47:19 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910071113490.31529@eeebox2.perex-int.cz>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<1254390436-5283-2-git-send-email-stefan@datenfreihafen.org>
	<20091001122835.GC14417@sirena.org.uk>
	<20091001131948.GA5936@excalibur.local>
	<20091001150849.GE5936@excalibur.local>
	<20091005082747.GA3983@excalibur.local>
	<alpine.LNX.2.00.0910051111220.31529@eeebox2.perex-int.cz>
	<20091005093502.GC3983@excalibur.local>
	<alpine.LNX.2.00.0910060949070.31529@eeebox2.perex-int.cz>
	<s5hzl847w3q.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910061048410.31529@eeebox2.perex-int.cz>
	<s5hws387um7.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910070948210.31529@eeebox2.perex-int.cz>
	<s5hk4z71t8g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 964B1103890
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Oct 2009 11:47:19 +0200 (CEST)
In-Reply-To: <s5hk4z71t8g.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Ian Molton <ian@mnementh.co.uk>, Graeme Gregory <gg@slimlogic.co.uk>, Stefan Schmidt <stefan@datenfreihafen.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Oct 2009, Takashi Iwai wrote:

>> But regarding goto, I'm really stuck. We can add some block control:
>>
>> BEGIN="" .. END="" (looks like a goto anyway)
>
> Hm, still not much improvement, indeed.
>
>> Or skip some lines:
>>
>> SKIPLINES="3"
>
> Oh, no!  I don't want to debug a DSP assembly :)
>
>> But these solutions do not bring much readability. Another possibility
>> (compromise) is to use a goto command to skip all lines to next label to
>> reduce usage of named labels (which is not a big fun at least in
>> init/default file):
>>
>> GOTO=""
>> ....
>> LABEL=""
>>
>> It works without any code change in current parser.
>
> I'm afraid that udev config is way too simple for the conditionals.

There are plenty conditionals in udev configuration files. That was main 
reason to use this syntax for alsactl.

> And we do need conditionals to handle many cases.  XML can do better
> for such a purpose, but moving to XML now is another question...

Really better? XML is good for static data but not for non-linear 
execution. Take look to HTML/Javascript. Javascript is doing the 
non-linear stuff and eventually modifies XML at runtime. We have similar 
situation in alsa-lib. The syntax structure is changed at runtime 
depending on external data. But it requires some system resources 
(memory).

Things why I chose udev-like syntax:

- well known "key operator value" syntax
- very easy to parse
- parser reads and executes code directly without storing the source
   or portions to memory (really small memory usage)
- normal conditions are really small in syntax files

If only the goto command is major drawback, I can live with it.

We need to take account the useability and the implementation complexity. 
I think a compromise is essential.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
