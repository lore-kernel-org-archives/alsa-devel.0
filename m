From: Cheng Sun <chengsun9@gmail.com>
Subject: Re: 1.1.4 bug report: dmix fails when using both
 32-bit and 64-bit clients
Date: Thu, 25 May 2017 19:34:23 +0100
Message-ID: <CAG6t6sMgCPH4X4mdo=U-=UQcvO8zALizo5_siSRbCXOmWjQ50A@mail.gmail.com>
References: <CAG6t6sPK9ug-HDs9qRttQZueNUpszByYRJtnQcMLNkQNF4FJoQ@mail.gmail.com>
 <s5h8tllkpwm.wl-tiwai@suse.de>
 <CAG6t6sNzR1a+Z8AiDpkQry5XZ9c6qU3=X_Yz19eChy4V=Kbs=g@mail.gmail.com>
 <s5h37bslwyf.wl-tiwai@suse.de>
 <CAG6t6sO91rfqKHrkACrkiwaxt57pVywJju_Sf+PnUM=HZZ+m_A@mail.gmail.com>
 <s5hshjskdhc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id F3DA12668BF
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 20:34:44 +0200 (CEST)
Received: by mail-io0-f194.google.com with SMTP id m4so21623923ioe.0
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 11:34:44 -0700 (PDT)
In-Reply-To: <s5hshjskdhc.wl-tiwai@suse.de>
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

On 25 May 2017 at 19:17, Takashi Iwai <tiwai@suse.de> wrote:
> On Thu, 25 May 2017 18:51:10 +0200,
> Cheng Sun wrote:
>>
>> On 25 May 2017 at 17:31, Takashi Iwai <tiwai@suse.de> wrote:
>> > On Thu, 25 May 2017 17:43:44 +0200,
>> > Cheng Sun wrote:
>> >>
>> >> On 25 May 2017 14:49, "Takashi Iwai" <tiwai@suse.de> wrote:
>> >> >
>> >> > On Wed, 24 May 2017 21:13:46 +0200,
>> >> > Cheng Sun wrote:
>> >> > >
>> >> > > Hi all,
>> >> > >
>> >> > > The following commit (released in v1.1.4) introduced an issue where a
>> >> > > client compiled against a 32-bit (x86) compile of alsa-lib cannot use
>> >> > > the same dmix as a client compiled against a 64-bit alsa-lib.
>> >> > >
>> >> > >     1a9bd0f0448106b917ae7f7bedccfcbf6ce84802
>> >> > >
>> >> > > The error message is:
>> >> > >
>> >> > >     ALSA lib pcm_dmix.c:1077:(snd_pcm_dmix_open) unable to create IPC
>> >> > > shm instance
>> >> > >
>> >> > > The following forum post (not mine) describes the symptoms of the
>> >> > > issue in more detail (although the git commit the poster specified is
>> >> > > not correct):
>> >> > >
>> >> > >
>> >> https://forums.gentoo.org/viewtopic-p-8072290.html?sid=c2fbca45102933ddf9ca7cf8b6713e56
>> >> >
>> >> > There is a known problem when you mix up two alsa-lib versions because
>> >> > of the changes in dmix shmem struct.  The solution should upgrade all
>> >> > users.
>> >>
>> >> (Apologies for duplicate email --accidentally sent the first reply to the
>> >> wrong address.)
>> >>
>> >> Arch Linux has upgraded both its 32 and 64 bit packages to v1.1.4, and I'm
>> >> still experiencing this problem.
>> >>
>> >> While bisecting the bug I linked against two compiles of the same alsa-lib
>> >> versions each time.
>> >>
>> >> Let me know if I can provide any other information.
>> >
>> > OK, at first to see whether it's the issue of the struct size
>> > mismatch, check the following patch.  If it is, you'll see the error
>> > message.  To be sure, check both cases: 64bit -> 32bit, and 32bit ->
>> > 64bit.
>>
>> The behaviour is different for the two cases.
>>
>> 1) If 64bit client is started first, then the 32bit client prints the following:
>>
>> magic mismatch: shmptr=a15ad4f0, expected=a15ad4ec
>> ALSA lib pcm_dmix.c:1077:(snd_pcm_dmix_open) unable to create IPC shm instance
>>
>> 2) If 32bit client is started first, then the 64bit client only prints:
>>
>> ALSA lib pcm_dmix.c:1077:(snd_pcm_dmix_open) unable to create IPC shm instance
>>
>> I've added some further print statements and it turns out that this is
>> because the "return err;" on line 115 is triggered.
>
> Hm, so at least the struct size difference is a problem.
> Doese the patch below change the behavior?

Your patch did not change the behaviour.

However, as an experiment I added "__attribute__((__packed__))" to the
struct, which fixed the problem. So this does seem to be caused by gcc
padding structs differently when compiling 32-bit vs 64-bit.

I don't think "__attribute__((__packed__))" is necessarily the correct
solution here though.

Cheers,
Cheng
