From: Swen Wenzel <swen.wenzel@t-online.de>
Subject: Re: Disabled jacks on motherboard 'Gigabyte G1 Sniper
	Z87' (CA0132-based)
Date: Mon, 11 Aug 2014 07:48:48 +0200
Message-ID: <53E85940.1020208@t-online.de>
References: <53E63664.5000005@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout05.t-online.de (mailout05.t-online.de [194.25.134.82])
 by alsa0.perex.cz (Postfix) with ESMTP id EDD1F26506E
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 07:48:56 +0200 (CEST)
Received: from fwd39.aul.t-online.de (fwd39.aul.t-online.de [172.20.27.138])
 by mailout05.t-online.de (Postfix) with SMTP id 96E0E3792C3
 for <alsa-devel@alsa-project.org>; Mon, 11 Aug 2014 07:48:56 +0200 (CEST)
In-Reply-To: <53E63664.5000005@t-online.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Today I got different codec information. Now the headphone jack on the 
front was the only one working.
Here is the updated alsa information:
http://www.alsa-project.org/db/?f=c1fe9533df93a4b119cfcbe5a8f5b66dbfd50768
I have no idea what changed my system... the only thing I did was 
installing Skype, but it is not running atm.

On 09.08.2014 16:55, Swen Wenzel wrote:
> Hello guys,
>
> I own the motherboard mentioned in the subject and experienced 
> problems when I tried to get it to work.
> After some conversation <http://pastebin.com/HnmxuU1Q> in IRC we found 
> out, that probably the jack I used was deactivated. I had to use the 
> lineout jack instead of the headphone/speaker jack.
> However the headphone/speaker jack could be enabled to give the same 
> output as the lineout jack with 'hda-verb'.
> Here is my alsa information:
> http://www.alsa-project.org/db/?f=8f57f0b72d65046469b8b6ce8a57ff6fe0371769
>
> Maybe you can have a look at it. You can also always contact me if you 
> have further questions or want me to try something out.
> I am also a programmer, and studied something related to computer 
> science so you don't have to fear completely useless answers or too 
> dumb questions. :D
>
> kind regards
> Swen
