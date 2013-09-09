From: Ian Munsie <darkstarsword@gmail.com>
Subject: Re: No sound from internal speaker on 2013 Macbook Air
 6, 1
Date: Mon, 9 Sep 2013 18:01:41 +1000
Message-ID: <CAH4=b6Km5E5v18bvKqV661kudaKkpfnHGUWNEeGEY7ngXVARnw@mail.gmail.com>
References: <CAH4=b6KOs-WJ+_KVGiQ4LRC9-3J_A_xK64UcrMq6NZFxyycS_w@mail.gmail.com>
 <CAN8cciZuiRR9=iqkxYLoj==UXqYzEdVM2M85y5vg6zBYArjhSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f169.google.com (mail-ea0-f169.google.com
 [209.85.215.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DA8B264FF0
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 10:02:03 +0200 (CEST)
Received: by mail-ea0-f169.google.com with SMTP id k11so2983512eaj.28
 for <alsa-devel@alsa-project.org>; Mon, 09 Sep 2013 01:02:03 -0700 (PDT)
In-Reply-To: <CAN8cciZuiRR9=iqkxYLoj==UXqYzEdVM2M85y5vg6zBYArjhSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Raymond,

On 26 August 2013 11:55, Raymond Yau <superquad.vortex2@gmail.com> wrote:
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/plain/Documentation/sound/alsa/HD-Audio.txt
>
>  have you try those gpio ?

Thanks for the pointer - I finally got around to trying this (it's not
my primary box) and was able to get the speaker to work by enabling
GPIO 0 as an output with data=1 (i.e. I selected out-dir, enable and
data in hda-analyzer).

I noticed that the GPIO settings would clear when I stopped playing
sound though, so I currently have to run the python script generated
by hda-analyzer every time I want to play a sound through the speaker.
I also noticed that I had to manually set data=0 to turn the speaker
off if I plugged in the headphones.

What is the next step in fixing this properly? I've been meaning to
look through the hda code to figure out how these kind of quirks are
supposed to be handled, but haven't got around to that yet.


> or specify hints primary_hp = false

That did nothing by itself, though come to think of it I didn't try it
in combination with the GPIO settings.


> it is strange that driver select amp at pin complex of headphone as
> headphone volume control instead of amp at audio output ( the number of step
> and dB range of headphone and speaker is different )
>
> you may need to change the logic of look_for_out_vol_nid()  in hda_generic.c

Hmm, the volume control seemed to be working for me with both speakers
& headphones, but I didn't check which control it was actually
changing.


> you may need cs4208 datasheet if the codec need vendor coefff
>
> why virtual master did not warn when the dB range and number of step in
> slaves controls are different ?

Is that something I need to be concerned about? Where should that
warning have appeared?


Cheers,
-Ian

-- 
http://sites.google.com/site/DarkStarJunkSpace
--
http://darkstarshout.blogspot.com/
--
Please avoid sending me Word or PowerPoint attachments.
See http://www.gnu.org/philosophy/no-word-attachments.html
