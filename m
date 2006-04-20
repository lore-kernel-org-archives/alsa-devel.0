From: "alasinski" <alasinski@rogers.com>
Subject: Re: How to access vendor specific AC97 codec register?
Date: Thu, 20 Apr 2006 11:48:19 -0400
Message-ID: <e28ag6$1hb$1@sea.gmane.org>
References: <e28805$nlf$1@sea.gmane.org> <1145546855.3008.0.camel@mindpipe>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Thx Lee,

I have looked at pxa2xx-ac97.c driver. It provides generic functions to 
read/write any ac97 register: pxa2xx_ac97_read/write that are made available 
to generic ac97_codec with snd_ac97_bus() call. My problem is I don't know 
how to invoke those functions with proper arguments from application level. 
It all goes through the generic concept of element I suppose. I fail to 
correlate element value with a particular register I want. So far I'm lead 
to believe that there is no need to change a driver, perhaps only do 
configuration on asoundlib.

Do you see the way how to do it ?

cheers
-al

"Lee Revell" <rlrevell@joe-job.com> wrote in message 
news:1145546855.3008.0.camel@mindpipe...
> On Thu, 2006-04-20 at 11:05 -0400, alasinski wrote:
>> I need to do IO specific operation from UCB1400 on Snapper Arm board.
>> This has to be done from C code as it is part of a larger project. All
>> what I need is to be able to read and write content of the few vendor
>> specific AC97 codec registers: 0x5A,0x5C. I'm not interested with any
>> other ALSA functionality.
>
> Did you read the "Writing an ALSA driver" document?  It sounds like you
> just want simple mixer controls (change the value of the codec register
> when user toggles a mixer control)?  Look at any existing ALSA driver
> for an example.
>
> Lee
>
>
>
> -------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job 
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642 





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
