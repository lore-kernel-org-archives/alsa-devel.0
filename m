From: Andy Lo-A-Foe <andy@alsaplayer.org>
Subject: Re: seg fault
Date: Tue, 18 Jun 2002 22:27:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020618202738.GA10337@orbital.xs4all.nl>
References: <20020618175932.0bc0ad84.mailinglist@dunkfordyce.co.uk> <20020618174425.GA1730@orbital.xs4all.nl> <20020618194759.4b012083.mailinglist@dunkfordyce.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020618194759.4b012083.mailinglist@dunkfordyce.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: him@dunkfordyce.co.uk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 18, 2002 at 07:47:59PM +0200, dunk fordyce wrote:

> now im wondering whats the best way to play multiple samples at once?

That would require mixing the different samples (i.e. adding the pcm
values and doing clipping).

// 16-bit samples,
int16_t buf1[1024], buf2[1024], out[1024];
int32_t mix; 

while (...) { // Do as long as there are samples available
	// Fill buf1 and buf2 with PCM data from different samples
	for (int c=0; c < 1024; c++) {
		mix = buf1[c] + buf2[c];
		if (mix > 32768)
			out[c] = 32768;
		else if (mix < -32767)
			out[c] = -32767;
		else out[c] = (int16_t)mix;
	}	
	snd_pcm_writei(sound_handle, out, sizeof(out));
}

The above is just psuedo code. You can also look at somethink like JACK 
(http://jackit.sf.net) if you prefer a callback driven interface.

Good luck,
Andy

----------------------------------------------------------------------------
                   Bringing you mounds of caffeinated joy
                   >>>     http://thinkgeek.com/sf    <<<
