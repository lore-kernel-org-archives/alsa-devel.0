From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: Want to hack a new feature into pcm/pcm_file.c
Date: Thu, 11 May 2006 21:35:19 -0300
Message-ID: <4463D847.4020801@instant.com.br>
References: <4463AB36.9030204@instant.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4463AB36.9030204@instant.com.br>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I guess I'd have to change snd_pcm_file_readi() and snd_pcm_file_readn() 
-- right now they write to a file, just like snd_pcm_file_writei() and 
snd_pcm_file_writen(). Instead, they'd have to read data from a file and 
return that. Subject, of course, to the existence of a new configuration 
pareameter -- say, "filein".

Makes sense?

Juan Carlos Castro y Castro wrote:

> Hello. I'd like very much to be able to specify an existing raw audio 
> file and have it be a "virtual microphone", i.e. recording 
> applications using this PCM would get the sound that's stored in that 
> file. That's the exact opposite of the "virtual speakers" thing the 
> file plugin does now.
>
> How hard would it be to do such a thing, and where should I begin 
> studying? I am an experienced C programmer but know precious little 
> about the ALSA architecture. If it's already possible to do the above 
> with existing features, please don't beat me -- I asked around in 
> alsa-user and got no answer, so I'm assuming hacking alsa-lib will be 
> necessary.
>
> Cheers,
> Juan
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job 
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache 
> Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
