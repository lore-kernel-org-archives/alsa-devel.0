From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: Re: ALSA + jack + xrun = kernel crash
Date: Thu, 22 May 2003 01:08:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3ECC06D7.1030202@student.kuleuven.ac.be>
References: <s5hk7ckvbap.wl@alsa2.suse.de>	<Pine.LNX.4.44.0305211334530.1480-100000@pnote.perex-int.cz> <s5h65o4v7sm.wl@alsa2.suse.de> <3ECBCF5B.2020807@esat.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <ppalmers@esat.kuleuven.ac.be>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>, Paul Davis <paul@linuxaudiosystems.com>, Arthur Peters <amp@singingwizard.org>, Alsa dev list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Pieter Palmers wrote:

>>
>>
>> ok.
>>
>> meanwhile, i committed my fixes (without the self_group change) to cvs
>> now.  i hope this is the last fix for this problem...
>>
>>
>>  
>>
> So did I, but alas...
>
> installed the new CVS version.
>
> this time I tried using alsaplayer -d jack.
>
> apart from not getting any sound, all seemed to work for a while. I 
> then Ctrl-C 'd jack and restarted it. Result: instant lockup.
> I do have the impression that it takes longer for the lockup to occur.
>
> I'll try again with spiralsynthmodular, and I'll try to figure out if 
> the restarting of Jack has something to do with this.
>
> Pieter
>
and so I tried spiralsynthmodular...
it still hangs the system, but now it runs a little longer than 
yesterday (a minute instead of some seconds).
and the restarting of jack doesn't affect it, i.e. this time it crashed 
on the first jack session.

I'm sorry that I can't provide you with any more info... if you have 
some suggestions on gathering more usefull info, please let me know.

Pieter




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
