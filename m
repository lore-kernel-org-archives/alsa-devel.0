From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] Per Application Volume Control plugin for
	ALSA
Date: Sun, 17 Oct 2010 12:21:21 +0100
Message-ID: <i9em7h$kdf$2@dough.gmane.org>
References: <AANLkTikq=9HHQgsdK6CJfNfdOnX5xkBgcLTLrS_Y7Fv8@mail.gmail.com>
	<s5hsk05urj6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id C6934244F0
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Oct 2010 13:25:06 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1P7RMO-0003qO-It
	for alsa-devel@alsa-project.org; Sun, 17 Oct 2010 13:25:04 +0200
Received: from cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	([94.173.13.3]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2010 13:25:04 +0200
Received: from gmane by cpc1-sgyl30-2-0-cust258.sgyl.cable.virginmedia.com
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 17 Oct 2010 13:25:04 +0200
In-Reply-To: <s5hsk05urj6.wl%tiwai@suse.de>
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

'Twas brillig, and Takashi Iwai at 17/10/10 09:55 did gyre and gimble:
> At Wed, 29 Sep 2010 18:56:59 +0200,
> James Huk wrote:
>>
>> Hello everybody.
>>
>> This is my first "post" here, so please be "gentle".
>>
>> I have created PAVC plugin for ALSA, it is based on COPY plugin, and
>> use SOFTVOL plugin for sound output. As far as I can tell from current
>> tests - It works perfectly, and it doesn't break compatibility with
>> any apps I use (and PulseAudio does). So I was wondering - is there
>> any chance this plugin would be added to the next official ALSA
>> release?
>>
>> Here is the patch that enables it on current alsa-lib-1.0.23
>> (hopefully this mailing list is a good place to "post" this):
> 
> Thanks for the patch.  I looked over this post until now.
> 
> The idea is interesting, and I thought of a similar thing before PA
> gets popularized, too.
> 
> Though, this implementation is a bit too hackish, especially the part
> using pipe & co.  If we have a more simpler and cleaner way for this,
> it's worth including to the standard plugin, I think.

I was thinking much the same thing when I read over this patch a few
weeks ago.

While it could be interesting to include this in alsa, I struggled to
think of a use case where PA would not be more appropriate.

Is there a specific use case targeted with this patch or is it really
just a "proof of concept" demonstration that alsa can do this sans PA?

Col

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
