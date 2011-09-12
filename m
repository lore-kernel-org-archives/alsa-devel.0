From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] conf: Allow for a directory to be given as
 a config file.
Date: Mon, 12 Sep 2011 09:23:15 +0100
Message-ID: <4E6DC173.2090404@colin.guthr.ie>
References: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
	<1315744838-21911-2-git-send-email-gmane@colin.guthr.ie>
	<4E6DAD66.3080204@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144]) by alsa0.perex.cz (Postfix) with ESMTP id 11FFB24400
	for <alsa-devel@alsa-project.org>;
	Mon, 12 Sep 2011 10:23:18 +0200 (CEST)
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

Sure if you prefer it that way I can implement it. Seems a little overly
designed to me, but it should be easy enough to support.

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
