From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: es1978 maestro-2e-rev10
Date: Mon, 26 Aug 2002 18:34:44 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0208261829130.27110-100000@aino.wakkanet.fi>
References: <4EFAB02CD1631648856752B7E482C9A312CA55@esebe003.ntc.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4EFAB02CD1631648856752B7E482C9A312CA55@esebe003.ntc.nokia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:

>  --- Kai Vehmanen <kai.vehmanen@wakkanet.fi> schrieb:
>> "arecord: pcm_params.c:1051:
>> _snd_pcm_hw_param_refine: Assertion '0' 
>> failed."
> i get here lots of:
> arecord: pcm_plug.c:68: snd_pcm_plug_close: Assertion
> `plug->slave == plug->req_slave' failed.

Yup, exactly the same problem. After the "Assertion '0' failed"  error I
also start getting these pcm_plug.c:68 errors.

> usind snd-es1968 from rc3. you use that module with
> 2.4.18?

Yes, the same module. It seems like recording doesn't currently work with
snd-es1978. I also tried recording with ecasound using noninterleaved
access diretly with hw:0 (ie. no plugin layer), but still no success. With
ecasound snd_pcm_readn() returns with an error (of course I didn't write
down which error :( ...).

--
 http://www.eca.cx
 Audio software for Linux!




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
