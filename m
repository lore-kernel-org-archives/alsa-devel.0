From: Friedrich.Ewaldt@gmx.de
Subject: Re: Re: SNDRV_PCM_IOCTL_HW_FREE failed
Date: Wed, 14 Aug 2002 13:04:51 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <19329.1029323091@www21.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I've got a somewhat similar problem using the Alsa copy plugin with
BruteFIR: Using an Alsa "copy" device (copy definition with slave pcm,... in
asoundrc), I get 

ALSA lib pcm_hw.c:384:(snd_pcm_hw_start) SNDRV_PCM_IOCTL_START failed: File
descriptor in bad state

BruteFIR 0.99 runs through all hw_param and sw_param settings without errors
but when it  calls snd_pcm_hw_start, it fails. This error does not occur
when I use the hw device directly. The problem seems not to be hardware related,
as I tested different soundcards with the same result (have a look at
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg04080.html)

Any idea what could be the reason for this?

regards,
fritz_e

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
