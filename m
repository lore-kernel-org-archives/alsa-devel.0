From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC] Add scenario management
Date: Fri, 02 Oct 2009 11:45:08 +0100
Message-ID: <1254480308.5833.15.camel@odin>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<s5hws3egnwc.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0910021113500.31529@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id BCF051039A1
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 12:45:10 +0200 (CEST)
Received: by ewy25 with SMTP id 25so1027903ewy.45
	for <alsa-devel@alsa-project.org>; Fri, 02 Oct 2009 03:45:10 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910021113500.31529@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Stefan Schmidt <stefan@datenfreihafen.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 2009-10-02 at 11:58 +0200, Jaroslav Kysela wrote:

> 
> I'm not very persuaded to merge such thing to alsa-lib (at least not to 
> alsa-lib.so file - I may accept another library in the alsa-lib package). 
> My comments:
> 
> 1) configuration syntax
> 
>     - I know, simple text files are fine, but there are some structured
>       things - we have already configuration parsers in alsa-lib for
>       structured texts which can be migrated to XML some day
> 

I know XML is great for parsing but the main audience for this is
embedded users so we need to keep it simple (and small) with few
external dependencies. Not all embedded devices will ship with XML.

Liam
