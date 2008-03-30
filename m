From: rct@frus.com (Bob Tracy)
Subject: Re: [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Sun, 30 Mar 2008 16:18:48 -0500 (CDT)
Message-ID: <20080330211848.60C94DBA2@gherkin.frus.com>
References: <2C0A0DF6-7FD6-4444-A485-C0828E40F427@orcon.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gherkin.frus.com (gherkin.frus.com [192.158.254.49])
	by alsa0.perex.cz (Postfix) with ESMTP id 649EF2467C
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Mar 2008 23:18:50 +0200 (CEST)
In-Reply-To: <2C0A0DF6-7FD6-4444-A485-C0828E40F427@orcon.net.nz>
	"from Michael Cree at Mar 31, 2008 10:11:38 am"
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Michael Cree <mcree@orcon.net.nz>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Krzysztof Helt <krzysztof.h1@wp.pl>, Takashi Iwai <tiwai@suse.de>, Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org, Bob Tracy <rct@frus.com>
List-Id: alsa-devel@alsa-project.org

Michael Cree wrote:
> Bob
> >> (miata_no_mmap.diff patch)
> >
> > Made no difference for any of the "sox" tests, and "play" is still
> > broken in the way it always has been.  However, "aplay" generated an
> > interesting error I haven't seen before:
> >
> > $ aplay asskickd.wav
> > Playing WAVE 'asskickd.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
> > ALSA lib pcm_plug.c:773:(snd_pcm_plug_hw_refine_schange) Unable to  
> > find an usable access for 'default'
> > aplay: aplay.c:919: set_params: Assertion `err >= 0' failed.
> 
> Add in the "-D hw" option to the aplay command when using the mmap  
> disabled alsa sound.

Thanks!  I now get "Maybe yo<>Maybe yo<>Maybe yo<>Maybe yo..." in an
endlessly repeating loop.  <ctrl>C is sufficient to stop playback,
however.  Still no activity on IRQ 5 seen by the ES18xx driver.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
