From: Dirk Jagdmann <doj@cubic.org>
Subject: Re: snd_pcm_writei is stuck with EPIPE
Date: Sat, 13 Nov 2004 18:17:30 +0100
Message-ID: <419641AA.5010209@cubic.org>
References: <20041113062447.51636.qmail@web60404.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041113062447.51636.qmail@web60404.mail.yahoo.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Zaitcev <zaitcev@yahoo.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I am attaching a patch and audio_alsa.c file itself in case anyone
> is curious.

I am curious, but can't compile this. I have ALSA 1.0.6 running and this 
gives me the following error:

audio_alsa.c: In function `audio_open':
audio_alsa.c:48: error: structure has no member named `params'
audio_alsa.c: In function `audio_set_playback_params':
audio_alsa.c:66: error: structure has no member named `params'
audio_alsa.c: In function `audio_get_formats':
audio_alsa.c:244: error: structure has no member named `params'
audio_alsa.c:245: error: structure has no member named `params'
audio_alsa.c: In function `audio_close':
audio_alsa.c:277: error: structure has no member named `params'

-- 
---> doj / cubic
----> http://cubic.org/~doj
-----> http://llg.cubic.org


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
