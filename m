From: Daniel Mack <zonque@gmail.com>
Subject: Re: [Alsa-user] Master volume control
Date: Wed, 13 Mar 2013 18:11:25 +0100
Message-ID: <5140B33D.4030406@gmail.com>
References: <B3AC1EE66F1142FF99DDC145B8669DDD@PAULD>
 <512F0AF5.3050502@googlemail.com> <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 7635026257E
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 18:11:39 +0100 (CET)
Received: by mail-bk0-f54.google.com with SMTP id w5so590396bku.13
 for <alsa-devel@alsa-project.org>; Wed, 13 Mar 2013 10:11:38 -0700 (PDT)
In-Reply-To: <DB754736B2E5480F987C1DE8E330AC7C@PAULD>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Paul D. DeRocco" <pderocco@ix.netcom.com>
Cc: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 13.03.2013 17:47, Paul D. DeRocco wrote:
>> From: Clemens Ladisch [mailto:cladisch@googlemail.com] 
>>
>> #include <stdio.h>
>> #include <stdlib.h>
>> #include <alsa/asoundlib.h>
>>
>> static void check(int err, const char *f)
>> {
>>         if (err < 0) {
>>                 fprintf(stderr, "%s failed: %s\n", f, 
>> snd_strerror(err));
>>                 exit(EXIT_FAILURE);
>>         }
>> }
>> #define CHECK(f) check(f, #f)
>>
>> int main()
>> {
>>         snd_ctl_t *ctl;
>>         snd_ctl_elem_value_t *value;
>>
>>         CHECK(snd_ctl_open(&ctl, "default", 0));
>>
>>         snd_ctl_elem_value_alloca(&value);
>>         snd_ctl_elem_value_set_interface(value, 
>> SND_CTL_ELEM_IFACE_MIXER);
>>         snd_ctl_elem_value_set_name(value, "Master Playback Volume");
>>         snd_ctl_elem_value_set_integer(value, 0, 42);
>>         CHECK(snd_ctl_elem_write(ctl, value));
>>
>>         snd_ctl_close(ctl);
>>         return 0;
>> }
> 
> Well, I finally got a chance to try this. It "works", but the
> snd_ctl_elem_write call takes a couple of milliseconds (that's around a
> million instructions on my Atom), and it apparently spends this time in
> kernel state, because it causes my sound thread to underrun, so it's not
> usable.

So why are you doing this from your sound thread then?


Daniel


> 
> If I use alsamixer, I don't have this problem; I can manipulate the master
> volume smoothly while I'm playing my synth app. So I went through the
> source, and found that it's using snd_mixer_selem_set_playback_volume. This
> is apparently part of something called the "Simple Mixer Interface", yet
> another section of ALSA which is completely undocumented, other than the
> Doxygen stuff (which is only meaningful as a reference for someone who
> already knows it inside out, but can't remember e.g. whether playback_pcm
> comes before or after capture_pcm in the snd_mixer_selem_regopt structure).
> 
> So what's the minimum I need to do in order to get at the Master Playback
> Volume, via the Simple Mixer Interface?
> 
