From: Volker Schroer <dl1ksv@gmx.de>
Subject: Re: Problem with M5455 card
Date: Tue, 07 Nov 2006 21:25:30 +0100
Message-ID: <4550EBBA.8040907@gmx.de>
References: <454DADAE.3020609@gmx.de>	<s5h3b8whdq8.wl%tiwai@suse.de>	<454F9C9D.8080008@gmx.de>
	<s5hbqnjfstk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hbqnjfstk.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
>>>>     
>>>>         
>>> I guess it's rather a conincidence that it worked with another card.
>>> Or, possibly, conversion between S16 and float in alsa-lib plugin
>>> might be broken.
>>>
>>>   
>>>       
>>  Well, but not all samples contain bad values. Only after some times 
>> some bad values appear.
>>     
>
> Hm, then the problem could be in the rate conversion.
> M5455 uses only 48kHz (by some reason).  Try to run with 48kHz.
>
>
>   

I did that, but no change. Only the size of the bad valus gets smaller  
(about 10e*16).

Volker
>
>   


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
