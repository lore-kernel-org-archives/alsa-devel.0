From: Ian Malone <ibmalone@gmail.com>
Subject: Re: Fwd: [Alsa-user] Recording spdif/iec958 on	ice1724
 terratec aureon 7.1 space
Date: Thu, 22 Jun 2006 17:17:00 +0100
Message-ID: <449AC27C.1000403@gmail.com>
References: <124299980606190740v47ab8c9dgedbb88a9f607a572@mail.gmail.com>	<s5hwtbdi02g.wl%tiwai@suse.de>	<4497355D.80704@gmail.com>	<1150761326.2754.75.camel@mindpipe>	<4497A8E6.9020002@gmail.com>	<s5hfyi0i1u5.wl%tiwai@suse.de>	<44982662.1030502@gmail.com>
	<s5hzmg5baii.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hzmg5baii.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> At Tue, 20 Jun 2006 17:46:26 +0100,
> Ian Malone wrote:
>> Takashi Iwai wrote:
>>> At Tue, 20 Jun 2006 08:51:02 +0100,
>>> Ian Malone wrote:
>>>> That's it!  Thanks very much.
>>>> I had to use alsactl restore to make the change though;
>>>> toggling the IEC958 capture source in alsamixer doesn't
>>>> seem to have any effect.
>>>> Anyway, working nicely now, thanks again.
>>> "IEC958 capture switch" should exist independently from "IEC958
>>> capture source".  There might some confliction in the mixer
>>> abstraction.  Could you show the output of amixer?
>>>
>>>
>>
>> Attached.
> 
> (snip)
> 
>> Simple mixer control 'IEC958',0
>>   Capabilities: cswitch cswitch-joined enum
>>   Items: 'PCM Out' 'H/W In 0' 'H/W In 1' 'IEC958 In L' 'IEC958 In R'
>>   Item0: 'PCM Out'
> 
> OK, the problem is the confliction of "IEC958 Playback Route" and
> "IEC958 Capture Switch".
> 
> We need to fix either mixer layer or rename it, e.g. from "Playback
> Route" to "Playback Source".
> 
> The patch below (for alsa-lib) is a temporary workaround to add the
> automatic toggle of "IEC958 Capture Switch" over iec958 (spdif) PCM.
> This makes the spdif recording working even without the fix suggested
> in the above.
> 
> Please try the patch, and once turn off "IEC958 Capture Switch"
> manually (via alsactl store and restore), then record via "spdif" PCM,
> such as
> 	% arecord -Dplug:spdif -fdat foo.wav
> 
> If it's confirmed to work, I'll commit to HG repo.
> 
> 

Works here (except that setting HW 1&2 to IEC958 will still only
send SPDIF in directly to the speakers if IEC958 Capture Switch
is turned on in asound.state, although I'm not sure whether
that's by design, but recording works).

-- 
imalone

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
