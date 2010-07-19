From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Which project to choose?
Date: Mon, 19 Jul 2010 08:53:51 +0100
Message-ID: <i210af$6gi$1@dough.gmane.org>
References: <1279062131.24837.22.camel@localhost.localdomain>	<AANLkTikEf4gf-oeQf4hNGUEvNi0YVrvutnSMCbxGwtJ8@mail.gmail.com>	<1279065709.24837.29.camel@localhost.localdomain>	<AANLkTimdM5__SzYFxrQqwsbOrxdit2uWOvkazPvZ4PND@mail.gmail.com>	<1279071115.29042.0.camel@localhost.localdomain>	<AANLkTimNSRELBq7i1Ypi9K2tmFu9NKLvQAOOqPwuU13x@mail.gmail.com>	<1279074303.29042.3.camel@localhost.localdomain>	<AANLkTimNYxIm9M6Mglrzh3YtJRiq1C8wdZwx-JUhLk9d@mail.gmail.com>	<1279145758.29042.11.camel@localhost.localdomain>	<AANLkTinN15BWNC2cn78rc5xCSXNo79SDE2_WkBNEg5I2@mail.gmail.com>	<1279157921.2668.1.camel@localhost.localdomain>	<i1n0mf$87c$1@dough.gmane.org>	<AANLkTil8Zq_uJrdT2jcVSSDW-LN0OxpnHcGnI9aBR4Zz@mail.gmail.com>	<1279508164.22741.27.camel@localhost.localdomain>
	<AANLkTilHj1RR50u0kN7cedIuV72qxqvTX1YDriT6ajqi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 2DF40103847
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 09:54:04 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OalAp-0000xy-LW
	for alsa-devel@alsa-project.org; Mon, 19 Jul 2010 09:54:03 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 09:54:03 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 19 Jul 2010 09:54:03 +0200
In-Reply-To: <AANLkTilHj1RR50u0kN7cedIuV72qxqvTX1YDriT6ajqi@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 19/07/10 07:35 did gyre and gimble:
> 2010/7/19 Chris <cpollock@embarqmail.com>
> 
>> On Mon, 2010-07-19 at 09:44 +0800, Raymond Yau wrote:
>>
>>>>
>>> Refer to https://qa.mandriva.com/show_bug.cgi?id=56473#c10
>>>
>>> I have installed mandriva 2010 on virtual box
>>>
>>> when using xmms and libao output plugin to play system sound startup3.wav
>>>
>>> xmms hang at the end of the playback only when enable buffering in libao
>>> output plugin.(configure output plugin in xmms, unfortunately default is
>>> enable buffering buffer size 3000 chunk size 1000)  ,
>>>
>>> xmms does not hang when you disable the buffer or using liboss/libALSA
>>> output plugin
>>>
>>> The last message in the pulseaudio server is
>>> D: protocol-native.c  'underrun on libao[xmms] playback stream' , 0 bytes
>> in
>>> queue.
>>>
>>> The sound card seem running since hw_ptr and appl_ptr are increasing when
>>> cat /proc/asound/card0/pcm0p/sub0/status
>>>
>>> After a while , the following message appear
>>>
>>> E:alsa-sink.c : ALSA woke us up to write new data , but there was
>> actually
>>> nothing to write!
>> The above is exactly what I see periodically Raymond, so, what, if any,
>> is the fix?
>>
>> Chris
>>
>>
> Do you mean that you cannot reproduce the xmms hang bug on your ens1371 or
> via8237 ?
> 
> xmms always hang/freeze at 4 second as xmms display the total length of
> startup3.wav is 5 seconds
>
> you have to ask mandriva 's maintainer why enable buffering is the default
> option since xmms did not hang when I disable buffering in libao plugin
> 
> For fefora 10 and 13 , they only provide liboss, libALSA and libpulse plugin
> for xmms
> I have no idea about the chunk size in libao plugin


With a clean user account, I could not reproduce either problem with the
default settings.

FWIW, running PA under virtualbox is quite different to running it under
a real system. For example PA will enable the non-timer based mode
automatically when under a virtual machine.

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
