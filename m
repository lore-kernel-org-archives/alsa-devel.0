From: Juan Carlos Castro y Castro <jcastro@instant.com.br>
Subject: Re: A better pcm_file "infile" patch, and a declaration
 of being miffed.
Date: Fri, 19 May 2006 10:45:32 -0300
Message-ID: <446DCBFC.6020703@instant.com.br>
References: <446CA0F0.2000603@instant.com.br> <s5hr72qxppf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr72qxppf.wl%tiwai@suse.de>
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

>At Thu, 18 May 2006 13:29:36 -0300,
>Juan Carlos Castro y Castro wrote:
>  
>
>>OK, this implements the "infile" parameter of pcm_file in a much cleaner 
>>way. Note that the the below new members of snd_pcm_file_t are not used 
>>now, but WILL be when I implement protection from fraction-of-frame reads:
>>
>>       size_t rbuf_size_bytes;
>>       size_t rbuf_used_bytes;
>>       char *rbuf;
>>
>>Now, the whole reason of this shebang was so I can use the "infile" AND 
>>convert rates in the process -- i.e., the app programs its microphone in 
>>whatever rate/format it wants, and ALSA converts the sound from the 
>>existing format to what the app needs.
>>
>>The exact opposite of this already works for output -- I can force a 
>>file to be written in the same format, no matter how the app configures 
>>its sound output. For this, I use the .asoundrc that's also attached. 
>>But it doesn't work for input. Can someone help me?
>>    
>>
>I guess it works if you point a real mic PCM device as slave but still
>using infile?
>  
>
It will ignore the microphone and read from the file instead. The 
typical use, therefore, is with the null plugin as slave.

If you want to mix a file and a live input (say, for making a narration 
with ambient music), I suppose there are ways to do that with dmix, am I 
correct? (Hmmm, this could have a "loop" option)

My problem is different, it's rate & format conversion. I want to be 
able to use an specific existing file as input even if the app programs 
the "microphone" for a different rate/format. I'm almost certain there 
is a way to do that with existing ALSA plugins (plug? dmix?) but I've 
been unable to find it out on my own. :(

>The patch looks almost OK.  But please don't forget to add the
>description of new parameter in the doxygen comment (in \section
>pcm_plugins_file Plugin: File), too.
>
>Also, please provide a changelog and a signed-off-by line, e.g.
>
>	The short summary in a line...
>
>	A detailed change log...
>	....
>
>	Signed-off-by: Foo Bar <foo@bar.com>
>  
>
Will do.

Cheers,
Juan


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
