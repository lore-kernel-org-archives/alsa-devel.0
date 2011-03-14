From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] alsa-driver git repo: Build problems when
 copying symlink to itself
Date: Mon, 14 Mar 2011 11:25:02 +0000
Message-ID: <4D7DFB0E.3010100@colin.guthr.ie>
References: <ilfi0p$7hr$1@dough.gmane.org>
	<alpine.LNX.2.00.1103141051450.4805@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F7441037F3
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 12:25:24 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pz5to-0004Q6-FX
	for alsa-devel@alsa-project.org; Mon, 14 Mar 2011 12:25:20 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 12:25:20 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 14 Mar 2011 12:25:20 +0100
In-Reply-To: <alpine.LNX.2.00.1103141051450.4805@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Jaroslav Kysela at 14/03/11 09:54 did gyre and gimble:
> On Sat, 12 Mar 2011, Colin Guthrie wrote:
> 
>> Hi,
>>
>> After doing a "simple":
>> git clone alsa-driver
>> git clone alsa-kernel
>> cd alsa-driver
>> ./gitcompile --with-debug=full --with-isapnp=yes --with-sequencer=yes
>> --with-moddir=updates/alsa:
>>
>> The build bombed out pretty quickly with the following error.
>>
>> The attached patch fixes it.
>>
>> Hacking autoconf.h...
>> make[1]: Entering directory
>> `/home/colin/Development/Personal/ALSA/alsa-driver/include'
>> make -C sound prepare
>> make[2]: Entering directory
>> `/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
>> make prepare2
>> make[3]: Entering directory
>> `/home/colin/Development/Personal/ALSA/alsa-driver/include/sound'
>> cp ../../alsa-kernel/include/ac97_codec.h .
>> patch -p0 -i ac97_codec.patch ac97_codec.h
>> patching file ac97_codec.h
>> Hunk #1 succeeded at 650 (offset 5 lines).
>> cp ../../alsa-kernel/include/core.h .
>> patch -p0 -i core.patch core.h
>> patching file core.h
>> cp ../../alsa-kernel/include/info.h .
>> cp: `../../alsa-kernel/include/info.h' and `./info.h' are the same file
> 
> I don't see this error using 'alsa-compile.sh --git' on Fedora 14... Make 
> sure that the alsa-driver tree is clean before build.

Both trees are clean.

They are clones from

git://git.alsa-project.org/alsa-driver.git
 and
git://git.alsa-project.org/alsa-kernel.git

I'm trying Takashi's other repos, now but the sound-2.6 clone is taking
about 2h and counting....

Also Jaroslav, are you the list admin? I've always send mails to this
list via gmane, but as reply-all is the etiquette, I want to make sure
I'm registered and such for posting. But the mailman admin page wont let
me subscribe or send me password reminders (and thus wont let me
unsubscribe to resubscribe either :s) Not sure how to deal with the
chicken and egg problem (other than changing my email address which I'll
probably do at some point soon for other reasons anyway).

Cheers

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
