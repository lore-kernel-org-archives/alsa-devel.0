From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Minimum Period-(Fragment) Size
Date: Thu, 25 Mar 2004 12:24:52 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040325122452.pochini@shiny.it>
References: <20040324135629.56575.qmail@web25102.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040324135629.56575.qmail@web25102.mail.ukl.yahoo.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Cc: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 24-Mar-2004 Brian Furey wrote:
> Hi all,
> im using the ALSA driver 1.0.0 on two linux machines that connect a
> voice-over-ip session. I need to know the minimum fragment size that
> the alsa driver can take from the soundcard and place in the
> sending/receiving buffer. Does it depend on the speed that the
> soundcard is operating at?

It may depend on any thing. Set buffer size and period
size with one of these and use the value they return:

snd_pcm_hw_params_set_buffer_size_near()
snd_pcm_hw_params_set_period_size_near()
snd_pcm_hw_params_set_buffer_time_near()
snd_pcm_hw_params_set_period_time_near()

Look here for more infos:
http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html


--
Giuliano.


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
