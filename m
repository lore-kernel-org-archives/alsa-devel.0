From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] ALSA: lib: Fix static linking of libasound
Date: Mon, 03 Jan 2011 10:50:54 +0000
Message-ID: <ifs9me$v2o$1@dough.gmane.org>
References: <AANLkTi=BLZ-HFM4G6D6ZTLtUT5JCaXANS-hgVBC2SAXn@mail.gmail.com>	<alpine.LNX.2.00.1101011604200.28150@eeebox2.perex-int.cz>	<AANLkTinHXVVVykSh7uzCKNKv5NJsP5AVtj6-dDdzLDmb@mail.gmail.com>
	<alpine.LNX.2.00.1101020041250.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id EF4F82437A
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 11:51:09 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1PZi0H-0007lY-Dg
	for alsa-devel@alsa-project.org; Mon, 03 Jan 2011 11:51:05 +0100
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 03 Jan 2011 11:51:05 +0100
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 03 Jan 2011 11:51:05 +0100
In-Reply-To: <alpine.LNX.2.00.1101020041250.28150@eeebox2.perex-int.cz>
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

'Twas brillig, and Jaroslav Kysela at 01/01/11 23:42 did gyre and gimble:
> On Sat, 1 Jan 2011, Daniel Chen wrote:
> 
>> On Sat, Jan 1, 2011 at 10:07 AM, Jaroslav Kysela <perex@perex.cz> wrote:
>>> Is any reason to ignore this configure settings mentined in the INSTALL file
>>> for the static library build?
>>>
>>> ./configure --enable-shared=no --enable-static=yes
>>>
>>> It's mainly libtool issue and having static hacks in the dynamic library
>>> does not make much sense.
>>
>> According to Samuel in the Debian bug report, "when both static &
>> dynamic linking is enabled, automake gets it wrong and uses only the
>> dynamic objects."
>>
>> Is the best course of action here to do a two-pass build, one with
>> "--enable-shared=no --enable-static=yes" and another with
>> "--enable-shared=yes --enable-static=no", simply copying the desired
>> libasound.a from the second pass?
> 
> Yes, I believe, it's the right way to compile both types of library 
> binaries.

Shouldn't the argument then be one that is mutually exclusive then?

e.g. --build-type=[shared||static]

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
