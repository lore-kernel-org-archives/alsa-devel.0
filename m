From: Laurent Georget <lgeorget2@club-internet.fr>
Subject: Re: possible ALSA bug/feature (was: important recording
 broke. why?) (fwd)
Date: Wed, 26 Mar 2003 21:53:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E821332.7050703@club-internet.fr>
References: <Pine.LNX.4.44.0303211610150.20651-100000@vaino.wakkanet.fi>	<s5h7kanpbpc.wl@alsa2.suse.de>	<3E80CB2E.7070204@club-internet.fr> <s5hznnio0ml.wl@alsa2.suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 25 Mar 2003 22:33:34 +0100,
> Laurent Georget wrote:
> 
>>Takashi Iwai wrote:
>>
>>>At Fri, 21 Mar 2003 16:16:04 +0200 (EET),
>>>Kai Vehmanen wrote:
>>>
>>>
>>>>Hi,
>>>>
>>>>first please read the mail to ecasound-list below. 
>>>>
>>>>It seems that with newer ALSA versions, snd_pcm_read[in]()  sometimes
>>>>returns -EIO even though documentation says nothing about this. After some
>>>>testing this seems to not happen on direct hw-access, only with
>>>>the pcm_plugin. The EIO comes from snd_pcm_wait(). 
>>>>
>>>>Is this a bug or or a feature?
>>>
>>>
>>>i also don't know whether Jaroslav added as a feature or as an
>>>unexpected bug.  anyway, this means that the poll failed and the pcm
>>>status is abnormal, typically xruns...
>>>
>>>how about the attached patch?  (untested)
>>>
>>>
>>>Takashi
>>
>>Hello!
>>
>>The problem I posted about is , I think, the same than Kai Vehmanem 
>>tells about here, but  with Alsa level plugins
>>(the plugin from Abramo, and Ameter from me (well , 95% of  the code is 
>>from Abramo and Steve Harris)
>>
>>After 0.9rc7 , using level or ameter plugin with low (but valid) buffer 
>>size gives an IO error :
>>
>>aplay -D level -B 10000 -v test.wav
>>....
>>aplay: pcm_write:1025: write error: Input/output error
> 
> 
> ah, i forgot to tell that it was the fix for the capture.
> 
> for playback, you'll need to fix snd_pcm_write_areas() as well.
> the patch attached below.  please give a try.
> 
> 
> ciao,
> 
> Takashi

I applied the 2 patches : now it is ok for playing and recording with 
any buffersize.
Very cool !

Laurent



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
