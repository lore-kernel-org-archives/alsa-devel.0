From: "Konstantin Shaposhnikov" <k.shaposhnikov@gmail.com>
Subject: Re: Conexant test code.
Date: Sun, 5 Nov 2006 14:03:33 +0000
Message-ID: <b12092cb0611050603v89aa3c9vd19cb0ad173e5ad7@mail.gmail.com>
References: <1162633963.24604.163.camel@razman>
	<454DEAFA.3030509@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <454DEAFA.3030509@cse.unsw.edu.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I want to clarify that bugs with alsamixer and alsactl that I have
described occure only with model=test option to the driver.

As for mute button, I think that color of this LED is determined by
mute status of sound card and this functionlaity is implemented in
hardware.

When you press this button soundcard is not muted, such thing should
be implemented programmatically, f.e. you can configure your window
manager to execute alsactl with appropriate parameters on button
click.

Regards,
Konstantin

On 11/5/06, Matthew Strahan <mstrahan@cse.unsw.edu.au> wrote:
> Hi Tobin,
>
> I had the same results for my HP DV2000 (with same subsystem) except for
> me alsactl -f asound.state store worked.  It exits successfully without
> comment.
>
> Funnily enough also for me when I press the mute button it doesn't glow
> orange.  That's hardly an important issue however.
>
> Thanks,
> Matthew
>
> > From: Konstantin Shaposhnikov <k.shaposhnikov <at> gmail.com>
> > Subject: Re: Conexant test code.
> > <http://news.gmane.org/find-root.php?message_id=%3cb12092cb0611040435k38bb2094if074160cc9769ec4%40mail.gmail.com%3e>
> > <http://news.gmane.org/gmane.linux.alsa.devel>
> > Hi Tobin,
> >
> > Below you can find results of my testing of conexant test patch 8.
> >
> > Model: HP pavilion DV2000
> > Subsystem: 103c:30b2
> >
> > Sound and internal microphone is working (as with previous patch)
> >
> > I've alsa noticed following strange behaviour of alsamixer: the first control
> > named "Master" (in previous patches it was named "Headphones") affects only
> > sound in headphones, sound in internal speakers can be modfied only by
> > changing value of PCM control. PCM affects both headphones and internal
> > speaker.
> >
> > >From other side DV2000 has LED button to mute sound, when I mute "Master"
> > control this LED is glowing orange inicating that sound is muted (but actually
> > sound muted only in headphones).
> >
> > Unfortunately I can not test patch with model=test. Alsamixer can not be
> > started and prints following error:
> >    alsamixer: function snd_mixer_load failed: Invalid argument
> > At the same time dmesg says:
> >    hda_codec: num_steps = 0 for NID=0x19
> >
> > When I try to execute following command (from init scripts):
> >    alsactl -f asound.state store
> > I get "unable to handle kernel paging request" error:
> >
> > BUG: unable to handle kernel paging request at virtual address fffffff8
> >  printing eip:
> > f8cc4714
> > *pde = 00004067
> > *pte = 00000000
> > Oops: 0000 [#1]
> > SMP
> > Modules linked in: snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
> > snd_pcm_oss snd_mixer_oss snd_hda_intel snd_hda_codec snd_pcm snd_timer snd
> > soundcore snd_page_alloc ohci1394 e100 nvidia i2c_core ntfs ipw3945 ieee80211
> > ieee80211_crypt firmware_class joydev
> > CPU:    1
> > EIP:    0060:[<f8cc4714>]    Tainted: PF     VLI
> > EFLAGS: 00010296   (2.6.18-suspend2 #5)
> > EIP is at snd_hda_ch_mode_info+0x24/0x50 [snd_hda_codec]
> > eax: ffffffff   ebx: 00000000   ecx: 00000000   edx: f50dbe04
> > esi: f74a3140   edi: c1105511   ebp: f6f49014   esp: f50dbdb4
> > ds: 007b   es: 007b   ss: 0068
> > Process alsactl (pid: 31485, ti=f50da000 task=c266ba90 task.ti=f50da000)
> > Stack: 00000000 f6f49014 f6f49014 f8ccfec8 00000000 f7a5cb54 f88ee5a7
> >        f50dbe1c f57766c0 f50dbf34 c108ae93 f50dbe04 bff5cab0 f6ed9254
> >        00000000 f88fb000 00000000 f6bd7408 f6f49160 f6f49160 00000001
> >        00000002 00000000 00000000
> > Call Trace:
> >  [<f8ccfec8>] conexant_ch_mode_info+0x18/0x20 [snd_hda_codec]
> >  [<f88ee5a7>] snd_ctl_ioctl+0x4e7/0xb50 [snd]
> >  [<c108f85b>] do_ioctl+0x2b/0x90
> >  [<c108f91c>] vfs_ioctl+0x5c/0x2b0
> >  [<c108fbad>] sys_ioctl+0x3d/0x70
> >  [<c100311d>] sysenter_past_esp+0x56/0x79
> >  [<b7f80410>] 0xb7f80410
> > Code: 8d bc 27 00 00 00 00 83 ec 0c 8b 44 24 10 3b 42 54
> >  c7 42 40 03 00 00 00 c7 42 48 01 00 00 00 89 42 50 77 04
> >  48 89 42 54 8b 42 54 <8b> 04 c1 89 44 24 08 b8 38 1f cd
> >  f8 89 44 24 04 8d 42 58 89 04
> > EIP: [<f8cc4714>] snd_hda_ch_mode_info+0x24/0x50 [snd_hda_codec]
> > SS:ESP 0068:f50dbdb4
> >
> > Regards,
> > Konstantin
> >
> > On 11/4/06, Tobin Davis <tdavis <at> dsl-only.net> wrote:
> > > Here's test release 8.  Changes of significance:
> > >
> > > Preliminary Conexant 5045 support
> > >         Preliminary HP DV6000 series support.
> > >         Preliminary test mode (when compiled with debugging).
> > >
> > > Separation of Conexant 5047 support models
> > >         HP DV1000/2000/3000 series split from 5000/8000 series due to
> > >         implementation differences.  No change on HP muting speakers
> > >         (still need to figure this one out).
> > >         HP DV5000/8000 series/Compaq V5209US/V5204NR series
> > >                 Headphone mutes speakers ok (same as test7).
> > >                 Removed Internal Microphone from mixer.
> > >         Toshiba P100 series
> > >                 changed EAPD default.  Hopefully this triggers audio.
> > >         Code changes to "test" model.
> > >         Adjusted Mic gains (I think).
> > >
> > > Areas to test:
> > >         5045 series - everything.
> > >         5047 series
> > >                 HP DV1/2/3000 series - try test mode and start toggling
> > >                 controls until speakers are muted and headphones work.
> > >                 Report findings.
> > >                 HP 5000/8000 series - make sure I didn't break things.
> > >                 Test recording.
> > >                 Toshiba  - everything.
> > >
> > > For the new testers in the group, here's the instructions:
> > >
> > > wget ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.13.tar.bz2
> > > tar -jxf alsa-driver-1.0.13.tar.bz2
> > > cd alsa-driver-1.0.13
> > > ./configure --with-debug=full --with-cards=hda-intel
> > > patch -p1 <conexant-test8.patch
> > > make ; make install
> > > dmesg -c
> > >
> > > Stop all audio applications and remove all audio drivers (lsmod |fgrep
> > > snd).  Reload the new driver with "modprobe snd-hda-intel" and test it
> > > out.  Use alsamixer to report any mixer issues (easier to debug than
> > > kmix/gmix, whatever-gui-mixer).  If nothing works, or one function
> > > doesn't work, try reloading the driver with "model=test" as a parameter.
> > > This should enable everything.
> > >
> > > Send me your test results.  Please include the system make/model, the
> > > subsystem line from "lspci -s 0:1b -vn" (Ex: Subsystem: 103c:30b2), and
> > > the output from "cat /proc/asound/card0/codec#0".
> > > I need this for tracking what works on what systems.
> > >
> > > Thanks for helping test this new driver.
> > >
> > > --
> > > Tobin Davis <tdavis <at> dsl-only.net>
> > >
> > >
> > >
> >
> > --
> > http://step-inside.org
> >
> > -------------------------------------------------------------------------
> > Using Tomcat but need to do more? Need to support web services, security?
> > Get stuff done quickly with pre-integrated technology to make your job easier
> > Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> > http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642 <http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642>
> >
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-- 
http://step-inside.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
