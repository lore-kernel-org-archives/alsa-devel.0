From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: smart and automatic use of dmix and dsnoop - feature
 suggestion.
Date: Mon, 17 Nov 2003 21:58:54 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB9449E.3030904@superbug.demon.co.uk>
References: <200311171936.hAHJaW1B013634@oud.linuxaudiosystems.com> <Pine.LNX.4.53.0311172102250.16992@pnote.perex-int.cz> <200311172128.34259.pwk.linuxfan@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311172128.34259.pwk.linuxfan@gmx.de>
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

Hi,

Just a general comment on dmix/dsnoop.
1) It is not bug free yet. I have an application that fails when one 
tries to use it. (xine.sf.net). I have not had time to establish why 
yet. E.g. xine using "front" device, output's stereo sounding perfectly. 
I note down the buffer and period sizes and rate and sample format being 
used for "front" and set "dmix" to use the same via the alsa.conf file.
But playing with "dmix" causes the sound to stutter, as though only 
every second period is being played, with zero samples in between.
When I get a moment I will investigate further the exact cause. 
Initially I thought it was a buffer/period size problem, but I have 
checked that, and that is not the problem. The next TODO test I will do 
will be testing the snd_pcm_delay() returned from the dmix device, and 
compare it's accuracy with "front".

2) For smart dmix/dsnoop to be really user friendly, we will need a 
version of it that works in full duplex. I.E. Multiple applications able 
to record the same stream as well as play to it at the same time.

3) If one application wishes to play to "surround51" and a different 
application wishes to play to "front", dmix will have to be clever 
enought to mix the two.

4) If one application wishes to play to "front" and a different 
application wishes to play to "rear", the mixer should be able to mix to 
get 4 output channels.

5) I think that this sound mixing problem might be better served by 
sound servers like jack.

6) software mixing is ok, but software resampling is not a good idea to 
do in alsa-lib, because a) It cannot do good quality resamplings because 
t is trying to keep latency low. b) A audio/video application could do 
resampling better because it could do it at the decoding stages, before 
latency and audio/video sync is a problem.

7) For mixing, each open of the alsa multi-open device should have it's 
own volume control per open, and not just the hardware backend volume 
controls. The application could easily control their own volume, without 
effecting other application's volume.

Summary: -
An application should be able to use device names like "rear", "front", 
"surround51" and then have a separate control to tell alsa whether it is 
allowed to do resampling or not. Then at least the more advanced 
application could decide for itself whether to use alsa-lib's low 
quality resampler, or implement it's own multi-tap interpolation filter.
For a video/audio application like xine.sf.net, being able to open the 
alsa device in such a way to ensure we know where the sound will be 
routed(which speakers sound will come from) is useful.

Cheers
James



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
