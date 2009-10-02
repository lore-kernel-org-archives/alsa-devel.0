From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [RFC] Add scenario management
Date: Fri, 2 Oct 2009 13:03:20 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0910021255250.31529@eeebox2.perex-int.cz>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<s5hws3egnwc.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910021113500.31529@eeebox2.perex-int.cz>
	<1254480308.5833.15.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 39AA810397B
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 13:03:22 +0200 (CEST)
In-Reply-To: <1254480308.5833.15.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Stefan Schmidt <stefan@datenfreihafen.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2 Oct 2009, Liam Girdwood wrote:

> On Fri, 2009-10-02 at 11:58 +0200, Jaroslav Kysela wrote:
>
>>
>> I'm not very persuaded to merge such thing to alsa-lib (at least not to
>> alsa-lib.so file - I may accept another library in the alsa-lib package).
>> My comments:
>>
>> 1) configuration syntax
>>
>>     - I know, simple text files are fine, but there are some structured
>>       things - we have already configuration parsers in alsa-lib for
>>       structured texts which can be migrated to XML some day
>>
>
> I know XML is great for parsing but the main audience for this is
> embedded users so we need to keep it simple (and small) with few
> external dependencies. Not all embedded devices will ship with XML.

I don't mean to use a complex XML parsing library with DOM handling. I 
wrote very simple XML parser in C on few hundred lines for another 
project so it's no issue also for the embedded platform. I just wanted to 
point - the structure of alsa-lib configuration files is very similar to 
XML.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
