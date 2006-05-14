From: Patrick Strasser <patrick.strasser@tugraz.at>
Subject: Re: Everything You Could Ever Need to Know About ALSA
 - ALSA docs
Date: Sun, 14 May 2006 23:34:01 +0200
Message-ID: <4467A249.8050804@tugraz.at>
References: <e47c8v$gn0$2@sea.gmane.org> <1147629608.27252.63.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1147629608.27252.63.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sun, 2006-05-14 at 15:45 +0200, Patrick Strasser wrote:
>> What is this thing about the device?
>>
>> First the most important question:
>> I know for now that in a standard configuration "hw:0,0" is quite
>> fine. 
>> For the second card "hw:1,0" is hopefully working. What exactly does 
>> that mean?
>> Sometimes I see "plughw:0,0". What's the difference to "hw:0,0"?
>> How can I find out which device strings are valid (except for
>> guessing?)
> 
> Not quite, you should just use "default" (or "default:0" for the first
> card, "default:1" for the second).

Ok.
I just nowhere found a definition for this :-)

>  Only use hw:x if you know what you
> are doing.

I need something to select my CD sound to record from.

> Really, you should not have to know this - the app should have a drop
> down menu to select the device.

Command lines don't have dropdowns. Aplayer does _not_ give you a list 
with default, default:0, default:1, hw:0,0, hw:0,1 and sensible device 
descriptions for copy-paste.

> This page explains the varous devices:
> 
> http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html

I read this. One primary fact that is missing:
What is a slave?
I don't want a syntactical description, but a semantical. It's used in 
the before mentioned document, but I couldn't find paragraph about slaves.

>> Next: How can I find out which device is the device my speakers are 
>> connected to?
>>
> 
> You can't.  Speaker jacks don't normally support this.  
Of course ;->
> You just have to
> select the various devices in your app and see which one gives you
> sound.  
I thought of some tool that scans through all available channels (left, 
right, center, rear left, rear right, subwoofer, etc.) and pronounce the 
device name and the channel name.  So you would connect your speakers 
like you think it could work and try to get some info about 
device+channel to speaker mapping.

Patrick
-- 
Engineers motto: cheap, good, fast: choose any two
Patrick Strasser <patrick dot strasser at  tugraz dot at>
Student of Telematik, Techn. University Graz, Austria


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
