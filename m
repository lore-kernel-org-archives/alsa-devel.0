From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [ld10k1-devel] ld10k1 woes
Date: Sat, 04 Dec 2004 23:32:37 -0500
Message-ID: <1102221159.28776.94.camel@krustophenia.net>
References: <41B1B94A.8020604@t-data.com>
	 <1102215282.28776.86.camel@krustophenia.net>
	 <1102216828.28776.90.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1102216828.28776.90.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Melanie <melanie@t-data.com>
Cc: ld10k1-devel@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-12-04 at 22:20 -0500, Lee Revell wrote:
> On Sat, 2004-12-04 at 21:54 -0500, Lee Revell wrote:
> > On Sat, 2004-12-04 at 14:19 +0100, Melanie wrote:
> > > Error: unable to peek code
> > > Error: error in main loop
> > > 
> > > I have a SB Live! 5.1 card with LiveDrive IR.
> > 
> > I get the exact same error.  I have an Audigy 2 ZS.  Looks like a bug.
> > 
> 
> This ioctl is failing:
> 
>     292         /* get count of controls */
>     293         code.gpr_list_control_count = 0;
>     294         if (snd_hwdep_ioctl(handle, SNDRV_EMU10K1_IOCTL_CODE_PEEK, &code) < 0) {
>     295                 error("getting ctl count: unable to peek code");
>     296                 return LD10K1_ERR_DRIVER_CODE_PEEK;
>     297         }
>     298 
> 

I tried with the ALSA modules from kernel 2.6.9 and it works fine.  So
the problem is one of the recent changes to the DSP code handling:

http://cvs.sourceforge.net/viewcvs.py/alsa/alsa-kernel/pci/emu10k1/emufx.c?rev=1.66&view=log

Also, I cannot get qlo10k1 to build:

rlrevell@mindpipe:~/cvs/qlo10k1-0.1.1test2$ make
make  all-recursive
make[1]: Entering directory `/home/rlrevell/cvs/qlo10k1-0.1.1test2'
Making all in src
make[2]: Entering directory `/home/rlrevell/cvs/qlo10k1-0.1.1test2/src'
make  all-am
make[3]: Entering directory `/home/rlrevell/cvs/qlo10k1-0.1.1test2/src'
if g++ -DHAVE_CONFIG_H -I. -I. -I..     -g -O2 -I/usr/share/qt3/include -MT ld10k1file.o -MD -MP -MF ".deps/ld10k1file.Tpo" -c -o ld10k1file.o ld10k1file.cpp; \
then mv -f ".deps/ld10k1file.Tpo" ".deps/ld10k1file.Po"; else rm -f ".deps/ld10k1file.Tpo"; exit 1; fi
ld10k1file.cpp: In static member function `static int 
   LD10k1File::LoadFromFile(QString, LD10k1File**)':
ld10k1file.cpp:417: error: 'struct liblo10k1_file_info_t' has no member named '
   license'
ld10k1file.cpp: In member function `int LD10k1File::SaveToFile(QString)':
ld10k1file.cpp:439: error: 'struct liblo10k1_file_info_t' has no member named '
   license'
ld10k1file.cpp: In static member function `static int 
   LD10k1DspFile::LoadFromFile(QString, LD10k1DspFile**)':
ld10k1file.cpp:540: error: 'struct liblo10k1_file_info_t' has no member named '
   license'
ld10k1file.cpp: In member function `int LD10k1DspFile::SaveToFile(QString)':
ld10k1file.cpp:562: error: 'struct liblo10k1_file_info_t' has no member named '
   license'
make[3]: *** [ld10k1file.o] Error 1
make[3]: Leaving directory `/home/rlrevell/cvs/qlo10k1-0.1.1test2/src'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/home/rlrevell/cvs/qlo10k1-0.1.1test2/src'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/rlrevell/cvs/qlo10k1-0.1.1test2'
make: *** [all] Error 2

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
