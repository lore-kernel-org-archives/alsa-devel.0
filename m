From: Juergen Hennerich <juergen@hennerich.eu>
Subject: Re: Flash 9
Date: Wed, 25 Oct 2006 01:38:04 +0200
Message-ID: <453EA3DC.9020206@hennerich.eu>
References: <1161720441.3982.124.camel@mindpipe>	<453E87BD.8020900@hennerich.eu>	<1161729155.3982.186.camel@mindpipe>
	<200610250036.45627.prakash@punnoor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200610250036.45627.prakash@punnoor.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Lee Revell <rlrevell@joe-job.com>
List-Id: alsa-devel@alsa-project.org

Prakash Punnoor schrieb:
> Am Mittwoch 25 Oktober 2006 00:32 schrieb Lee Revell:
>> On Tue, 2006-10-24 at 23:38 +0200, Juergen Hennerich wrote:
>>> Because you find those strings in the library, doesn't necessarily
>>> mean, that there is code from libasound in this library.
>>>
>>> -> man dlopen
>> Ah, I see.  Why would one use dlopen() for some libraries but regular
>> dynamic linking for others?
> 
> To not be dependant on the lib. The prog will still work in dlopen case.
> 
I guess, they could have achieved the same with weak linking. I don't 
know if there are really any technical reasons to prefer dlopen/dlsym 
over weak linking, or if that is just a matter of taste.

Juergen


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
