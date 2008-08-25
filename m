From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Sound Blaster Audigy (snd_ca0106 Creative Labs|SB
 Audigy LS): How to use the mixer?
Date: Mon, 25 Aug 2008 18:14:05 +0100
Message-ID: <g8up8t$v0i$1@ger.gmane.org>
References: <g8tpis$ddd$1@ger.gmane.org> <s5hskstebj1.wl%tiwai@suse.de>
	<g8trnk$la5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id BB4832450D
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Aug 2008 19:14:19 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KXfdw-0001HA-LZ
	for alsa-devel@alsa-project.org; Mon, 25 Aug 2008 17:14:16 +0000
Received: from 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk
	([80.192.67.147]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2008 17:14:16 +0000
Received: from gmane by 80-192-67-147.cable.ubr10.edin.blueyonder.co.uk with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 25 Aug 2008 17:14:16 +0000
In-Reply-To: <g8trnk$la5$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Colin Guthrie wrote:
> Takashi Iwai wrote:
>> At Mon, 25 Aug 2008 09:13:16 +0100,
>> Colin Guthrie wrote:
>>> Hi,
>>>
>>> Just trying to help a user with a problem and it seems to be down to the
>>> fact that his SB Audigy LS does not have a "Master" or "PCM" mixer control.
>>>
>>> I asked Lennart about this and he told that Takashi said he wanted to 
>>> make sure that all devices have at least a Master vol control.
>>>
>>> This one doesn't!
>>>
>>> Please let me know what you need in order to fix this.
>>>
>>> This is with 1.0.17... I can't see anything in the changelog that would 
>>> suggest this is fixed in the 1.0.18rc1.
>> Did you update *driver*?  Updating alsa-lib won't fix the problem.
> 
> Yeah I made sure the user was on a 1.0.17 *driver* confirmed via 
> /proc/asound/version (he was originally confused about lib and driver 
> versions but I corrected him there already!)
> 
>> The recent ca0106 driver has a virtual master control, so this should
>> have been fixed.
> 
> Cool, thanks. Is that post 1.0.17? From you comment about updating the 
> driver, I suspect it was supposed to be in 1.0.17 (/me looks) hmm yes:
> 
> http://www.alsa-project.org/main/index.php/Changes_v1.0.16_v1.0.17#CA0106_driver
> 
> 
> This is odd. I definitely requested that the user ensure the driver 
> version is 1.0.17 (he confirmed it by /proc/asound/version) and then run 
> amixer -c 0 to output the previously attached dump (which does not have 
> a Master).

I've confirmed the user is using 1.0.17.

The kernel is 2.6.27rc(something). So perhaps the driver is missing 
something for certain hardware?

His PCI Ids are:

lspci -nn | grep -i aud
00:0a.0 Multimedia audio controller [0401]: Creative Labs SB Audigy LS 
[1102:0007]

Col

-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
   Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
   Mandriva Linux Contributor [http://www.mandriva.com/]
   PulseAudio Hacker [http://www.pulseaudio.org/]
   Trac Hacker [http://trac.edgewall.org/]
