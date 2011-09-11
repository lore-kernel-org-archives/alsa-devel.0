From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Consider revert? (was Re: [PATCH 0/3] Fallback
 mechanism for pulse plugin)
Date: Sun, 11 Sep 2011 13:17:16 +0100
Message-ID: <4E6CA6CC.4020607@colin.guthr.ie>
References: <s5hk4b5w7aq.wl%tiwai@suse.de> <4E624761.5000305@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 0D4A8246F9
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Sep 2011 14:17:19 +0200 (CEST)
In-Reply-To: <4E624761.5000305@colin.guthr.ie>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've only just noticed that this patch series has already been committed
to the tree.

As stated below, I really don't think it's a good idea to activate this.
And if it's not activated, are there any other non-PA related cases
where this makes sense? If not, perhaps this API should be reverted
before an official release if you agree with my comments below.

Col


'Twas brillig, and Colin Guthrie at 03/09/11 16:27 did gyre and gimble:
> Hi,
> 
> Sorry for the late reply.
> 
> 'Twas brillig, and Takashi Iwai at 26/07/11 14:33 did gyre and gimble:
>> Hi,
>>
>> the following are experimental patches for implementing the fallback
>> option of PCM / control pulse plugin.  When the connection to PA
>> server fails, the plugin tries to open the fallback name.
>>
>> For achieving this, I added the new standard definition "sysdefault",
>> which is equal with the normal "default" PCM / control definitions.
>> The difference is only the name, i.e. it won't be overridden by other
>> setups.  Then two new API functions for opening a fallback PCM /
>> control, and finally a patch for pulse-plugin will follow.  All
>> changes are relatively small and easy.
>>
>> Let me know if you have any suggestions or a better idea.
> 
> Personally I don't really like this idea at all.
> 
> If the connection fails, then it could hog the device preventing other
> clients from working correctly.
> 
> This could happen e.g. if you do:
> 
> PULSE_SERVER=192.168.1.99 aplay some.wav
> 
> Here it is quite expected that the connection will fail if the network
> is down but the last thing I want it to do is to open the local sound
> device.
> 
> The same would be true if you SSH'ed to a remote machine, taking the PA
> connection config with you in the X11 root window PULSE_SERVER property.
> If the user has not enabled their tcp protocol option or doesn't have
> the relevant port open on their firewall, then you really don't want
> them to open the sound device on the remote machine.
> 
> So while I can see some use cases for this, I think it would be much
> better to ensure that if the user wants to use PA, that their asoundrc
> setup is just configured correctly, not have any kind of automatic
> fallback. I have made similar complaints against the approach Ubuntu
> take here... it's quite different in that they have a dynamic "asoundrc"
> type config before it even speaks to the module.
> 
> In their case there are many corner cases relating to non-local PAs, but
> in that case the opposite problem is true, i.e. it will NOT use a remote
> PA if a local one is not running...
> 
> So really, I'd very much like to not have this support in here as it'll
> just make debugging many times harder for me. I'd also like to see the
> Ubuntu system removed too.
> 
> Col
> 


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
