From: stan <ghjeold_i_mwee@cox.net>
Subject: Re: No sound/mixer with new laptops on board sound -
 hda_intel ALC883
Date: Sun, 27 Apr 2008 07:34:27 -0700
Message-ID: <48148EF3.8090504@cox.net>
References: <4811F915.60208@conceptT.com>	<48132869.9080203@conceptT.com>	<48136925.1080900@cox.net>	<48137116.5000205@conceptT.com>	<481387F0.7010800@cox.net>
	<4813D30A.4040101@conceptT.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao101.cox.net (fed1rmmtao101.cox.net [68.230.241.45])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C5BD2415F
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Apr 2008 16:34:29 +0200 (CEST)
In-Reply-To: <4813D30A.4040101@conceptT.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kristoffer Janke <kj@conceptT.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Kristoffer Janke wrote:
> stan schrieb:
>   
>> Kristoffer Janke wrote:
>>   
>>     
>>> I have alsa-utils installed, but alsamixer does not run, instead it 
>>> gives this:
>>>   ALSA lib simple_none.c:1491:(simple_add1) helem (MIXER,'Headphone 
>>> Playback Switch',0,2,0) appears twice or more
>>>   alsamixer: function snd_mixer_load failed: Invalid argument
>>>
>>> So i cant modify the volumes...
>>>   
>>>     
>>>       
>> Two things.
>>
>> This looks like a bug in alsa lib.  You can get the latest alsa lib hg 
>> snapshot at ftp://ftp.suse.com/pub/projects/alsa/snapshot/, compile it, 
>> and install it.  The bug might be gone as things move very fast in 
>> alsa.  If it isn't, it would be good to post this problem on alsa-devel.
>>   
>>     
> With the newest hg alsa-lib it still does not work, same output.
>   
>> You can edit /etc/asound.state directly.  This file resides in /etc or 
>> /etc/alsa/ depending on your distro.  Here is a representative entry 
>> from mine.
>>
>>  control.18 {
>>                 comment.access 'read write'
>>                 comment.type INTEGER
>>                 comment.count 2
>>                 comment.range '0 - 127'
>>                 iface MIXER
>>                 name 'PCM Playback Volume'
>>                 value.0 103
>>                 value.1 103
>>         }
>>
>> What you want is to look for the same name (if you are using PCM), and 
>> then set the value.0 and value.1 to be something greater than 0.  Try 
>> half at first (of the range) so you won't blow anything out if it is 
>> very sensitive.  This at least gets you sound, though it isn't as 
>> convenient as using the mixer.  You will have to be root to edit this 
>> and if you aren't familiar with unix editors (vim or emacs) you should 
>> probably use something like pico.  Or Knotes or Text Editor in the gui.
>>   
>>     
> The problem here is, that alsactl cant save the values, too with the 
> same error than alsamixer:
> alsactl: set_control:1269: failed to obtain info for control #3 (No such 
> file or directory)
> alsactl: set_control:1269: failed to obtain info for control #4 (No such 
> file or directory)
> alsactl: set_control:1269: failed to obtain info for control #15 (No 
> such file or directory)
> alsactl: set_control:1269: failed to obtain info for control #16 (No 
> such file or directory)
> alsactl: set_control:1269: failed to obtain info for control #18 (No 
> such file or directory)
> alsactl: set_control:1269: failed to obtain info for control #27 (No 
> such file or directory)
> alsactl: set_control:1269: failed to obtain info for control #35 (No 
> such file or directory)
> alsactl: set_control:1269: failed to obtain info for control #36 (No 
> such file or directory)
> alsactl: set_control:1269: failed to obtain info for control #37 (No 
> such file or directory)
> alsactl: set_control:1269: failed to obtain info for control #38 (No 
> such file or directory)
>   
This sounds like it could be a mismatch between the versions of the 
program alsactl and alsa-lib.  It seems to be looking in the wrong place 
for information.  The files that alsa looks in are by default installed 
in /usr/share/alsa.  Some distros put them in /etc/alsa or /etc.  Check 
if that is the case by looking at the timestamp on the files.  If the 
newer files from the upgrade to alsa-lib are in /usr/share/alsa, you can 
put symbolic links to those files, or copy them to the location where 
your distro expects them to be.

After you updated alsa-lib, did you run /sbin/ldconfig?  This updates 
the version of library being referenced for sharing.  Could be the problem.

This doesn't seem to be the same problem as the first problem.  What 
happens when you use aplay (aplay -v -D plughw:0,0 some.wav)?  Can you 
run amixer (note, not alsamixer) in a console or terminal and get 
output?  Is the output your changed file?  Can you use the gui sound 
administration tools to play the test sound and does it work?
