From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: I have found a reason why dmix does not work well
 with xine.
Date: Wed, 04 Feb 2004 13:02:31 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4020ED67.2020405@superbug.demon.co.uk>
References: <40203EE8.3060107@superbug.demon.co.uk> <Pine.LNX.4.58.0402040847590.1863@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0402040847590.1863@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> 
> 
> Did you some tests with xine and 1.0.2 libraries? I tried to fix all 
> problems related to xine there (including the last reported problem from 
> you).
> 
> The delay values might be affected by this issue: The dmix plugin can
> start in the middle of period of the "master" (hw:x device). In this case,
> the pointers of the master pcm are updated at different point - from the
> dmix look - than the exclusive device does. You can avoid this problem
> using the new "slowptr" option - in this case are pointers synced at each
> r/w/status operation, but it adds an extra overhead. Anyway, my tests
> shows that xine works well also without this option (and I used USB device
> for tests which does also additional buffering in the kernel driver so it
> more problematic than standard soundcards).
> 
> 						Jaroslav
> 

I upgraded to latest alsa-lib cvs. Mixed results. :-(
I have found a new problem.
It seems to be fairly random as to which applications work, and which do 
not.
After running xine in a working state for some time, I find that my 
delay-test program fails now, only outputting every other period to the 
speakers. (command used ./delay-test -c2 -Ddmix -r48000 >t1)
Even unloading all the snd-* modules does not help.

I also see strange errors like: -
bash-2.05b# ./delay-test -c2 -Dplug:dmix -r44100 >t1
delay-test: pcm.c:2353: snd_pcm_areas_copy: Assertion `dst_areas' failed.
Aborted
It plays the first 8 periods, then stops with that error.
I have 8 periods per buffer, as you can see below.
Same happens with: -
./delay-test -c2 -Dplughw -r48000 >t1

So, I think that bug is in the "plug" plugin, and not the dmix plugin.

See below for my dmix entry I have put in /usr/share/alsa/alsa.conf

pcm.dmix {
         @args [ SLAVE FORMAT RATE ]
         @args.SLAVE {
                 type string
                 default "hw:0,0"
         }
         @args.FORMAT {
                 type string
                 default S16_LE
         }
         @args.RATE {
                 type integer
                 default 48000
         }
         type dmix
         slowptr yes
         ipc_key 5678293
         ipc_key_add_uid yes
         slave {
                 pcm $SLAVE
                 format $FORMAT
                 rate $RATE
                 period_time 0
                 period_size 315
                 buffer_size 2520
         }
}


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
