From: Ann Patterson <annp322@sbcglobal.net>
Subject: Re: M-Audio Revolution and MythTV
Date: Tue, 02 Mar 2004 19:39:06 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1078285146.5239.59.camel@localhost.localdomain>
References: <1078107493.5239.19.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0403010917310.1870@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-zg51u1D+IfdJ/IMqZcm+"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403010917310.1870@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-zg51u1D+IfdJ/IMqZcm+
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-03-01 at 00:17, Jaroslav Kysela wrote:
> On Sun, 29 Feb 2004, Ann Patterson wrote:
> 
> > I installed a M-Audio Revolution 7.1 (snd-ice1724) in my mythtv box. I
> > had mythtv working fine with the machine's onboard sound (snd-trident)
> > using OSS emulation. The revo works correctly for things like xine,
> > mplayer, aplay (of course), play, etc. In mythtv, however, I get no
> > sound. 
> > 
> > I dug into the mythtv code, and found that it is doing a call to
> > ioctl(audiofd, SNDCTL_DSP_GETOSPACE, &info) and using the info.bytes
> > value that is returned to determine whether or not to write to the card.
> > The first call to SNDCTL_DSP_GETOSPACE appears to return a reasonable
> > number, but from that point, the numbers returned are all over the
> > place, and are often negative. So, mythtv, of course, won't write to the
> > card. I find that if I comment out the code that checks the values
> > returned from GETOSPACE, I get sound, but it is out of sync with the
> > video (sound slightly behind video).
> > 
> > I'm using the dmix plugin, if that matters, but I got the same results
> > without the plugin.
> > 
> > I'm willing to debug this further, but I've not done anything with alsa
> > or soundcards before, so I need a bit of help in determining where to
> > look.
> 
> Can you write a nice small test code which shows this problem? You may 
> modify code in alsa-oss/test/osstest.c .
> 
> 						Jaroslav

I've attached a patch to alsa-oss-1.0.3rc3 that modifies osstest.c to
reproduce the problem. If you run it like:

osstest -v -M write

you will see the output from the SNDCTL_DSP_GETOSPACE ioctl during each
write loop. I also attached the log from when I run it with my revo, and
the log when I run it with my onboard SiS sound. I included my
asound.conf and modules.conf for good measure, too.

Let me know if you need anything else, or if I'm doing something wrong.

Ann P.


--=-zg51u1D+IfdJ/IMqZcm+
Content-Disposition: attachment; filename=alsa-oss-ice1724test.patch
Content-Type: text/x-patch; name=alsa-oss-ice1724test.patch; charset=
Content-Transfer-Encoding: 7bit

