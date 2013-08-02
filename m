From: Kai Vehmanen <kvlists@nosignal.fi>
Subject: Re: end of playback ... design question
Date: Fri, 2 Aug 2013 22:20:23 +0300 (EEST)
Message-ID: <alpine.DEB.2.00.1308022130520.2634@ecabase.localdomain>
References: <51F9144F.9080807@t-online.de> <51F91A34.5070302@perex.cz>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED;
 BOUNDARY="-1463811582-519071825-1375468777=:2634"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tulikuusama.dnainternet.net (tulikuusama.dnainternet.net
 [83.102.40.132])
 by alsa0.perex.cz (Postfix) with ESMTP id DAC6226565E
 for <alsa-devel@alsa-project.org>; Fri,  2 Aug 2013 13:28:45 +0200 (CEST)
In-Reply-To: <51F91A34.5070302@perex.cz>
Content-ID: <alpine.DEB.2.00.1308022140130.2634@ecabase.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Knut Petersen <Knut_Petersen@t-online.de>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811582-519071825-1375468777=:2634
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; FORMAT=flowed
Content-ID: <alpine.DEB.2.00.1308022140131.2634@ecabase.localdomain>
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 31 Jul 2013, Jaroslav Kysela wrote:

>> E: The alsa core could detect that condition and solve it equivalent t=
o solution D
>>
>>       I think that=B4s the proper solution.
>>
>> Did I miss something or do you agree?
>
> Please, see snd_pcm_sw_params_set_silence_threshold() /
> snd_pcm_sw_params_set_silence_size() .

thanks Knut for investigating this.

Ecasound started to use snd_pcm_drain() fairly recently (in 2.8.0) and as=
=20
discovered by Knut, the usage was not quite correct. Drain was run with=20
same settings as normal playback (stop_threshold=3D=3Dbuffer_size, silenc=
e=20
threshold set to disabled), and this caused issues with drain as stale=20
data sometimes got out at the end.

We now resolved the issue with following code (run at the end of=20
playback):

  snd_pcm_sw_params_set_silence_threshold(handle, params, 0);
  snd_pcm_sw_params_set_silence_size(handle, params, boundary);
  snd_pcm_sw_params(handle, params);
  snd_pcm_drain(handle); /* in blocking mode */

... now this does what I was mistakenly assuming snd_pcm_drain() would do
implicitly.

This seems a bit complicated from API usage point of view (reconfiguring=20
sw-params for drain), but OTOH is aligned with the rest of the API. As ap=
p=20
has full control over sw-params, I can imagine that it would be suprising=
=20
as well if snd_pcm_drain() would change sw_params under the hood (even if=
=20
convenient).
---1463811582-519071825-1375468777=:2634
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


---1463811582-519071825-1375468777=:2634--
