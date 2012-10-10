From: Da Fox <da.fox.mail@gmail.com>
Subject: Re: Bug 48381 - [Regression][Bisected]Sound gets
 permanently muted a few minutes after booting
Date: Wed, 10 Oct 2012 17:54:12 +0200
Message-ID: <CAMNub_axJpZUiHUe53U9=zvkuOHSAZUkuJSfE58enrEB6DoE+g@mail.gmail.com>
References: <CAMNub_Z-92W6ZWxpPPprWCOQpO9er2FXwVVpD4xMB8v6rFZvXQ@mail.gmail.com>
 <50757632.2070900@canonical.com>
 <CAMNub_Z3K-u2ENNgSsEAxqr4URgBcgySVw152Nw1oxw0PW+JcQ@mail.gmail.com>
 <5075882B.6030002@canonical.com> <s5hk3uycqb7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 098B426161D
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 17:54:33 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id z49so399771wey.38
 for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2012 08:54:32 -0700 (PDT)
In-Reply-To: <s5hk3uycqb7.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 10, 2012 at 5:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Wed, 10 Oct 2012 16:37:31 +0200,
> David Henningsson wrote:
>>
>> [1  <text/plain; ISO-8859-1 (7bit)>]
>> On 10/10/2012 03:39 PM, Da Fox wrote:
>> > Dear Ben,
>>
>> Actually, it's David :-)
Whoopsy, I'm sorry for the mix-up! I was probably (trying to)
multi-task too much :)

>> > I mostly use mplayer to play audio and video files, using the 'alsa'
>> > output driver.
>> > I have attached the requested information to the bugtracker in full,
>> > the following is a quick diff of the two files:
>>
>> After some attempts I think was able to find the culprit. Please test
>> the attached patch and see if it resolves the problem.
>
> I queued it now since the patch looks obviously correct.

I've tested David's patch (applied on top of plain kernel v3.6), and
confirm that this fixes the issue. Auto-mute when plugging in
headphones still works as expected too. Thank you for the quick fix!
Will you be closing the bug at the kernel's bug-tracker once the fix
is upstream (or should I do it now)?

Best regards,
  Da Fox
