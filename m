From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: Re: Mixer regression with usb soundcard
Date: Tue, 19 Dec 2017 02:19:30 +0900
Message-ID: <CAL6iAaJVVVow45P=+whSnog+THH0CqW7ZdAYmegbd7byqCFUxg@mail.gmail.com>
References: <0f95a1cc-c438-ca4e-cc5f-d311e33a496e@gmail.com>
 <20171218134444.GA18133@kroah.com> <s5hy3m0dtw0.wl-tiwai@suse.de>
 <bd3f1487-d703-77b4-aca3-c6e15f0e18a8@gmail.com>
 <s5ha7ygdoqb.wl-tiwai@suse.de>
 <9dff0299-5621-2670-50b6-ee1851bb40f4@gmail.com>
 <s5htvwoc63f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f194.google.com (mail-io0-f194.google.com
 [209.85.223.194])
 by alsa0.perex.cz (Postfix) with ESMTP id B4F0C267544
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 18:19:32 +0100 (CET)
Received: by mail-io0-f194.google.com with SMTP id x67so4462681ioi.9
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 09:19:32 -0800 (PST)
In-Reply-To: <s5htvwoc63f.wl-tiwai@suse.de>
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
Cc: Mauro Santos <registo.mailling@gmail.com>, alsa-devel@alsa-project.org, USB list <linux-usb@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>
List-Id: alsa-devel@alsa-project.org

2017-12-19 2:13 GMT+09:00 Takashi Iwai <tiwai@suse.de>:
> On Mon, 18 Dec 2017 18:05:18 +0100,
> Mauro Santos wrote:
>>
>> On 18-12-2017 15:45, Takashi Iwai wrote:
>> > On Mon, 18 Dec 2017 16:30:13 +0100,
>> > Mauro Santos wrote:
>> >>
>> >> On 18-12-2017 13:53, Takashi Iwai wrote:
>> >>> On Mon, 18 Dec 2017 14:44:44 +0100,
>> >>> Greg KH wrote:
>> >>>>
>> >>>> On Sun, Dec 17, 2017 at 06:56:05PM +0000, Mauro Santos wrote:
>> >>>>> I believe this is the right place to report this problem, but if it
>> >>>>> isn't please point me in the right direction.
>> >>>>
>> >>>> Adding the developer of that patch, and the sound maintainer and
>> >>>> developers to the thread.
>> >>>>
>> >>>>> I have noticed that after the update from kernel 4.14.5 to 4.14.6
>> >>>>> alsamixer does not show the usual volume controls for my usb soundcard.
>> >>>>>
>> >>>>> Reverting 3884d12e17ab770aa0f5d4bc65bfbfd006f417fa ALSA: usb-audio: Add
>> >>>>> check return value for usb_string() (from linux-stable) makes the
>> >>>>> controls come back again with kernel 4.14.6.
>> >>> (snip)
>> >>>>
>> >>>> This is odd, Takashi, I thought we fixed up the problem that if the
>> >>>> string was invalid, the code would continue to go on, it's not a "real"
>> >>>> error.  Did that not get marked for the stable trees?
>> >>>
>> >>> Yes, it was marked as stable, and it's odd that the revert of the
>> >>> given commit changes the behavior in that way.
>> >>>
>> >>> Mauro, could you double-check whether reverting the commit really does
>> >>> fix it as expected?  If yes, could you put some debug print at the
>> >>> part the patch touches, and check which unit id gives len=0 from
>> >>> snd_usb_copy_string_desc()?
>> >>
>> >> I'm sure reverting that patch makes things work as expected. I noticed
>> >> the problem after an update and that is the only thing I revert on top
>> >> of the kernel provided by the distro (Arch Linux).
>> >
>> > Did you revert only one patch, not both patches?
>> > Just to be sure.
>>
>> I have reverted only one patch.
>>
>> >> Alsamixer works fine for the built in soundcard in my laptop, but the
>> >> mixer for the usb soundcard was not working so it's specific to usb and
>> >> only 2 patches touch the mixer.c file between 4.14.5 and 4.14.6. I've
>> >> tried reversing both, one at a time, and only reverting this one
>> >> restored the expected behavior.
>> >>
>> >> Regarding adding the debug print I'm going to need guidance. Without
>> >> reverting anything, would adding at line 2178 of sound/usb/mixer.c the
>> >> following be enough?
>> >>
>> >> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>> >>
>> >> It would then look like this (minus the line wrapping):
>> >> len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>> >> printk("usbmixdbg: nameid=%d len=%d id.name=%s\n",nameid,len,kctl->id.name);
>> >> if (len)
>> >
>> > Well, at that point, there should be no difference.
>> > The difference is after that, so what I'd like to see is something
>> > like:
>> >
>> > --- a/sound/usb/mixer.c
>> > +++ b/sound/usb/mixer.c
>> > @@ -2175,14 +2175,18 @@ static int parse_audio_selector_unit(struct mixer_build *state, int unitid,
>> >
>> >     nameid = uac_selector_unit_iSelector(desc);
>> >     len = check_mapped_name(map, kctl->id.name, sizeof(kctl->id.name));
>> > +   pr_info("XXX id=%d, check_mapped_name=%d\n", id, len);
>> >     if (len)
>> >             ;
>> > -   else if (nameid)
>> > +   else if (nameid) {
>> >             len = snd_usb_copy_string_desc(state, nameid, kctl->id.name,
>> >                                      sizeof(kctl->id.name));
>> > -   else
>> > +           pr_info("XXX id=%d, copy_string=%d\n", len);
>> > +   } else {
>> >             len = get_term_name(state, &state->oterm,
>> >                                 kctl->id.name, sizeof(kctl->id.name), 0);
>> > +           pr_info("XXX id=%d, get_term_name=%d\n", len);
>> > +   }
>> >
>> >     if (!len) {
>> >             strlcpy(kctl->id.name, "USB", sizeof(kctl->id.name));
>> >
>> >
>> > If you see copy_string=0, it means that your hardware reports a bogus
>> > entry, and the driver does it correctly.  If ignoring that error
>> > really restores the old behavior back, it essentially means that it
>> > worked casually in the past...
>>
>> I have applied your patch on top of 4.14.7 without reverting anything
>> and I was planning to reply only after I had some result but building
>> failed (without any errors strangely).
>>
>> I took a second look at your patch and I have a (maybe silly/naive)
>> question, don't the second and third pr_info calls need an extra
>> argument? There are two %d in the string but only one variable (len).
>
> Yeah, sure, of course you need them :)
> I haven't tested the patch, but just to give you an idea.
> Sorry if you wasted your time due to that.

OK. I will make a debug patch with you last debug code.

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -656,10 +656,14 @@ static int get_term_name(struct mixer_build
*state, struct usb_audio_term *iterm
                         unsigned char *name, int maxlen, int term_only)
 {
        struct iterm_name_combo *names;
+       int len;

-       if (iterm->name)
-               return snd_usb_copy_string_desc(state, iterm->name,
+       if (iterm->name) {
+               len = snd_usb_copy_string_desc(state, iterm->name,
                                                name, maxlen);
+               if (len)
+                       return len;
+       }

I will come back soon.

>
>
> Takashi
