From: =?iso-8859-1?q?Brian=20Furey?= <brianmfurey@yahoo.co.uk>
Subject: Driver hardw + softw  parameters
Date: Fri, 2 Apr 2004 13:02:56 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040402120256.14695.qmail@web25102.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA LIST <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi All,
   still trying to get the hardware and software
runtime paramters of the driver...
  In alsa-driver*/alsa-kernel/core there is the pcm.c
file.
  There are 2 functions in this file
snd_pcm_substream_proc_hw_params_read
and
snd_pcm_substream_proc_sw_params_read

Both of these print out to some output source the
information I need using i.e.

  snd_iprintf(buffer, "period_size: %lu\n",
runtime->period_size);

snd_iprintf is in /alsa-driver/alsa-kernel/info.c

I traced this snd_iprintf function and it passes its
data in a buffer to the function vsnprintf(..).
Could someone enlighten me as to where it write
to...console, file, temporary storage


thanx,
Brian.



	
	
		
___________________________________________________________
WIN FREE WORLDWIDE FLIGHTS - nominate a cafe in the Yahoo! Mail Internet Cafe Awards  www.yahoo.co.uk/internetcafes 


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
