From: "Ben DiDonc" <ben.didonc@gmail.com>
Subject: Re: Fwd: No sound with ATI SB450
Date: Sun, 22 Apr 2007 19:45:05 +1000
Message-ID: <feca60390704220245o1cd98dd3od5d4bb999f25c71@mail.gmail.com>
References: <feca60390704202156h5a34ef0ao975d8c398dee9473@mail.gmail.com>
	<1177134516.21521.143.camel@razman.gruemaster.com>
	<feca60390704202300hd987409nd6fc8b2ee316c771@mail.gmail.com>
	<1177135815.21521.145.camel@razman.gruemaster.com>
	<feca60390704210129v2180efefl4c94e2e9c80fcaa@mail.gmail.com>
	<feca60390704210327qa3e355di9c07b1f191025345@mail.gmail.com>
	<1177172786.21521.163.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.251])
	by alsa0.perex.cz (Postfix) with ESMTP id CB5D624491
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Apr 2007 11:45:06 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c18so1382646anc
	for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2007 02:45:05 -0700 (PDT)
In-Reply-To: <1177172786.21521.163.camel@razman.gruemaster.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Tobin,

>Which snapshot did you download?

I used alsa-driver-hd20070421

> It looks as if the driver isn't detecting your codec at all.  Is it
possible that your audio is disabled in bios?

I agree with you. This laptop has a strange BIOS, you can disable a couple
of things (network card,...) but not the sound card.

> Also, Toshiba's are notorious for their acpi issues.  Try rebooting with
"acpi=off" on the kernel boot parameters list.

No  improvement here, no difference with what I had before... still no sound
...

To help us debug this further if the above steps don't work, try recompiling
> the drivers with "./configure --with-debug=detect --with-cards=hda-intel".
> Then rebuild and reinstall the drivers, and look at the dmesg log with
> "dmesg | fgrep ALSA".
>

Ok, I rebuild the drivers with the configure options you gave me, and
reloaded them. I grepped my syslog and got a single line out of it:
Apr 22 19:07:50 tosh-it kernel: [89422.940000] ALSA
/media/sda3/gilles_files/download/drivers/alsa-driver-hg20070421/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
codec_mask = 0x9

but still no proper senses shown in alsamixer and no sound. See output of
alsa-info.sh at http://pastebin.ca/452475

Your system "should" show up as a Toshiba with RealTek ALC861 audio codec.
> The alsa-info.sh listing doesn't show that codec, but does list the
> subdevice ID.
>
> Tobin
>

I did a bit of research on the devel mailing list and found
http://article.gmane.org/gmane.linux.alsa.devel/45881
I tried applying the patch (to hda_intel.c) and realised most of it already
was in the snapshot EXCEPT line 995, which i replaced with the one from the
patch. It now is
for (c = 0; c < azx_max_codecs[chip->driver_type]; c++) {

 I rebuilt the whole lot, reloaded snd_hda_intel and got these two lines
this time:

Apr 22 19:39:01 tosh-it kernel: [91293.576000] ALSA
/media/sda3/gilles_files/download/drivers/alsa-driver-hg20070421/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
codec_mask = 0x9
Apr 22 19:39:01 tosh-it kernel: [91293.916000] ALSA
/media/sda3/gilles_files/download/drivers/alsa-driver-hg20070421/pci/hda/hda_codec.c:1819:
hda_codec: model 'toshiba' is selected for config 1179:ff10 (Toshiba)

This time the right codec is loaded (or so it seems), alsamixer only shows a
PCM control (for playback), but there is still no sound. alsa-info.sh output
at http://pastebin.ca/452493

I m a bit confused with these results...
Ben

On Sat, 2007-04-21 at 20:27 +1000, Ben DiDonc wrote:
>
> Tobin,I downloaded and installed alsa-driver, alsa-lib and alsa-utils, but stillno sound coming out of those speakers...I ran alsa-info.sh and the results are at http://pastebin.ca/451128I am clueless as to what to do next, but I m ready to try anything. Any help would be greatly appreciated.Ben
> On 4/21/07, Tobin Davis < tdavis@dsl-only.net> wrote:>>  Try downloading a current daily snapshot from ftp://ftp.suse.com/pub/projects/alsa/snapshot/> .>> There was an issue with the ATI HD Audio detection that was fixed after> 14rc3 was released.>> Tobin>> On Sat, 2007-04-21 at 16:00 +1000, Ben DiDonc wrote:>> The output of alsa-info.sh is available at http://pastebin.ca/451007>>>  On 4/21/07, *Tobin Davis* < tdavis@dsl-only.net> wrote:>>  Could you download an run http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh> , then post the resulting link?  This will help determine what setup you> have.>> Tobin Davis>>>> On Sat, 2007-04-21 at 14:56 +1000, Ben DiDonc wrote:>>   Hi I have a toshiba A100 (see attached file lspci-nnv) with a ATI SB450.> Sound worked fine with kernel 2.6.17 and alsa 1.0.12rc1 (ubuntu edgy). I> just did a fresh install of ubuntu feisty (kernel 2.6.20, alsa 1
 .0.14rc1)> and the only mixer settings available are those of the modem, named off-hook> a
 nd caller-id (see output of amixer, aplay -l , and the rest in attached> file output_feisty) I decided to upgrade alsa-driver and alsa-lib to> 1.0.14rc2. after downloading the package, I unloaded all sound related> modules (everything with "snd_" in it) in the right order and did:> ./configure --with-oss=yes --with-cards=hda-intel;make; sudo make install;> sudo modprobe snd_hda_intel A minor improvement: the mixer now shows> controls for both the modem and the sound card (see> output_after_upgrade_to_rc2), but unfortunately, there is still no sound> coming out of those speakers (even though alsamixer shows control for PCM> and the rest...). Finally, I downloaded alsa-driver-1.0.14rc3 and gave it> a shot. This time again, only modem related settings appeared in alsamixer,> and no sound card stuff (see aplay and amixer in> output_after_upgrade_to_rc3), and no sound either. Does anyone kno
 w how to> get some sound out of these speakers (given that it used to work with> alsa1.0.1
 2rc1...) ? Thanks for your help Ben>
> >    _______________________________________________Alsa-devel mailing listAlsa-devel@alsa-project.orghttp://mailman.alsa-project.org/mailman/listinfo/alsa-devel>>    --> Tobin Davis <tdavis@dsl-only.net>>>>   --> Tobin Davis <tdavis@dsl-only.net>>_______________________________________________Alsa-devel mailing listAlsa-devel@alsa-project.orghttp://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>   --
> Tobin Davis <tdavis@dsl-only.net>
>
