From: Friedrich.Ewaldt@gmx.de
Subject: setting period size for Terratec Xfire (=CS46xx) => only 512 possible?
Date: Tue, 25 Jun 2002 19:06:43 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20570.1025024803@www35.gmx.net>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm using a Terratex DMX Xfire soundcard (based on the Cirrus CS4624) on my
Mandrake 8.1 PC. 
I've written a small real-time program using the ALSA-API (capturing from
the input of the card, processing the samples in some way and playing them
through the output of the soundcard). (The CPU load caused by this program is
about 1%.)

I've written the following to set the period size of the capture device (and
the same for the playback device as well):

	chunk_size = snd_pcm_hw_params_set_period_size_near(handle, hwparams,
chunk_size_w, 0);
	if (chunk_size < 0){
		fprintf(stderr, "error setting period size: %s\n", snd_strerror(err));
	  return -1;
	}

As the program causes broken pipe errors sometimes, I tried to increase the
period size.
But using my soundcard I always get a period size of 512. I've tried several
device definitions like hw:0,0 and plughw:0,0, but no success. I've used a
buffer size of 1024 or 16384 in my experiments.
Using another PC using a Ensoniq AudioPCI ES1371 soundcard I can set the
period size to e.g. 1024 without any problems or changes to my source code.

Is this a problem regarding the CS46xx driver or do I have to change my
program code?

Thanks for any help!
fe3

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by: Jabber Inc.
Don't miss the IM event of the season | Special offer for OSDN members! 
JabConf 2002, Aug. 20-22, Keystone, CO http://www.jabberconf.com/osdn
