From: Benoit Fouet <benoit.fouet@purplelabs.com>
Subject: Re: missing snd_dlclose in timer.c
Date: Tue, 25 Apr 2006 18:29:29 +0200
Message-ID: <444E4E69.9070200@purplelabs.com>
References: <444DE5E0.9030200@purplelabs.com>	<s5hpsj5zsx7.wl%tiwai@suse.de>	<444E3270.3050203@purplelabs.com>	<s5hlkttzpit.wl%tiwai@suse.de>	<444E3ECF.4060202@purplelabs.com> <s5h3bg1zldj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/alternative;
 boundary="------------020905030905030100040109"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from athena.purplelabs.com (purple011329-4.clients.easynet.fr [212.11.31.196])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7133015D
	for <alsa-devel@alsa-project.org>; Tue, 25 Apr 2006 18:29:33 +0200 (MEST)
In-Reply-To: <s5h3bg1zldj.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020905030905030100040109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Takashi Iwai wrote:

>At Tue, 25 Apr 2006 17:22:55 +0200,
>Benoit Fouet wrote:
>  
>
>>Takashi Iwai wrote:
>>
>>    At Tue, 25 Apr 2006 16:30:08 +0200,
>>    Benoit Fouet wrote:
>>
>>        Takashi Iwai wrote:
>>        
>>            At Tue, 25 Apr 2006 11:03:28 +0200,
>>            Benoit Fouet wrote:
>>        
>>                Hi,
>>                
>>                I worked on an ARM9E platform with not much memory. We had to
>>                dynamically link the libraries we needed.
>>                BTW I found out that there was a dlclose missing in ALSA lib in the
>>                snd_timer_open_conf function.
>>                Find below the diff of my file, if you want to add it in th hg repository.
>>        
>>            A good catch.
>>            
>>            I just wonder whether it's safe to call dlclose() there.
>>            Can the callback functions dynamically registered by open
>>            (e.g. snd_timer_hw_open) be still accessed safely after dlclose()?
>>            
>>            Or should we keep dl handle and dlclose it in snd_timer_close()?
>>        
>>            Takashi
>>        
>>        It surely is safer to keep the library opened as long as its symbol are likely to be
>>        used.
>>        I'm afraid I'm not aware enough of how it works to answer more clearly.
>>        btw, the symbols I used were in asound library, and were consequently still reachable
>>        after dlclose as the library was not really unloaded.
>>        Keeping the handle must be the best way to guarantee symbols can be reached until
>>        snd_timer_close.
>>
>>    I guess so, too.  alsa-lib has a mechanism to allow users specifying
>>    an extra shared object to be loaded.  Thus symbols are not always in
>>    libasound.so that is kept opened.
>>    
>>    I'll fix codes to call snd_dlclose() in close.
>>
>>Ok, thank you for precision :)
>>    
>>
>
>I fixed it on Hg repo now.
>
>
>Takashi
>  
>
Seems like I missed some others :-)

Ben

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

--------------020905030905030100040109
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
Takashi Iwai wrote:
<blockquote cite="mids5h3bg1zldj.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">At Tue, 25 Apr 2006 17:22:55 +0200,
Benoit Fouet wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Takashi Iwai wrote:

    At Tue, 25 Apr 2006 16:30:08 +0200,
    Benoit Fouet wrote:

        Takashi Iwai wrote:
        
            At Tue, 25 Apr 2006 11:03:28 +0200,
            Benoit Fouet wrote:
        
                Hi,
                
                I worked on an ARM9E platform with not much memory. We had to
                dynamically link the libraries we needed.
                BTW I found out that there was a dlclose missing in ALSA lib in the
                snd_timer_open_conf function.
                Find below the diff of my file, if you want to add it in th hg repository.
        
            A good catch.
            
            I just wonder whether it's safe to call dlclose() there.
            Can the callback functions dynamically registered by open
            (e.g. snd_timer_hw_open) be still accessed safely after dlclose()?
            
            Or should we keep dl handle and dlclose it in snd_timer_close()?
        
            Takashi
        
        It surely is safer to keep the library opened as long as its symbol are likely to be
        used.
        I'm afraid I'm not aware enough of how it works to answer more clearly.
        btw, the symbols I used were in asound library, and were consequently still reachable
        after dlclose as the library was not really unloaded.
        Keeping the handle must be the best way to guarantee symbols can be reached until
        snd_timer_close.

    I guess so, too.  alsa-lib has a mechanism to allow users specifying
    an extra shared object to be loaded.  Thus symbols are not always in
    libasound.so that is kept opened.
    
    I'll fix codes to call snd_dlclose() in close.

Ok, thank you for precision :)
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I fixed it on Hg repo now.


Takashi
  </pre>
</blockquote>
Seems like I missed some others <span class="moz-smiley-s1"><span> :-)
</span></span><br>
<br>
Ben<br>
<blockquote cite="mids5h3bg1zldj.wl%25tiwai@suse.de" type="cite">
  <pre wrap="">

-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
<a class="moz-txt-link-freetext" href="http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642</a>
_______________________________________________
Alsa-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Alsa-devel@lists.sourceforge.net">Alsa-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/alsa-devel">https://lists.sourceforge.net/lists/listinfo/alsa-devel</a>
  </pre>
</blockquote>
</body>
</html>

--------------020905030905030100040109--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
