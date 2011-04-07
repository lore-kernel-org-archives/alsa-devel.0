From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Conexant CX20585 recording does not work
Date: Thu, 07 Apr 2011 16:31:34 +0200
Message-ID: <4D9DCAC6.9070803@canonical.com>
References: <10033.91.152.175.130.1302179699.squirrel@go-nix.ca>	<4D9DB125.6010600@canonical.com>
	<10176.91.152.175.130.1302182475.squirrel@go-nix.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A58D61038AB
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 16:31:37 +0200 (CEST)
In-Reply-To: <10176.91.152.175.130.1302182475.squirrel@go-nix.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gabriel Schulhof <nix@go-nix.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2011-04-07 15:21, Gabriel Schulhof wrote:
> Hi!
>
> On Thu, April 7, 2011 15:42, David Henningsson wrote:
>> Please try the model quirk "hp-laptop". In Ubuntu that would be adding
>> the line:
>>
>> options snd-hda-intel model=hp-laptop
>>
>> to the file /etc/modprobe.d/alsa-base.conf
>
> Tried it. It did streamline the options available in alsamixer, but it
> didn't make recording work.
>
> I tried the skype test call, as well as arecord, and both did not only not
> record anything, but they didn't even record static. That is, the
> recording device seems to block! For example, the skype test call beeps
> before it plays back my recorded voice, and afterwards. Well, the two
> beeps were consecutive for me :(
>
> Also, arecord with no options outputs to the terminal. It output the
> header for the sound file, but the cursor did not start to fly across the
> terminal drawing all kinds of junk.
>
> Thanks a lot for your help,

I saw you had an AMD/ATI controller of the type we're discussing in 
parallel in the thread about "HDA record fails with FIFO error", it 
might be that you're bitten by that bug as well...

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
