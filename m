From: Garett Shulman <shulmang@colorado.edu>
Subject: ice1712 dshare asoundrc
Date: Thu, 20 Nov 2003 15:47:01 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FBD4465.8070800@colorado.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I would really like to do hardware mixing since my card should support 
it. I have been hacking away trying to google and decypher the plugin 
docs and have created the following asoundrc. However, when I try to run 
a second instance of fluidsynth on 44_2 I get the following error:
ALSA lib pcm_dshare.c:800:(snd_pcm_dshare_open) destination channel 
specified in bindings is alread used. I'm not sure what I'm doing wrong. 
Is alsa simply not capable of taking advantage of the ice1712 hardware 
mixer? Here is the asoundrc I have so far.

pcm.44_dshare {
	type dshare
	ipc_key 42892323
	ipc_key_add_uid yes
	slave {
		pcm "hw:0,0"
		period_time 0
		period_size 70
		periods 24
		buffer_size 1024
		channels 10
	}
	bindings {
	0 0
	1 1
	2 2
	3 3
	}
}

pcm.44_1 {
	type plug
	ttable.0.0 1
	ttable.0.1 1
	slave.pcm 44_dshare
}

pcm.44_2 {
	type plug
	ttable.0.2 1
	ttable.0.3 1
	slave.pcm 44_dshare
}



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
