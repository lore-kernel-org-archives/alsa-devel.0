From: Harald Gutmann <harald.gutmann@gmx.net>
Subject: Re: joining 2 mixer ports with .asoundrc?
Date: Sat, 02 Sep 2006 02:09:02 +0200
Message-ID: <44F8CB9E.8070108@gmx.net>
References: <44F8348E.2040200@gmx.net>	<20060901174734.GA2629@localhost.localdomain>
	<s5hfyfbmr4g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hfyfbmr4g.wl%tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Takashi Iwai schrieb:
> At Fri, 1 Sep 2006 18:47:34 +0100,
> John Rigg wrote:
>   
>> On Fri, Sep 01, 2006 at 03:24:30PM +0200, Harald Gutmann wrote:
>>     
>>> hello!
>>>
>>> i've here a m-audio 1010lt with an ice1712 chip.
>>> on this card, there is no pcm mixer channel per default, but i think it 
>>> should be possible to add on in the .asoundrc file.
>>>       
>> You shouldn't need to set this up in .asoundrc. The 1010LT has a very
>> good mixer available for it: envy24control from alsa-tools. You can set
>> up the card with this and the settings will usually be restored on reboot
>> (depending on how your distro works).
>>     
yes, i know the envy24control, and it's a really fine mixer application,
but the restoring of the mixer settings on bootup and so on, is not the 
problem.

the goal of combining the first two mixer parts for output,
which are the once i use moste of the time to hear music
(sometimes  i use the 3rd and the 4th for monitoring on my headphones),
is that i've a normal PCM mixer control, which is used by default from 
nearly
every audio application which supports alsa, to have an easy way to 
control the loudness of the output.

>
> Right.  But apart from that, a combined mixer is actually an
> interesting topic.
>
> Unfortunately, there is no framework for the combined mixer elements
> (unlike PCM) right now.  In theory, this could be implemented via
> alsa-lib mixer plugin.
>   
is it planned to add such a framework for combining mixers per .asoundrc?
i think it would be a good idea to add a similar framework like it's 
used to
route audio in the .asoundrc.


best regards,
harald gutmann

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