Only in alsa-oss-mod/alsa: aoss
Only in alsa-oss-mod/alsa: .deps
Only in alsa-oss-mod/alsa: Makefile
Only in alsa-oss-mod/alsa: testaoss
Only in alsa-oss-mod/: config.log
Only in alsa-oss-mod/: config.status
Only in alsa-oss-mod/: libtool
Only in alsa-oss-mod/: Makefile
Only in alsa-oss-mod/oss-redir: .deps
Only in alsa-oss-mod/oss-redir: Makefile
Only in alsa-oss-mod/test: .deps
Only in alsa-oss-mod/test: ice1724.log
Only in alsa-oss-mod/test: Makefile
diff -ur alsa-oss-1.0.3rc3/test/osstest.c alsa-oss-mod/test/osstest.c
--- alsa-oss-1.0.3rc3/test/osstest.c	2004-02-26 07:34:50.000000000 -0800
+++ alsa-oss-mod/test/osstest.c	2004-03-02 08:21:21.000000000 -0800
@@ -162,6 +162,14 @@
 		char buf[1000];
 		if (omode != O_RDONLY) {
 			ssize_t res;
+			if (oss_pcm_ioctl(fd, SNDCTL_DSP_GETOSPACE, &ospace) < 0) {
+			  perror("SNDCTL_DSP_GETOSPACE");
+			  exit(EXIT_FAILURE);
+			}
+			printf("ospace.fragstotal = %i\n", ospace.fragstotal);
+			printf("ospace.fragsize = %i\n", ospace.fragsize);
+			printf("ospace.periods = %i\n", ospace.fragments);
+			printf("ospace.bytes = %i\n", ospace.bytes);
 			if (first) {
 				res = oss_pcm_write(fd, buf, sizeof(buf));
 				if (verbose)
Only in alsa-oss-mod/test: osstest.c~
Only in alsa-oss-mod/test: osstest.c.orig
Only in alsa-oss-mod/test: testaoss
Only in alsa-oss-mod/test: trident.log

--=-zg51u1D+IfdJ/IMqZcm+
Content-Disposition: attachment; filename=ice1724.log
Content-Type: text/plain; name=ice1724.log; charset=
Content-Transfer-Encoding: 7bit

Using transfer method rw
Device /dev/dsp opened sucessfully
Format set to 16
Rate set to 48000
Channels set to 2
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 32
ospace.bytes = 131072
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 32
ospace.bytes = 131072
write: (1000) -> 1000
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -2000
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -3000
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -4000
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 11416
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 10416
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 9416
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 8416
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 7432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 6432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 5432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 4432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 3432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 2432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 1432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 432
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -552
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -1552
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -2552
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -3552
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 11832
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 10832
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 9832
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 8832
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 7832
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 6848
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 5848
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1
ospace.bytes = 4848
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 3848
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 2848
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 1848
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 0
ospace.bytes = 848
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -152
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -1152
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -2136
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 1048575
ospace.bytes = -3136
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 12264
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 11264
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 10264
write: (1000) -> 1000
ospace.fragstotal = 32
ospace.fragsize = 4096
ospace.periods = 2
ospace.bytes = 9264
write: (1000) -> 1000

--=-zg51u1D+IfdJ/IMqZcm+
Content-Disposition: attachment; filename=trident.log
Content-Type: text/plain; name=trident.log; charset=
Content-Transfer-Encoding: 7bit

Using transfer method rw
Device /dev/dsp opened sucessfully
Format set to 16
Rate set to 48000
Channels set to 2
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 16
ospace.bytes = 65536
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 16
ospace.bytes = 65536
write: (1000) -> 1000
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 15
ospace.bytes = 63536
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 15
ospace.bytes = 62536
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 15
ospace.bytes = 61536
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 14
ospace.bytes = 60556
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 14
ospace.bytes = 59556
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 14
ospace.bytes = 58556
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 14
ospace.bytes = 57560
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 13
ospace.bytes = 56692
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 13
ospace.bytes = 55692
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 13
ospace.bytes = 54696
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 13
ospace.bytes = 53696
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 12
ospace.bytes = 52700
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 12
ospace.bytes = 51700
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 12
ospace.bytes = 50704
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 12
ospace.bytes = 49704
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 11
ospace.bytes = 48708
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 11
ospace.bytes = 47744
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 11
ospace.bytes = 46744
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 11
ospace.bytes = 45744
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 10
ospace.bytes = 44748
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 10
ospace.bytes = 43752
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 10
ospace.bytes = 42752
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 10
ospace.bytes = 41752
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 9
ospace.bytes = 40776
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 9
ospace.bytes = 39776
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 9
ospace.bytes = 38776
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 9
ospace.bytes = 37820
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 8
ospace.bytes = 36824
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 8
ospace.bytes = 35828
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 8
ospace.bytes = 34828
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 8
ospace.bytes = 33828
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 8
ospace.bytes = 32832
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 7
ospace.bytes = 31836
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 7
ospace.bytes = 30836
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 7
ospace.bytes = 29836
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 7
ospace.bytes = 28868
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 6
ospace.bytes = 27872
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 6
ospace.bytes = 26872
write: (1000) -> 1000
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 6
ospace.bytes = 25872
write: (1000) -> 1000

--=-zg51u1D+IfdJ/IMqZcm+
Content-Disposition: attachment; filename=asound.conf
Content-Type: text/plain; name=asound.conf; charset=
Content-Transfer-Encoding: 7bit

pcm.ice1724 {
       type hw
       card 0
       device 0
}


ctl.ice1724 {
       type hw
       card 0
       device 0
}


pcm.ice1724_digital {
       type hw
       card 0
       device 1
}


ctl.ice1724_digital {
       type hw
       card 0
       device 1
}


pcm_slave.ice1724_S32_LE {
   pcm ice1724
   format S32_LE
}


pcm.ice1724_convert {
   type plug
   slave ice1724_S32_LE
}


pcm_slave.ice1724_S32_LE_digital {
   pcm ice1724_digital
   format S32_LE
}



pcm.ice1724_convert_digital {
   type plug
   slave ice1724_S32_LE_digital

}

pcm.ossmix {
    type dmix
    ipc_key 1024          # must be unique!
    slave {
        pcm "hw:0,0"      # you cannot use a "plug" device here, darn.
        period_time 0
	period_size 512
	buffer_size 4096
        format "S32_LE"
#        periods 128      # dito.
#        rate 44100 
    }

    bindings {
        0 0   # from 0 => to 0
        1 1   # from 1 => to 1
    }
}

#pcm.dsp0 {
#    type plug
#    slave.pcm "ossmix"     # use our new PCM here
#}

#ctl.mixer0 {
#    type hw
#    card 0
#}

#pcm.!default {
#	type plug
#	slave.pcm "ossmix"
#}

#ctl.!default {
#	type plug
#	slave.pcm "ossmix"
#}

pcm.!default {
   type plug
   slave ice1724_S32_LE
}

pcm.!default {
   type plug
   slave ice1724_S32_LE
}

pcm.intel8x0 {
       type hw
       card 1
       device 0
}


ctl.intel8x0 {
       type hw
       card 1
       device 0
}


--=-zg51u1D+IfdJ/IMqZcm+
Content-Disposition: attachment; filename=modules.conf
Content-Type: text/plain; name=modules.conf; charset=
Content-Transfer-Encoding: 7bit

path[toplevel]=/lib/modules/`uname -r`/updates
# default path
path[toplevel]=/lib/modules/`uname -r`

alias usb-controller usb-ohci
alias usb-controller1 ehci-hcd
alias eth0 nvnet
alias char-major-195 nvidia
alias char-major-61 lirc_i2c

# ivtv modules setup
alias char-major-81 videodev
alias char-major-81-0 ivtv
options tuner type=2
options msp3400 once=1 simple=1
add below ivtv msp3400 saa7115 tuner

# --- BEGIN: Generated by ALSACONF, do not edit. ---
# --- ALSACONF verion 1.0.1 ---
alias char-major-116 snd
alias char-major-14 soundcore
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias snd-card-0 snd-ice1724
# --- END: Generated by ALSACONF, do not edit. ---
alias sound-slot-0 snd-ice1724

# onboard sound
alias snd-card-1 snd-intel8x0
alias sound-slot-1 snd-intel8x0
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-8 snd-seq-oss
alias sound-service-1-12 snd-pcm-oss

post-install sound-slot-0 /usr/sbin/alsactl restore

alias usb-interface usb-ohci

--=-zg51u1D+IfdJ/IMqZcm+--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
