From: Tormen <my.nl.abos@gmail.com>
Subject: Re: No sound with Sony VAIO VPCZ1 (ALC889)
Date: Fri, 05 Jul 2013 14:00:45 +0200
Message-ID: <51D6B56D.8050909@gmail.com>
References: <51D464A5.6040507@gmail.com> <51D59D60.9020105@gmail.com>
 <51D5FCFC.8010506@gmail.com> <s5hip0pwp49.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id CC6D2264EBF
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2013 14:00:50 +0200 (CEST)
Received: by mail-we0-f173.google.com with SMTP id x54so1921188wes.32
 for <alsa-devel@alsa-project.org>; Fri, 05 Jul 2013 05:00:50 -0700 (PDT)
In-Reply-To: <s5hip0pwp49.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Adam Williamson <awilliam@redhat.com>
List-Id: alsa-devel@alsa-project.org

Hi,

Thanks for your answer! :))

On 05/07/13 07:29, Takashi Iwai wrote:
> At Fri, 05 Jul 2013 00:53:48 +0200,
> Tormen wrote:
>> Hi again,
>>
>> I digged again into google and stumbled across this thread from a year ago:
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2012-March/050504.html
>>
>> I have the same Notebook than Adam.
>>
>> The thread stopped there. I contacted Adam and he confirmed me something
>> I also had noticed (but forgotten):
>>       The sound output via the speakers broke (went silent) between 3.1
>> and 3.2.
>>       It was working though for sometime between 3.2 and 3.9.6 - I
>> confirmed it to be working in 3.7!
>>       And now it is broken again.
> So, the speaker worked on *your* machine with 3.7 kernel?
Yes.

> Then I need alsa-info.sh output in the working state.
*WORKING* sound (speakers play sound and everything else (from what I've 
seen so far) seems as it should)
uname -a:
Linux seven 3.7-trunk-amd64 #1 SMP Debian 3.7.8-1~experimental.1 x86_64 
GNU/Linux
http://www.alsa-project.org/db/?f=3012ed619f55c49b279c24b74a8192f7a3ccd3e3

This was without pulseaudio, without /etc/asound.conf and without any 
kernel module parameters to snd and snd-intel-hda.
I had also tried 3.9.6 under this conditions, but same problem.

I guess you need more debug? Unfortunately alsa-compile complained that 
the linux-source-3.7 package vanished in the meantime from experimental.
But I guess I can figure that out if you need more debug output (as in 
the debian 3.7 kernel image I am using CONFIG_SND_DEBUG is not set).

> Didn't you read my previous reply...? 
Sorry, I had missed it.

> Give alsa-info.sh outputs (don't paste, use attachments). At best, 
> give the outputs from both working and non-working kernels. Without 
> these, I cannot debug further. thanks, Takashi 
*NON-working* sound (speakers don't play any sound, headphone out works 
fine)
uname -a:
Linux seven 3.9-0.bpo.1-amd64 #1 SMP Debian 3.9.6-1~bpo70+1 x86_64 GNU/Linux
http://www.alsa-project.org/db/?f=af6f9823cfa865872e84f9d4da569b2a72b071b0

This is the debian 3.9.6 kernel + alsa-compile to get "debug=2" for 
snd.ko module to work as by default the CONFIG_SND_DEBUG is not set in 
debian kernels.

Hope that helps, please let me know.

Tormen.
