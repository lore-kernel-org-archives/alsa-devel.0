From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PCM parameters in file plugin
Date: Tue, 6 Jan 2009 11:31:02 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0901061128300.8273@tm8103.perex-int.cz>
References: <49627395.1090506@insite.cz> <49632995.9000109@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 191D92434B
	for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2009 11:31:04 +0100 (CET)
In-Reply-To: <49632995.9000109@insite.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@insite.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 6 Jan 2009, Pavel Hofman wrote:

> Pavel Hofman napsal(a):
> > Hello,
> > 
> > I am working on a file plugin patch to allow adding PCM parameters 
> > (rate, format) to  the name of the file created (plus the ability to run 
> > an external command via popen, such as upsampling with sox). I got stuck 
> > in trying to obtain these parameters in pcm_file.c:_snd_pcm_file_open(). 
> > Is it actually possible or the information is not available at the time 
> > of opening the file (and the whole patch is thus nonsense)?
> > 
> > Thanks a lot for help.
> > 
> 
> I am now opening the output file in pcm_file.c:snd_pcm_file_write_bytes.
> Surprisingly it seems to work fine. Could such hack be accepted as a
> patch to the plugin (if coded properly)? Is there a better place to open 
> the file?

The file should be opened in the hw_params callback (all PCM parameters 
are known in this time). Also, extending filename with PCM parameters 
should be optional (configurable). But the idea looks nice.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
