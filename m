From: Marcus Pearce <M.T.Pearce@city.ac.uk>
Subject: No sound with EWS88mt
Date: Sun, 20 Oct 2002 15:19:22 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0210201518150.27730-100000@swindon>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Alsa driver from current cvs on Mandrake linux 7.2 (kernel 2.2.17). 

root@localhost # /etc/init.d/alsasound restart
Shutting down sound driver: done 
Starting sound driver: snd-emu10k1 done 
Starting sound driver: snd-ice1712 done 

with a click through the ews88mt card that suggests something is up. 

root@localhost # aplay -vD plug:hw:1 test.wav
Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Route conversion PCM (sformat=S32_LE)
Transformation table:
0 <- 0
1 <- 1
2 <- none
3 <- none
4 <- none
5 <- none
6 <- none
7 <- none
8 <- none
9 <- none
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 6553
period_size  : 1638
period_time  : 37142
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1638
xfer_align   : 1638
start_threshold  : 6552
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Slave: Hardware PCM card 1 'ICEnsemble ICE1712' device 0 subdevice -1

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S32_LE
subformat    : STD
channels     : 10
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 6553
period_size  : 1638
period_time  : 37142
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
format       : S32_LE
subformat    : STD
channels     : 10
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 24
buffer_size  : 6553
period_size  : 1638
period_time  : 37142
tick_time    : 10000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1638
xfer_align   : 1638
start_threshold  : 6552
stop_threshold   : 6553
silence_threshold: 0
silence_size : 0
boundary     : 1717829632
Max peak (3276 samples): 00066 (0x0042) #                    0%
Max peak (3276 samples): 00056 (0x0038) #                    0%
....etc. 

But no sound although envy24control suggests that there is sound going out
through pcm out 1 and 2. 

Which brings me on to a second problem. The patchbay in envy24control only
shows the S/PDIF outs. The following change to patchbay.c brings back the
H/W out channels in the patchbay: 

void patchbay_init(void)
{
        int i;
        snd_ctl_elem_value_t *val;

        snd_ctl_elem_value_alloca(&val);
        snd_ctl_elem_value_set_interface(val, SND_CTL_ELEM_IFACE_MIXER);
        snd_ctl_elem_value_set_name(val, ANALOG_PLAYBACK_ROUTE_NAME);
        for (i = 0; i < 8; i++) {
                snd_ctl_elem_value_set_numid(val, 0);
                snd_ctl_elem_value_set_index(val, i);
-                if (snd_ctl_elem_read(ctl, val) < 0)
+                if (snd_ctl_elem_read(ctl, val) < -2)
                        continue;
         
                stream_active[i] = 1;
        }

But then we get the following messages whenever we try to change routing
in the patchbay: 

root@localhost # envy24control -D hw:1
Unable to read Delta S/PDIF output state: No such file or directory
Unable to write Delta S/PDIF Output Defaults: No such file or directory 
Multi track route write error: No such file or directory 
Multi track route write error: No such file or directory 
Multi track route write error: No such file or directory 
.....etc 

Any ideas? 




-------------------------------------------------------
This sf.net email is sponsored by:
Access Your PC Securely with GoToMyPC. Try Free Now
https://www.gotomypc.com/s/OSND/DD
