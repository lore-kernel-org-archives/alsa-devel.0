From: Dan Tihelka <dtihelka@kky.zcu.cz>
Subject: Re: Build-in mixer
Date: Tue, 14 Oct 2003 09:39:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8BA81B.2070602@kky.zcu.cz>
References: <3F83C9B8.9050407@kky.zcu.cz> <200310081124.h98BOGqq018813@oud> <s5hsmm49bq5.wl@alsa2.suse.de> <1065886408.3f8822c843535@webmail.zcu.cz> <20031012164410.GA5834@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031012164410.GA5834@fliwatut.scifi>
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



Frank Barknecht wrote:

>>As I wrote some day ago, it is possible to play two or more sounds 
>>simultenaously with mentioned setting. But only with 'aplay'
>>
>>I tried to use xmms with ALSA 0.9 output plugin and Mplayer with ALSA-0.9.x 
>>support and it is impossible to play any two sound streams at the same time (i 
>>tried two xmms, xmms + mplayer, xmms + asound, mplayer + asound and two 
>>mplayers, but only the first played and the second was stopped until the first 
>>finished or breaked).
>>
>>Where can be problem? 
>>    
>>
>
>The problem lies in the wrong way in which these apps try to use ALSA.
>I don't use XMMS anymore, but for mplayer I can say, that it tries to
>open hw:X devices and doesn't allow the user to specify a device by
>name. 
>
I experimented with xmms ALSA output plugin and i forced "default" 
instead of "hw:0:0" to the audio opening command:

snd_pcm_open ( &handle, "default", SND_PCM_STREAM_PLAYBACK, 
SND_PCM_NONBLOCK );

but a error occured. I would like to ask you, if it is sufficient to 
change it only, or if there must be other changes when opening device? 
And why there is a possibility to force opening  mode by application, 
instead of offering interface which does not enable it and leave user to 
decide if to use mixer or not. Otherwise there is still possibility of 
 "forcing  ideas" by applications until they will be rewritten (if they 
will at all).


Thank you very much,

Dan




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
