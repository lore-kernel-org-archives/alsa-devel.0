From: Sindre =?iso-8859-1?b?QWFt5XM=?= <aamas@stud.ntnu.no>
Subject: Re: snd_pcm_avail_update returns bogus values with	the
	OSS	PCM plugin
Date: Fri, 17 Jul 2009 21:50:15 +0200
Message-ID: <20090717215015.jbhnniazpwso048k@webmail.ntnu.no>
References: <20090710102955.eaqs4fpsows0swwg@webmail.ntnu.no>
	<s5htz1b8w1y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bene1.itea.ntnu.no (bene1.itea.ntnu.no [129.241.56.56])
	by alsa0.perex.cz (Postfix) with ESMTP id C3661103913
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 21:50:17 +0200 (CEST)
In-Reply-To: <s5htz1b8w1y.wl%tiwai@suse.de>
Content-Disposition: inline
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

Quoting Takashi Iwai <tiwai@suse.de>:

> At Fri, 10 Jul 2009 10:29:55 +0200,
> Sindre Aam=E5s wrote:
>>
>> Hi.
>>
>> For the attached test case snd_pcm_avail_update returns values higher
>> than the buffer size when run with the OSS PCM plugin. Output of
>> alsa-info.sh is at
>> http://www.alsa-project.org/db/?f=3D77a873e55d5d6ca50d67a035a9d6b7e10cca=
179d .
>
> This is obviously a bug in OSS plugin (who thought of using this
> plugin seriously? :)
>
> The oneliner below should fix the problem.
>
>
> thanks,
>
> Takashi
>
> ---

Thanks! That largely fixes it.

There's still a problem when OSS doesn't support the requested
period size, however. It tends to use a larger fragment size if
the one requested is too small. The real fragment size isn't
generally returned by SNDCTL_DSP_SETFRAGMENT, but needs to be
queried for with SNDCTL_DSP_GETOSPACE/SNDCTL_DSP_GETISPACE.

There may not be a nice solution for this, since there's no way
to get a list/range of supported fragment sizes. It's a bit
troublesome though, as it seems ALSA picks a small period size
if it can, and the minimum allowed by the OSS plugin is often
smaller than OSS supports, which means that all clients that
don't restrict the minimum period size will typically be
affected.

thanks,
Sindre
