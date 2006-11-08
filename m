From: Himanshu Chauhan <hs.chauhan@gmail.com>
Subject: Re: Using driver service from another driver
Date: Wed, 08 Nov 2006 21:56:32 +0530
Message-ID: <45520538.2090001@gmail.com>
References: <4550BFBA.6050400@gmail.com> <s5hwt65vs3i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwt65vs3i.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Tue, 07 Nov 2006 22:47:46 +0530,
> Himanshu Chauhan wrote:
>   
>> Dear all,
>>
>> I am writing a virtual audio driver (similar to dummy.c in alsa tree).
>> But I need to
>> access the driver services of the soundcard installed on the system. How
>> can this
>> be done? Can I directly call the functions or I need to specifically
>> open the
>> device?
>>     
>
> The question is too ambiguous to answer.  Could you elaborate what you
> want to achieve?  Something like output <-> input loopback?
>
>
> Takashi
>
>   
Okay. I am writing a dummy driver from which the application play and
record.
Suppose, mplayer is playing some movie and the audio is going to this dummy
driver and Audacity is running which is recording from this dummy driver
 (the stream coming from mplayer). But as no actual device is there, user
can't listen to what is being played or recorded. I want a playthru like
thing
so that whatever data audacity is getting for recording can also be
directed to an actual sound card driver from within the kernel.
So that user can listen to whatever is being played by mplayer and
is being recorded by audacity.

Same thing can be achieved by enabling playthru in audacity but I
wish to do it in kernel mode using services of a driver for which
actual hardware is present in the system.


--Himanshu

-- 
=============================
     Himanshu Chauhan
	System Software Engineer
	inDSP Audio Technologies
	341 Nila
	Technopark
	Trivandram, Kerala

	M:(+91)-(999)-(518)-(5989)
=============================


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
