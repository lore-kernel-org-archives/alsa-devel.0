From: Simon Lewis <simon.lewis@mnet-online.de>
Subject: Re: pcm_multi broken in alsa-lib - no duplex mode
Date: Sun, 11 Mar 2007 19:33:37 +0100
Message-ID: <45F44B81.9060206@mnet-online.de>
References: <45F044D2.1060903@mnet-online.de>	<s5hslcfmuk0.wl%tiwai@suse.de>	<20070308215128.GA3349@localhost.localdomain>
	<s5hslcegynp.wl%tiwai@suse.de>
Reply-To: simon.lewis@mnet-online.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hslcegynp.wl%tiwai@suse.de>
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

Dear Takashi

I think I have another pointer which may help solve this problem.

The libasound.so.2.0.0 compiled using the pcm_multi in alsa-lib-1.0.13
has a compiled size of 719.6 kB on openSUSE 10.2.

The patched pcm_multi (that is the unlinked version from
alsa-lib-1.0.8)  has a complied size of 2.6 MB.

To my naive way of thinking, the current pcm_multi forgets to compile
63% of the code..!


Further, no complicated hardware is needed to test the pcm_multi in
duplex mode.

Any sound card can be used that has an alsa-driver similar to ca0106
whereby the surround sound outputs are assigned to two or more devices -
each device being a stereo pair. Use the function type "multi" in
asound.conf to combine all the devices back to one virtual hardware and
then try using the "combined" virtual driver in duplex mode, e.g from
QJackCtl.


Best reagrds, Simon



Takashi Iwai schrieb:
> At Thu, 8 Mar 2007 21:51:28 +0000,
> John Rigg wrote:
>   
>> On Thu, Mar 08, 2007 at 07:58:23PM +0100, Takashi Iwai wrote:
>>     
>>> At Thu, 08 Mar 2007 18:16:02 +0100,
>>> Simon Lewis wrote:
>>>       
>>>> Many JACK users have successfully used the following patch:
>>>>
>>>> http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch
>>>>         
>>> Well, the patch is no real fix.  It's likely a workaround for JACK,
>>> though.  Someone has to take time to track down this bug more deeply.
>>>       
>> True, the patch is just a workaround for JACK. However, I would
>> argue that most users of pcm_multi are probably JACK users.
>>     
>
> No, multi plugin is used in many surround PCM definitions as default.
> It's pretty hidden, but multi streams are no rare case.
>
>   
>> Surely adding code that breaks something for the majority of users (no
>> matter how correct that code is in isolation) is not a good thing.
>>     
>
> Sure.  However, this code addition was for bugfixes of major other use
> cases like above, IIRC.  The regression should be avoided and should
> be fixed.  But the point is, we (at least, I) haven't been enough
> informed, unfortunately (or simply burried in a big TODO list :)
>
> Now, let's back to the original problem:  Could someone give a pointer
> describing for this problem, or just explain a bit details here?
> I vaguely remember but not precisely at all now...
> I'm willing to dig down after knowing how I can reproduce the bug.
>
>
> thanks,
>
> Takashi
>
>
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
