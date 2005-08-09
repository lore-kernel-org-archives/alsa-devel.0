From: Tehn Yit Chin <tehn-yit.chin@greyinnovation.com>
Subject: Re: Skinny (and very skinny) digital packaging
Date: Wed, 10 Aug 2005 09:09:13 +1000
Message-ID: <42F93799.4080401@greyinnovation.com>
References: <42F929AE.3010703@redfish-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from greyinnovation.com (246.063.dsl.mel.iprimus.net.au [211.27.107.246])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31F421F3
	for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2005 01:06:34 +0200 (MEST)
In-Reply-To: <42F929AE.3010703@redfish-solutions.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Philip Prindeville <philipp_subx@redfish-solutions.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Philip,

I would be interested in something like this in ALSA. As an example, 
most of our embedded devices only have a PCM playback at one volume 
setting, so I only really need the PCM playback, none of the mixing or 
capturing or analogue partions etc of ALSA.

Also our embedded devices are usually resource limited, so smaller is 
better for us.

I understand that your idea surrounds only the digital portion of ALSA, 
but I think that the idea can be extended to the rest of ALSA's components.

cheers,
Tehn Yit Chin

Philip Prindeville wrote:

> As more and more hardware supports digital input and/or output
> (more often output than input), I was wondering if it makes sense
> to offer a build/packaging option of "skinny digital", which would
> entail omitting all of the analogue portions of the driver, the
> config files, and the various utilities (or the utilities could detect 
> that
> no analogue hardware support is present and simply disable it).
>
> The idea being that if someone wanted to have a bare bones (pardon
> the pun) installation that supported digital output only (or digital
> input and output) with no need for analogue mixing or analogue
> source routing, then they could do so with a minimum configuration.
> Why?  Well, the less there is to configure, the less that can go wrong...
> and since all digital media (CD, DVD, digital satellite tuners, ATSC,
> etc) is more and more common, people probably have little or no need
> for analogue functionality these days.
>
> So the installer portions of the makefiles would need to be changed
> to understand a digital only install, the source configuration files
> could be tweaked to allow preprocessing via m4 or cpp, and the
> drivers and libraries could be made conditional to omit the code
> that handles analogue functionality.
>
> Initialization too might need to change the default settings to be
> digital...
>
> What does everyone think?  Comments?  Am I off in left field?
>
> Thanks,
>
> -Philip
>
>
>
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle 
> Practices
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing 
> & QA
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>


-- 
Tehn Yit Chin
Software Engineer, Grey Innovation Pty. Ltd.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
