From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 01/35] axfer: add an entry point for this
 command
Date: Thu, 15 Nov 2018 01:05:49 +0900 (JST)
Message-ID: <alpine.DEB.2.21.1811150053470.2496@laptop>
References: <20181113062459.DD8F7267A5C@alsa0.perex.cz>
 <20181113064147.13577-1-o-takashi@sakamocchi.jp>
 <s5hefbpdxos.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 5032F267A61
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 17:05:53 +0100 (CET)
Received: by mail-pg1-f170.google.com with SMTP id 70so7560662pgh.8
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2018 08:05:53 -0800 (PST)
In-Reply-To: <s5hefbpdxos.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, 13 Nov 2018, Takashi Iwai wrote:

> On Tue, 13 Nov 2018 07:41:13 +0100,
> Takashi Sakamoto wrote:
>>
>> This commit adds a new command, 'axfer' ('ALSA transfer'), to transfer data
>> frames described in asound.h. This command is intended to replace current
>> aplay. The most of features and command line parameters come from aplay as
>> much as possible, while it has more better feature and code to maintain.
>>
>> This commit adds an entry point for this command. Current option system of
>> aplay is still available, while this command has a sub-command system like
>> commands in iproute2.
>>
>> Currently, two sub-commands are supported; 'list' and 'transfer'. The
>> 'list' sub-command has the same effect as '-l' and '-L' options of aplay.
>> The 'transfer' sub-command has the same effect as the main feature of
>> aplay. For the sub-command system, an option for stream direction is
>> required; '-P' for playback and '-C' for capture. If you create symbolic
>> links to this binary for aplay/arecord, please execute:
>> $ ln -s axfer aplay
>> $ ln -s axfer arecord
>>
>> Actual code for each sub-command will be implemented in later commits.
>>
>> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>
> Although all patches have been merged, below are a few suggestions:
>
> - Please make help working.  It took some time for me until figuring
>  out the fact that the direction option is mandatory, for example.
>
> - The input/output from/to a terminal can be checked via isatty().
>  That allows us to see garbages by a mistakenly started command.

If my understanding is correct, usage of 'isatty(3)' can return error in a 
case that users just run 'axfer transfer -P (-)'. In current 
implementation, axfer continues to call of 'read(2)' and receive '-EAGAIN' 
till receiving teminate signals.

> - A man page.  (I thought Debian mandates it?)

I have a plan to write help/man in this development period, within this 
year.

> In anyway, thanks for your hard work!

Yep. I'm a bit exhausted from this tough work, and need refresh time.
Anyway, thank you for applying this PR.


Regards

Takashi Sakamoto
