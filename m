From: Caleb Crome <alsa@crome.org>
Subject: Re: How do create a dummy device for recording audio?
 Does it exist already?
Date: Thu, 29 Apr 2004 08:41:10 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40912216.6000901@crome.org>
References: <Pine.HPX.4.33n.0404291036220.7053-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0404291036220.7053-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Caleb Crome <alsa@crome.org>, ALSA Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:

>Caleb Crome wrote:
>  
>
>>Clemens Ladisch wrote:
>>    
>>
>>>However, Realplayer uses the OSS emulation through /dev/dsp0.  To make
>>>that work with your "file" device, add the following to the config
>>>file:
>>>
>>> pcm.dsp0 = file
>>>      
>>>
>>Awesome!  It works like a charm.  Than you so much!  The one thing that
>>doesn't work quite right is that I get the following error when
>>RealPlayer attempts to access the mixer:
>>
>>ALSA lib control.c:601:(snd_ctl_open_noupdate) Invalid CTL mixer0
>>    
>>
>
>It tries to use /dev/mixer0, too.  Add the following:
>
>  ctl.mixer0 = "hw:0"
>
>
>HTH
>Clemens
>
>
>  
>
Clemens,
   Thanks for the info, however  now I get the following:

ALSA lib control.c:516:(snd_ctl_open_conf) Invalid type for CTL mixer0 
definition

Any ideas?  Just for the record, my asoundrc is:

pcm.dsp0 = file
pcm.file {
     type file
     slave {
           pcm "hw:0,0"
     }
    file "/tmp/pcm.raw.pipe"
}
ctl.mixer0 = "hw:0"


When I changed the last line to:

ctl.mixer0 = hw

it doesn't complain any more.  Is that the correct syntax? 

Thanks again,
    -Caleb



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
