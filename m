From: Caleb Crome <alsa@crome.org>
Subject: Re: How do create a dummy device for recording audio?
 Does it exist already?
Date: Wed, 28 Apr 2004 13:42:35 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4090173B.2020103@crome.org>
References: <Pine.HPX.4.33n.0404261825390.25756-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0404261825390.25756-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>Caleb Crome wrote:
>  
>
>>>>>pcm.file {
>>>>>  type file
>>>>>  slave {
>>>>>      pcm "hw:0,0"
>>>>>  }
>>>>>  file "/tmp/file.raw"
>>>>>}
>>>>>          
>>>>>
>>Alright, I did what you suggested, and real player comes up and connects
>>to the dummy sound card (I had to do a modprobe snd-pcm-oss and
>>snd-mixer-oss).   However, I don't get a file called /tmp/file.raw.
>>    
>>
>
>You have to configure the program to use the PCM named "file" instead
>of the default "default".
>
>However, Realplayer uses the OSS emulation through /dev/dsp0.  To make
>that work with your "file" device, add the following to the config
>file:
>
>  pcm.dsp0 = file
>
>and try to run realplayer with the aoss script from the alsa-oss
>package.
>
>
>HTH
>Clemens
>
>
>  
>
Awesome!  It works like a charm.  Than you so much!  The one thing that 
doesn't work quite right is that I get the following error when 
RealPlayer attempts to access the mixer:

ALSA lib control.c:601:(snd_ctl_open_noupdate) Invalid CTL mixer0

Is there a simple way to get it to control the mixer?  Currently, I have 
to bring up alsamixergui to turn up the volume.

Thanks again,
  -Caleb Crome


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
