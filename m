From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Want to hack a new feature into pcm/pcm_file.c
Date: Fri, 12 May 2006 11:18:13 -0300
Message-ID: <44649925.2070605@instant.com.br>
References: <4463AB36.9030204@instant.com.br>	<4463D847.4020801@instant.com.br> <s5hy7x7zkjd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy7x7zkjd.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>At Thu, 11 May 2006 21:35:19 -0300,
>Juan Carlos Castro y Castro wrote:
>  
>
>>I guess I'd have to change snd_pcm_file_readi() and snd_pcm_file_readn() 
>>-- right now they write to a file, just like snd_pcm_file_writei() and 
>>snd_pcm_file_writen(). Instead, they'd have to read data from a file and 
>>return that. Subject, of course, to the existence of a new configuration 
>>pareameter -- say, "filein".
>>
>>Makes sense?
>>    
>>
>Actually, the current pcm_file.c already has read support.
>(Though, it might not work since I've not tested it yet :)
>  
>
 From what I understand from the source, in read mode the plugin is 
supposed to always write the "real" (i.e. from the slave PCM) sound 
input to the specified file, and then provide that input unchanged to 
the app. Is that the intended purpose? What I want to do is a bit 
different -- provide the contents of the existing file to the app 
instead of what comes from the slave.

I think it's possible to keep the first behavior in the absence of a new 
confuguration parameter. Let's call it "filein". You specify a file name 
just like with "file". You know what -- I'm gonna hack it right now. Let 
me see if you have a CVS or SVN repository...

(...) uh, what the netherworld is "HG (Mercurial) SCM"? (...) OK. Yet 
Another CVS Alternative. (...) Ah, it exists in Fedora's extras. Got it. 
Did the equivalent of "cvs checkout." Let's hack.

Would you happen to use any kind of instant messenger perchance? :)

Cheers,
Juan

>Takashi
>  
>
>>Juan Carlos Castro y Castro wrote:
>>    
>>
>>>Hello. I'd like very much to be able to specify an existing raw audio 
>>>file and have it be a "virtual microphone", i.e. recording 
>>>applications using this PCM would get the sound that's stored in that 
>>>file. That's the exact opposite of the "virtual speakers" thing the 
>>>file plugin does now.
>>>
>>>How hard would it be to do such a thing, and where should I begin 
>>>studying? I am an experienced C programmer but know precious little 
>>>about the ALSA architecture. If it's already possible to do the above 
>>>with existing features, please don't beat me -- I asked around in 
>>>alsa-user and got no answer, so I'm assuming hacking alsa-lib will be 
>>>necessary.
>>>
>>>Cheers,
>>>Juan
>>>
>>>
>>>-------------------------------------------------------
>>>Using Tomcat but need to do more? Need to support web services, security?
>>>Get stuff done quickly with pre-integrated technology to make your job 
>>>easier
>>>Download IBM WebSphere Application Server v.1.0.1 based on Apache 
>>>Geronimo
>>>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>>>_______________________________________________
>>>Alsa-devel mailing list
>>>Alsa-devel@lists.sourceforge.net
>>>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>>
>>>      
>>>
>>
>>-------------------------------------------------------
>>Using Tomcat but need to do more? Need to support web services, security?
>>Get stuff done quickly with pre-integrated technology to make your job easier
>>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>>_______________________________________________
>>Alsa-devel mailing list
>>Alsa-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>
>>    
>>
>
>
>-------------------------------------------------------
>Using Tomcat but need to do more? Need to support web services, security?
>Get stuff done quickly with pre-integrated technology to make your job easier
>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
>http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>  
>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
