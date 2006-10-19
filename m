From: <mariook@wp.pl>
Subject: Re: [PATCH] Asus A6RP and ALC861
	headphones	problem	solved
Date: Fri, 20 Oct 2006 00:10:46 +0200
Message-ID: <013c01c6f3cb$6dbde530$83030a54@MIREK>
References: <005701c6eb15$be16e590$83030a54@MIREK><s5hlknpr4y0.wl%tiwai@suse.de><015701c6ed53$575da060$83030a54@MIREK><s5hk636kdhb.wl%tiwai@suse.de>
	<s5hejt66aaj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


----- Original Message ----- 
From: "Takashi Iwai" <tiwai@suse.de>
To: <mariook@wp.pl>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Tuesday, October 17, 2006 8:56 PM
Subject: Re: [Alsa-devel] [PATCH] Asus A6RP and ALC861 headphones problem 
solved


> At Wed, 11 Oct 2006 18:45:52 +0200,
> I wrote:
>>
>> At Wed, 11 Oct 2006 18:36:02 +0200,
>> <mariook@wp.pl> wrote:
>> >
>> > ----- Original Message ----- 
>> > From: "Takashi Iwai" <tiwai@suse.de>
>> > To: <mariook@wp.pl>
>> > Cc: <alsa-devel@lists.sourceforge.net>
>> > Sent: Monday, October 09, 2006 3:31 PM
>> > Subject: Re: [Alsa-devel] [PATCH] Asus A6RP and ALC861 headphones 
>> > problem
>> > solved
>> >
>> > > At Sun, 8 Oct 2006 22:10:02 +0200,
>> > > <mariook@wp.pl> wrote:
>> > >>
>> > >> Hi!
>> > >>
>> > >> I finally made it, now can use headphones with my laptop :)
>> > >>
>> > >> My last thread (started on 23 Sep 20:08) about my problem is quite 
>> > >> long,
>> > >> so
>> > >> I decided to make a new one with result of my work - patched
>> > >> patch_realtek.c
>> > >> file.
>> > >>
>> > >> The patch I posted least time was good. The only thing that had to 
>> > >> be
>> > >> changed is to remove this line:
>> > >> .need_dac_fix = 1,
>> > >> from alc861_presets. With this line of code the patch doesn't want 
>> > >> to
>> > >> work.
>> > >
>> > > This implies that the headphone jack is connected to another DAC, 
>> > > most
>> > > likely the side one (0x04).  The right fix would to add .hp_nid = 
>> > > 0x04
>> > > in the preset table.  If 0x04 doesn't work, try 0x05 or 0x06 instead.
>> >
>> > .hp_nid = 0x06 worked (as I understood it's surround nid  - I wrote 
>> > earlier
>> > that in my case hp jack is surr-out (0x09))
>> >
>> > >> There is only one thing that I'm not sure...
>> > >> When channel mode is changed to 6ch the sound is in built-in 
>> > >> speakers,
>> > >> line-in jack and mic jack, but not in hp jack (of course when i plug
>> > >> something to hp jack the sound in built-in speakers disappears). Is 
>> > >> that
>> > >> correct?
>> >
>> > Even with fix described above this is still a problem - when channel 
>> > mode is
>> > set to 6ch the sound in hp jack is not present (the surround output 
>> > goes to
>> > line-in jack, there is also clfe output in mic jack and no output is in 
>> > hp
>> > jack).
>>
>> The stream is set up to hp_nid (0x06) too, regardless of the
>> channel mode.  You can confirm this by compiling with
>> --with-debug=detect option that will show more debug messages.
>> So, it shouldn't be the problem of hp_nid but others.
>>
>> If the no sound comes out, it means either pin is reset to input, or
>> a volume is muted in the route to DAC 0x06 -> hp-jack.  Check
>> /proc/asound/card0/codec#* after ch6 mode.  You can comapre the status
>> with ch6 mode, too, by simply diffing codec#* dumps in the different
>> states.
>
> I still wonder whether the HP output works on 6-channel mode if you
> remove .need_dac_fix = 1 in the preset...

As far as I remember it didn't work...

>> > >> Because each time I make a patch file it doesn't want to work (I 
>> > >> make it
>> > >> with this command: diff -Nuar old.file new.file), I'm sending in
>> > >> attachment
>> > >> compressed patch_realtek.c file (I patched final version 1.0.13 of
>> > >> patch_realtek.c). The only important changes are those connected 
>> > >> with
>> > >> asus-a6rp model, please ignore changes made in parts of code 
>> > >> connected
>> > >> with
>> > >> other models.
>> > >
>> > > Oh no, please send a patch instead.  Otherwise we cannot review and
>> > > check your changes.
>> > >
>> > > What do you mean "it doesn't want to work"?  If you changed a single
>> > > file, you can just create a diff for that file, simply by
>> > > diff -u orig-alsa-kernel/pci/hda/patch_realtek.c \
>> > > new-alsa-kernel/pci/hda/patch_realtek.c
>> >
>> > Ok, patch is in the attachment :)
>>
>> Thanks, but an uncompressed file would be more appreciated :)
>
> I checked the patch now and it looks good.
>
> Could you give a proper summary, changelog and signed-off-by line for
> committing to the upstream?  The remaining small issues can be fixed
> later, too.

Sorry but I don't understand, what changelog? Everything I have changed is 
in patch file.
The problem was with 3 things:
1) the hp jack is 0x09 not 0x0f (0x0f has to be set to vref)
2) hp_nid was wrong, it has to be set to 0x06
3) in 6ch mode surround output (hp jack output) 'jumps' to line-in jack, 
leaving no output in hp jack
What else should I write?

> Thanks,
>
> Takashi
>

Thanks,
Mariusz 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
