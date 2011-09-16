From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: [PATCH] conf: Allow for a directory to be given as
 a	config file.
Date: Fri, 16 Sep 2011 09:28:45 +0100
Message-ID: <4E7308BD.1030407@colin.guthr.ie>
References: <1315744838-21911-1-git-send-email-gmane@colin.guthr.ie>
	<1315947840-27615-1-git-send-email-gmane@colin.guthr.ie>
	<1315947840-27615-2-git-send-email-gmane@colin.guthr.ie>
	<s5h8vppt1y7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 63C87103CE3
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 10:28:46 +0200 (CEST)
In-Reply-To: <s5h8vppt1y7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Takashi Iwai at 16/09/11 07:51 did gyre and gimble:
> At Tue, 13 Sep 2011 22:04:00 +0100,
> gmane@colin.guthr.ie wrote:
>>
>> From: Colin Guthrie <colin@mageia.org>
>>
>> When this is done, *.conf files can be placed in that directory and they
>> will be processed by as if they were included directly.
>>
>> A directory (typically /usr/share/alsa/alsa.conf.d/) has been
>> added into the distribution.
> 
> In this code, the error behavior looks inconsistent.
> In a config file case (no directory), the opening failure gives only
> the error message but it continues.  In the case of directory, both
> the open-error and the parse-error are treated as the fatal error.

Ahh right, yeah, I need to reset err = 0 after the SND_ERR message in
that case. Good catch.

> OK, it's basically a mistake in the original code -- the open-error
> should be handled as a fatal error more consistently.  But, still,
> the old error code was overridden by the new entry, so the error in
> the middle of the file-entry loop is ignored.  That looks no good.

ACK

> And, the code becomes with too deep indentation.  This indicates
> already something wrong.  Split a new function to handle the directory
> case.  And create a small function to handle below code:
> 
> 	err = snd_input_stdio_open(&in, filename, "r");
> 	if (err >= 0) {
> 		err = snd_config_load(root, in);
> 		snd_input_close(in);
> 		if (err < 0)
> 			SNDERR("%s may be old or corrupted: consider to remove or fix it", filename);
> 	} else
> 		SNDERR("cannot access file %s", filename);
> 	return err;
> 
> and use it from both a single file and files-in-directory cases.

Cool will do. Was going to do that anyway, but wasn't sure if the amount
of code was over the "threshold" for a separate function :) (I
appreciate that the "threshold" is very subjective.

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
