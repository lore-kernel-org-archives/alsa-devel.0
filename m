From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] conf: Allow for a directory to be given as
 a config file.
Date: Tue, 13 Sep 2011 22:00:28 +0100
Message-ID: <4E6FC46C.6080007@colin.guthr.ie>
References: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
	<1315744838-21911-2-git-send-email-gmane@colin.guthr.ie>
	<4E6DAD66.3080204@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 0034524332
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 23:00:32 +0200 (CEST)
In-Reply-To: <4E6DAD66.3080204@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Jaroslav Kysela at 12/09/11 07:57 did gyre and gimble:
> Date 11.9.2011 14:40, gmane@colin.guthr.ie wrote:
>> From: Colin Guthrie <colin@mageia.org>
>>
>> When this is done, *.conf files can be placed in that directory and they
>> will be processed by as if they were included directly.
>>
>> A directory (typically /usr/share/alsa/alsa.conf.d/) has been
>> added into the distribution.
> 
> Thanks for this patch.
> 
> 
>> +@hooks [
>> +	{
>> +		func load
>> +		files [
>> +			"@ALSA_CONFIG_DIR@/alsa.conf.d/"
> 
> I think that it might be more flexible and analogical to keep the
> original configuration file and implement the confdir function - see the
> datadir example.
> 
> Implemented:
> 
> 	"{ @func datadir }"
> 
> To be added:
> 
> 	"{ @func confdir }"
> 
> See snd_func_datadir() in confmisc.c.
>

I had a look at the implementation of snd_func_datadir and it actually
returns ALSA_CONFIG_DIR already, so I actually don't need to do anything
special here, just use @func datadir and a bit of concatenation.

New patch coming up.

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
