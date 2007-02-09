From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH]: __devinit and __devexit changes to
	various sound drivers
Date: Fri, 09 Feb 2007 07:11:41 -0500
Message-ID: <45CC64FD.7090708@redhat.com>
References: <20070208170948.18004.89673.sendpatchset@prarit.boston.redhat.com>
	<s5hsldfo8cc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hsldfo8cc.wl%tiwai@suse.de>
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
Cc: michael@tweakoz.com, alsa-devel@lists.sourceforge.net, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


>>  	
>> -static int snd_dummy_resume(struct platform_device *pdev)
>> +static int __devexit snd_dummy_resume(struct platform_device *pdev)
>>     
>
>   

> You're shooting the wrong function :)
>   


Whoops. :)  My bad.
> Also, if we change this (obviously correct), we should change all
> __init* to __devinit* accordingly.  Care to fix these?
>
>
>   

No problem -- I'll take care of that and send another patch.

(To be honest, I haven't compiled _everything_ in the directory.  I've 
been lazily working of the fedora .config ;) )

Be back in a few days ...

P.

> Thanks,
>
> Takashi
>   

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
