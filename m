From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Problem with PPH plugin
Date: Thu, 21 Jan 2010 16:05:04 +0000
Message-ID: <hj9tvb$68u$1@ger.gmane.org>
References: <hj4rap$ofp$2@ger.gmane.org>	<s5hr5pljj7a.wl%tiwai@suse.de>	<loom.20100120T231250-50@post.gmane.org>	<s5hfx60csn8.wl%tiwai@suse.de>	<loom.20100121T115627-815@post.gmane.org>	<4B5864CE.4090807@colin.guthr.ie>
	<loom.20100121T160205-331@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 0455E1037F5
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 17:09:28 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.50) id 1NXzZL-0004pw-NS
	for alsa-devel@alsa-project.org; Thu, 21 Jan 2010 17:07:39 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 17:07:39 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 17:07:39 +0100
In-Reply-To: <loom.20100121T160205-331@post.gmane.org>
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

'Twas brillig, and Anton Yashin at 21/01/10 15:04 did gyre and gimble:
> Colin Guthrie <gmane <at> colin.guthr.ie> writes:
> 
>>
>> I'm not sure where Raymond sees flashsupport.c...
>>
>> Could it be that you have libflashsupport.so (probably in /usr/lib/) on
>> your system somewhere? If so you should try removing it (e.g. finding
>> which package owns the file - rpm -qf <file> - and then removing the
>> package) and see if the problem goes away.
>>
>> It's used to extend Flash player and I guess it could be cocking up
>> somewhere or other.
>>
>> Col
>>
> 
> Hi
> 
> #LANG=C find / | grep libflashsupport
> find: `/home/anton/.gvfs': Permission denied
> 
> May be this some internal features of flash player?

flashsupport is an external system. If your system has a
libflashsupport.so file it will be loaded into the flashplayer. We used
to use this some time ago when Flash's audio support was shocking
(libflashsupport.so was used to provide pulseaudio support). Now flash
works OK with alsa and PA via alsa, we no longer need this. Just wanted
to ensure you weren't generating some odd code paths as a result of this
file being present. It seems you are not and thus, I don't think
flashsupport is an issue (tho as the internals of Flash are a black box
I can't be 100% certain).

Cheers

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
