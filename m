From: Shayne O'Connor <forums@machinehasnoagenda.com>
Subject: Re: Bug in emu10k1 multichannel support
Date: Fri, 11 Feb 2005 12:35:33 +1100
Message-ID: <420C0BE5.3060008@machinehasnoagenda.com>
References: <1106091073.24484.60.camel@krustophenia.net>	 <s5hpt01tler.wl@alsa2.suse.de> <1106970885.3051.88.camel@krustophenia.net>	 <41FE5838.4060907@glocalnet.net>	 <1108073865.11177.6.camel@krustophenia.net>	 <420BEF63.60402@machinehasnoagenda.com> <1108083562.15438.4.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1108083562.15438.4.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Mikael Magnusson <mikaelmagnusson@glocalnet.net>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:

>On Fri, 2005-02-11 at 10:33 +1100, Shayne O'Connor wrote:
>  
>
>>>Thanks, I have found and fixed the bug.
>>>
>>>http://www.alsa-project.org/~rlrevell/emu10k1-multichannel-v009.patch
>>>
>>>I believe the patch should now be mergeable.  All known bugs have been
>>>fixed, and since I announced it on LAU and LAD the patch has had fairly
>>>widespread testing.
>>>
>>>I will break the patch up and post one patch per file in the next few
>>>days.
>>> 
>>>
>>>      
>>>
>>does this one have both the capture and playback patches? if not, would
>>it be possible to combine the two, because i haven't had any success
>>patching the cvs alsa driver that already contains the capture (or is
>>that playback?) patch ...
>>
>>i'm currently using the 008 patch, without too much drama ... except the
>>slightly frustrating capturing of playback channels along with ac97 ...
>>though this could be due to incorrect mixer settings ...
>>    
>>
>
>No version 009 does not have the capture patch because I am trying to
>get the size of the patch down to merge it.
>
>I just tested version 009 with ALSA CVS and it works fine.  Can you try
>deleting the ALSA CVS directory, checking it out again and applying the
>patch?
>  
>
this is what i get when i try to apply the patch (btw - i've only got
the alsa-driver module from cvs - do i need the rest of them? that would
be a bit of a drama for me in regards to dependencies with aptitude etc):

[mrmachine@localhost alsa-driver]$ patch -p1 <
../emu10k1-multichannel-v009.patch
can't find file to patch at input line 8
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|Index: alsa-old/alsa-kernel/include/emu10k1.h
|===================================================================
|RCS file: /cvsroot/alsa/alsa-kernel/include/emu10k1.h,v
|retrieving revision 1.54
|diff -u -r1.54 emu10k1.h
|--- alsa-old/alsa-kernel/include/emu10k1.h     2 Feb 2005 11:52:45
-0000      1.54
|+++ alsa-old/alsa-kernel/include/emu10k1.h     3 Feb 2005 17:58:53 -0000
--------------------------
File to patch:


at which point, i don't know what to do ... perhaps i'm not doing this
correctly?


shayne


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
