From: "Jon Webb" <jon.a.webb@verizon.net>
Subject: Resetting audio device with ALSA
Date: Fri, 25 Oct 2002 12:47:03 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBKIJJGLFEOIAKKJICMEHMDDAA.jon.a.webb@verizon.net>
References: <02060613013400.00759@linux>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <02060613013400.00759@linux>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello, I'm having trouble with resetting an ALSA audio device (an RME 9652
Hammerfall card) when the audio input buffer overflows. I'm using the
following code:
	rc = snd_pcm_drain(pcmIn);
	rc = snd_pcm_prepare(pcmIn);
	rc = snd_pcm_start(pcmIn);
where pcmIn is a snd_pcm_t* variable that's been initialized by
snd_pcm_open. I don't usually any problems reading from the device using the
same variable, and the return code from the above calls is always zero, but
it appears that once my audio input buffer overflows, I can never get going
again--it just keeps overflowing (snd_pcm_readn returns -EPIPE). Any ideas
what I'm doing wrong?

Jon Webb
pingAUDIO



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
